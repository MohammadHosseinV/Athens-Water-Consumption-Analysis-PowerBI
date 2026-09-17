
-- The cleaned-table grain must be unique

SELECT
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS DuplicateCount
FROM [tr].[WaterConsumptionCleaned]
GROUP BY
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1;