SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT_BIG(*) AS TargetRowCount
FROM [tr].[WaterConsumptionAggregated]  
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT_BIG(*) > 1
ORDER BY
    TargetRowCount DESC,
    ConsumptionMonth,
    PostalCode,
    AreaEnglish,
    Zone;