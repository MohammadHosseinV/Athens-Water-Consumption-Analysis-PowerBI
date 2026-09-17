--Null_And_Blank_Count_WaterConsumptionAggregated
SELECT
    COUNT_BIG(*) AS TotalRows,

    SUM(CASE
            WHEN PostalCode IS NULL THEN 1
            ELSE 0
        END) AS PostalCode_NullCount,

    SUM(CASE
            WHEN NULLIF(LTRIM(RTRIM(AreaGreek)), '') IS NULL THEN 1
            ELSE 0
        END) AS AreaGreek_NullOrBlankCount,

    SUM(CASE
            WHEN NULLIF(LTRIM(RTRIM(AreaEnglish)), '') IS NULL THEN 1
            ELSE 0
        END) AS AreaEnglish_NullOrBlankCount,

    SUM(CASE
            WHEN NULLIF(LTRIM(RTRIM(Zone)), '') IS NULL THEN 1
            ELSE 0
        END) AS Zone_NullOrBlankCount,

    SUM(CASE
            WHEN TotalConsumption IS NULL THEN 1
            ELSE 0
        END) AS TotalConsumption_NullCount,

    SUM(CASE
            WHEN ConsumptionDays IS NULL THEN 1
            ELSE 0
        END) AS ConsumptionDays_NullCount,

    SUM(CASE
            WHEN AverageDailyConsumption IS NULL THEN 1
            ELSE 0
        END) AS AverageDailyConsumption_NullCount,

    SUM(CASE
            WHEN NumberOfConnections IS NULL THEN 1
            ELSE 0
        END) AS NumberOfConnections_NullCount,

    SUM(CASE
            WHEN ConsumptionMonth IS NULL THEN 1
            ELSE 0
        END) AS ConsumptionMonth_NullCount
FROM [tr].[WaterConsumptionAggregated];  



--Null_And_Blank_Count_WaterConsumptionCleaned
SELECT
    COUNT_BIG(*) AS TotalRows,

    SUM(CASE
            WHEN PostalCode IS NULL THEN 1
            ELSE 0
        END) AS PostalCode_NullCount,

    SUM(CASE
            WHEN NULLIF(LTRIM(RTRIM(AreaGreek)), '') IS NULL THEN 1
            ELSE 0
        END) AS AreaGreek_NullOrBlankCount,

    SUM(CASE
            WHEN NULLIF(LTRIM(RTRIM(AreaEnglish)), '') IS NULL THEN 1
            ELSE 0
        END) AS AreaEnglish_NullOrBlankCount,

    SUM(CASE
            WHEN NULLIF(LTRIM(RTRIM(Zone)), '') IS NULL THEN 1
            ELSE 0
        END) AS Zone_NullOrBlankCount,

    SUM(CASE
            WHEN TotalConsumption IS NULL THEN 1
            ELSE 0
        END) AS TotalConsumption_NullCount,

    SUM(CASE
            WHEN ConsumptionDays IS NULL THEN 1
            ELSE 0
        END) AS ConsumptionDays_NullCount,

    SUM(CASE
            WHEN AverageDailyConsumption IS NULL THEN 1
            ELSE 0
        END) AS AverageDailyConsumption_NullCount,

    SUM(CASE
            WHEN NumberOfConnections IS NULL THEN 1
            ELSE 0
        END) AS NumberOfConnections_NullCount,

    SUM(CASE
            WHEN ConsumptionMonth IS NULL THEN 1
            ELSE 0
        END) AS ConsumptionMonth_NullCount
FROM [tr].[WaterConsumptionCleaned];  