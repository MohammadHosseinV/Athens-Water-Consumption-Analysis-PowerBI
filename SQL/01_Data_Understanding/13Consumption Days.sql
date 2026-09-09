SELECT
    MIN(ConsumptionDays) AS MinDays,
    MAX(ConsumptionDays) AS MaxDays,
    AVG(ConsumptionDays) AS AvgDays
FROM stg.WaterConsumption_Translation_2021_2022

--And

SELECT
    MIN(ConsumptionDays) AS MinDays,
    MAX(ConsumptionDays) AS MaxDays,
    AVG(ConsumptionDays) AS AvgDays
FROM stg.WaterConsumption_Translation_2023_2025

