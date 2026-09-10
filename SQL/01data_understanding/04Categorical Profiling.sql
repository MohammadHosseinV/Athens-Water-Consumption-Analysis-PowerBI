SELECT
    Zone AS ConsumptionClass,
    COUNT(*) AS RCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY Zone
ORDER BY Zone;

SELECT
    Zone AS ConsumptionClass,
    COUNT(*) AS RCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY Zone
ORDER BY Zone;
