SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS RecordCount,
    COUNT(DISTINCT AreaGreek) AS DistinctAreaGreek,
    COUNT(DISTINCT TotalConsumption) AS DistinctConsumption,
    COUNT(DISTINCT ConsumptionDays) AS DistinctDays,
    COUNT(DISTINCT NumberOfConnections) AS DistinctConnections,
    COUNT(DISTINCT AverageDailyConsumption) AS DistinctAvgDaily
FROM stg.WaterConsumption_Translation_2023_2025
WHERE PostalCode = '18903'
  AND AreaEnglish = 'AIANTEIO NATO'
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1
ORDER BY ConsumptionMonth;