SELECT
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    NumberOfConnections,
    ConsumptionMonth,

    CASE
        WHEN PostalCode IS NULL THEN 1
        ELSE 0
    END AS HasNullPostalCode,

    CASE
        WHEN NULLIF(LTRIM(RTRIM(AreaGreek)), '') IS NULL THEN 1
        ELSE 0
    END AS HasNullOrBlankAreaGreek,

    CASE
        WHEN NULLIF(LTRIM(RTRIM(AreaEnglish)), '') IS NULL THEN 1
        ELSE 0
    END AS HasNullOrBlankAreaEnglish

FROM [tr].[WaterConsumptionAggregated]  
WHERE
       PostalCode IS NULL
    OR NULLIF(LTRIM(RTRIM(AreaGreek)), '') IS NULL
    OR NULLIF(LTRIM(RTRIM(AreaEnglish)), '') IS NULL
    OR NULLIF(LTRIM(RTRIM(Zone)), '') IS NULL
    OR TotalConsumption IS NULL
    OR ConsumptionDays IS NULL
    OR AverageDailyConsumption IS NULL
    OR NumberOfConnections IS NULL
    OR ConsumptionMonth IS NULL
ORDER BY
    ConsumptionMonth,
    PostalCode,
    AreaEnglish,
    Zone;