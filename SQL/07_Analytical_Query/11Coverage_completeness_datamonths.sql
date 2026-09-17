

;WITH MonthlyCoverage AS
(
    SELECT
        f.DateKey,

        DATEFROMPARTS(
            f.DateKey / 100,
            f.DateKey % 100,
            1
        ) AS MonthStartDate,

        COUNT_BIG(*) AS FactRowCount,
        COUNT(DISTINCT f.GeographyKey) AS GeographyCount,
        COUNT(DISTINCT f.ZoneKey) AS ZoneCount,
        SUM(f.TotalConsumption) AS TotalMonthlyConsumption

    FROM dw.FactWaterConsumption AS f

    GROUP BY
        f.DateKey
),
CoverageSummary AS
(
    SELECT
        MIN(MonthStartDate) AS MinimumMonth,
        MAX(MonthStartDate) AS MaximumMonth,
        COUNT(*) AS ActualMonthCount,

        DATEDIFF(
            MONTH,
            MIN(MonthStartDate),
            MAX(MonthStartDate)
        ) + 1 AS ExpectedMonthCount

    FROM MonthlyCoverage
)
SELECT
    mc.DateKey,
    mc.MonthStartDate,
    mc.FactRowCount,
    mc.GeographyCount,
    mc.ZoneCount,
    mc.TotalMonthlyConsumption,

    cs.MinimumMonth,
    cs.MaximumMonth,
    cs.ActualMonthCount,
    cs.ExpectedMonthCount,

    cs.ExpectedMonthCount - cs.ActualMonthCount
        AS MissingMonthCount,

    CASE
        WHEN cs.ActualMonthCount = cs.ExpectedMonthCount
            THEN 'Complete Month Range'
        ELSE 'Missing Month Detected'
    END AS MonthRangeStatus

FROM MonthlyCoverage AS mc

CROSS JOIN CoverageSummary AS cs

ORDER BY
    mc.DateKey;