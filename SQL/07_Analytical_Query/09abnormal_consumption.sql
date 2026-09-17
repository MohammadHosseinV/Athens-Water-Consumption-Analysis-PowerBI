/*==============================================================
  Analytical Query 09
  Monthly Consumption Anomaly Detection
==============================================================*/

;WITH MonthlyConsumption AS
(
    SELECT
        f.DateKey,

        DATEFROMPARTS(
            f.DateKey / 100,
            f.DateKey % 100,
            1
        ) AS MonthStartDate,

        SUM(f.TotalConsumption) AS TotalMonthlyConsumption

    FROM dw.FactWaterConsumption AS f

    GROUP BY
        f.DateKey
),
RollingStatistics AS
(
    SELECT
        DateKey,
        MonthStartDate,
        TotalMonthlyConsumption,

        COUNT(*) OVER
        (
            ORDER BY DateKey
            ROWS BETWEEN 12 PRECEDING AND 1 PRECEDING
        ) AS BaselineMonthCount,

        AVG(CAST(TotalMonthlyConsumption AS DECIMAL(28, 4))) OVER
        (
            ORDER BY DateKey
            ROWS BETWEEN 12 PRECEDING AND 1 PRECEDING
        ) AS Previous12MonthAverage,

        STDEV(CAST(TotalMonthlyConsumption AS DECIMAL(28, 4))) OVER
        (
            ORDER BY DateKey
            ROWS BETWEEN 12 PRECEDING AND 1 PRECEDING
        ) AS Previous12MonthStandardDeviation

    FROM MonthlyConsumption
)
SELECT
    DateKey,
    MonthStartDate,
    TotalMonthlyConsumption,
    BaselineMonthCount,

    CAST(
        Previous12MonthAverage
        AS DECIMAL(18, 2)
    ) AS Previous12MonthAverage,

    CAST(
        TotalMonthlyConsumption - Previous12MonthAverage
        AS DECIMAL(18, 2)
    ) AS DifferenceFromHistoricalAverage,

    CAST(
        (
            TotalMonthlyConsumption
            - Previous12MonthAverage
        ) / NULLIF(Previous12MonthStandardDeviation, 0)
        AS DECIMAL(18, 2)
    ) AS ConsumptionZScore,

    CASE
        WHEN BaselineMonthCount < 6
            THEN 'Insufficient History'

        WHEN ABS(
            (
                TotalMonthlyConsumption
                - Previous12MonthAverage
            ) / NULLIF(Previous12MonthStandardDeviation, 0)
        ) >= 2
            THEN 'Potential Anomaly'

        ELSE 'Normal Range'
    END AS AnomalyStatus

FROM RollingStatistics

ORDER BY
    DateKey;