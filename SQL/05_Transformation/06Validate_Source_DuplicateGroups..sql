;WITH SourceData AS
(
    SELECT
        PostalCode,
        AreaEnglish,
        Zone,
        ConsumptionMonth
    FROM [stg].[WaterConsumption_Translation_2021_2022]

    UNION ALL

    SELECT
        PostalCode,
        AreaEnglish,
        Zone,
        ConsumptionMonth
    FROM [stg].[WaterConsumption_Translation_2023_2025]
),
DuplicateGroups AS
(
    SELECT
        PostalCode,
        AreaEnglish,
        Zone,
        ConsumptionMonth,
        COUNT_BIG(*) AS RawRowCount
    FROM SourceData
    GROUP BY
        PostalCode,
        AreaEnglish,
        Zone,
        ConsumptionMonth
    HAVING COUNT_BIG(*) > 1
)
SELECT
    COUNT_BIG(*) AS DuplicateGroupCount,
    SUM(RawRowCount) AS RawRowsInsideDuplicateGroups,
    SUM(RawRowCount - 1) AS RowsReducedByMerge,
    260138 - SUM(RawRowCount - 1) AS ExpectedTargetRowCount
FROM DuplicateGroups;