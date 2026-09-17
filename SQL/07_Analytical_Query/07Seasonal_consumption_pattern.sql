

;WITH MonthlyConsumption AS
(
    SELECT
        f.DateKey,
        f.DateKey % 100 AS MonthNumber,
        SUM(f.TotalConsumption) AS TotalMonthlyConsumption

    FROM dw.FactWaterConsumption AS f

    GROUP BY
        f.DateKey
)
SELECT
    MonthNumber,

    CASE MonthNumber
        WHEN 1  THEN 'January'
        WHEN 2  THEN 'February'
        WHEN 3  THEN 'March'
        WHEN 4  THEN 'April'
        WHEN 5  THEN 'May'
        WHEN 6  THEN 'June'
        WHEN 7  THEN 'July'
        WHEN 8  THEN 'August'
        WHEN 9  THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS MonthName,

    COUNT(*) AS AvailableYearCount,

    CAST(
        AVG(CAST(TotalMonthlyConsumption AS DECIMAL(28, 4)))
        AS DECIMAL(18, 2)
    ) AS AverageMonthlyConsumption,

    MIN(TotalMonthlyConsumption) AS MinimumMonthlyConsumption,
    MAX(TotalMonthlyConsumption) AS MaximumMonthlyConsumption

FROM MonthlyConsumption

GROUP BY
    MonthNumber

ORDER BY
    MonthNumber;