SELECT
    NumberOfConnections,
    ConsumptionDays,
    COUNT(*) AS ZeroConsumptionRows
FROM stg.WaterConsumption_Translation_2021_2022
WHERE TotalConsumption = 0
GROUP BY
    NumberOfConnections,
    ConsumptionDays
ORDER BY
    NumberOfConnections,
    ConsumptionDays;


	--And

	SELECT
    NumberOfConnections,
    ConsumptionDays,
    COUNT(*) AS ZeroConsumptionRows
FROM stg.WaterConsumption_Translation_2023_2025
WHERE TotalConsumption = 0
GROUP BY
    NumberOfConnections,
    ConsumptionDays
ORDER BY
    NumberOfConnections,
    ConsumptionDays;
