;WITH RowCounts AS
(
    SELECT
        COUNT_BIG(*) AS Source2021_2022_RowCount
    FROM [stg].[WaterConsumption_Translation_2021_2022]
),
RowCounts2 AS
(
    SELECT
        COUNT_BIG(*) AS Source2023_2025_RowCount
    FROM [stg].[WaterConsumption_Translation_2023_2025]
),
TargetCount AS
(
    SELECT
        COUNT_BIG(*) AS TargetRowCount
    FROM [tr].[WaterConsumptionAggregated]  
)
SELECT
    r1.Source2021_2022_RowCount,
    r2.Source2023_2025_RowCount,

    r1.Source2021_2022_RowCount
        + r2.Source2023_2025_RowCount AS TotalSourceRows,

    t.TargetRowCount,

    (
        r1.Source2021_2022_RowCount
        + r2.Source2023_2025_RowCount
    ) - t.TargetRowCount AS RowsReducedByMerge
FROM RowCounts AS r1
CROSS JOIN RowCounts2 AS r2
CROSS JOIN TargetCount AS t;