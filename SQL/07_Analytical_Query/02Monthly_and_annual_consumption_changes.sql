

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
)
SELECT
    current_month.DateKey,
    current_month.MonthStartDate,
    current_month.TotalMonthlyConsumption,

    previous_month.TotalMonthlyConsumption
        AS PreviousMonthConsumption,

    current_month.TotalMonthlyConsumption
        - previous_month.TotalMonthlyConsumption
        AS MonthlyConsumptionDifference,

    CAST(
        (
            current_month.TotalMonthlyConsumption
            - previous_month.TotalMonthlyConsumption
        ) * 100.0
        / NULLIF(previous_month.TotalMonthlyConsumption, 0)
        AS DECIMAL(18, 2)
    ) AS MonthOverMonthChangePercent,

    previous_year.TotalMonthlyConsumption
        AS SameMonthPreviousYearConsumption,

    current_month.TotalMonthlyConsumption
        - previous_year.TotalMonthlyConsumption
        AS YearlyConsumptionDifference,

    CAST(
        (
            current_month.TotalMonthlyConsumption
            - previous_year.TotalMonthlyConsumption
        ) * 100.0
        / NULLIF(previous_year.TotalMonthlyConsumption, 0)
        AS DECIMAL(18, 2)
    ) AS YearOverYearChangePercent

FROM MonthlyConsumption AS current_month

LEFT JOIN MonthlyConsumption AS previous_month
    ON previous_month.MonthStartDate =
       DATEADD(MONTH, -1, current_month.MonthStartDate)

LEFT JOIN MonthlyConsumption AS previous_year
    ON previous_year.MonthStartDate =
       DATEADD(YEAR, -1, current_month.MonthStartDate)

ORDER BY
    current_month.DateKey;