SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,

    COUNT(*) AS RecordCount,

    COUNT(DISTINCT TotalConsumption) AS DistinctConsumption,
    COUNT(DISTINCT ConsumptionDays) AS DistinctDays,
    COUNT(DISTINCT AverageDailyConsumption) AS DistinctAvgDaily,
    COUNT(DISTINCT NumberOfConnections) AS DistinctConnections

FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth

HAVING COUNT(*) > 1
ORDER BY RecordCount DESC;
