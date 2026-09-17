-- Validation 08
-- Detect partially missing area names

SELECT
    CASE
        WHEN AreaGreek IS NULL AND AreaEnglish IS NOT NULL
            THEN 'Greek Missing Only'
        WHEN AreaGreek IS NOT NULL AND AreaEnglish IS NULL
            THEN 'English Missing Only'
    END AS MissingAreaType,
    COUNT_BIG(*) AS [RowCount]
FROM [tr].[WaterConsumptionCleaned]
WHERE
       (AreaGreek IS NULL AND AreaEnglish IS NOT NULL)
    OR (AreaGreek IS NOT NULL AND AreaEnglish IS NULL)
GROUP BY
    CASE
        WHEN AreaGreek IS NULL AND AreaEnglish IS NOT NULL
            THEN 'Greek Missing Only'
        WHEN AreaGreek IS NOT NULL AND AreaEnglish IS NULL
            THEN 'English Missing Only'
    END;