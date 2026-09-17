/*==============================================================
  Analytical Query 03
  Zone Performance for the Entire Analysis Period
==============================================================*/

;WITH MonthlyZone AS
(
    SELECT
        f.DateKey,
        f.ZoneKey,
        z.ZoneName,

        SUM(f.TotalConsumption) AS MonthlyConsumption,
        SUM(f.ConsumptionDays) AS MonthlyConsumptionDays,
        SUM(f.NumberOfConnections) AS MonthlyConnections

    FROM dw.FactWaterConsumption AS f

    INNER JOIN dw.DimZone AS z
        ON f.ZoneKey = z.ZoneKey

    GROUP BY
        f.DateKey,
        f.ZoneKey,
        z.ZoneName
),
ZoneSummary AS
(
    SELECT
        ZoneKey,
        ZoneName,

        COUNT(*) AS ActiveMonthCount,
        SUM(MonthlyConsumption) AS TotalPeriodConsumption,
        SUM(MonthlyConsumptionDays) AS TotalConsumptionDays,

        AVG(CAST(MonthlyConnections AS DECIMAL(18, 2)))
            AS AverageMonthlyConnections

    FROM MonthlyZone
    GROUP BY
        ZoneKey,
        ZoneName
)
SELECT
    ZoneKey,
    ZoneName,
    ActiveMonthCount,
    TotalPeriodConsumption,

    CAST(
        TotalPeriodConsumption * 1.0
        / NULLIF(TotalConsumptionDays, 0)
        AS DECIMAL(18, 2)
    ) AS RecalculatedAverageDailyConsumption,

    CAST(
        AverageMonthlyConnections
        AS DECIMAL(18, 2)
    ) AS AverageMonthlyConnections,

    DENSE_RANK() OVER
    (
        ORDER BY TotalPeriodConsumption DESC
    ) AS ConsumptionRank

FROM ZoneSummary

ORDER BY
    ConsumptionRank,
    ZoneName;






;WITH MonthlyZone AS
(
    SELECT
        f.DateKey,
        f.ZoneKey,
        z.ZoneName,

        SUM(f.TotalConsumption) AS MonthlyConsumption,
        SUM(f.ConsumptionDays) AS MonthlyConsumptionDays,
        SUM(f.NumberOfConnections) AS MonthlyConnections

    FROM dw.FactWaterConsumption AS f

    INNER JOIN dw.DimZone AS z
        ON f.ZoneKey = z.ZoneKey

    GROUP BY
        f.DateKey,
        f.ZoneKey,
        z.ZoneName
),
ZoneSummary AS
(
    SELECT
        ZoneKey,
        ZoneName,

        COUNT(*) AS ActiveMonthCount,

        SUM(MonthlyConsumption)
            AS TotalPeriodConsumption,

        SUM(MonthlyConsumptionDays)
            AS TotalConsumptionDays,

        AVG(CAST(MonthlyConnections AS DECIMAL(18, 2)))
            AS AverageMonthlyConnections,

        CAST(
            SUM(MonthlyConsumption) * 1.0
            / NULLIF(COUNT(*), 0)
            AS DECIMAL(18, 2)
        ) AS AverageTotalConsumption

    FROM MonthlyZone

    GROUP BY
        ZoneKey,
        ZoneName
)
SELECT
    ZoneKey,
    ZoneName,
    ActiveMonthCount,
    TotalPeriodConsumption,

    AverageTotalConsumption,

    CAST(
        AverageMonthlyConnections
        AS DECIMAL(18, 2)
    ) AS AverageMonthlyConnections,

    DENSE_RANK() OVER
    (
        ORDER BY AverageTotalConsumption DESC
    ) AS ConsumptionRank

FROM ZoneSummary

ORDER BY
    ConsumptionRank,
    ZoneName;