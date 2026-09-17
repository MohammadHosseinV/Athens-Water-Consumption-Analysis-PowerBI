SELECT
    PostalCode,
    AreaGreek,
    AreaEnglish,
    COUNT(*) AS [RowCount]
FROM [tr].[WaterConsumptionCleaned]
WHERE PostalCode = 18903
OR AreaEnglish='AIANTEIO NATO'
GROUP BY
    PostalCode,
    AreaGreek,
    AreaEnglish
ORDER BY AreaGreek;

--
SELECT *
FROM [tr].[WaterConsumptionCleaned]
WHERE AreaGreek LIKE N'%  %';