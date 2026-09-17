
-- Detect invalid numeric or date values

SELECT
    SUM(CASE WHEN TotalConsumption < 0 THEN 1 ELSE 0 END)
        AS NegativeTotalConsumption,

    SUM(CASE WHEN ConsumptionDays < 0 THEN 1 ELSE 0 END)
        AS NegativeConsumptionDays,

    SUM(CASE WHEN NumberOfConnections < 0 THEN 1 ELSE 0 END)
        AS NegativeConnections,

    SUM(CASE WHEN AverageDailyConsumption < 0 THEN 1 ELSE 0 END)
        AS NegativeAverageDailyConsumption,

    SUM(CASE WHEN ConsumptionMonth IS NULL THEN 1 ELSE 0 END)
        AS NullConsumptionMonth,

    SUM(CASE WHEN Zone IS NULL THEN 1 ELSE 0 END)
        AS NullZone,

    SUM(CASE WHEN PostalCode IS NULL THEN 1 ELSE 0 END)
        AS NullPostalCode
FROM [tr].[WaterConsumptionCleaned];