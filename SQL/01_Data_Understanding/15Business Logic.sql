--Consumpotion

SELECT COUNT(*) AS NegativeConsumptionRows
FROM stg.WaterConsumption_Translation_2021_2022
WHERE TotalConsumption < 0;

--And

SELECT COUNT(*) AS NegativeConsumptionRows
FROM stg.WaterConsumption_Translation_2023_2025
WHERE TotalConsumption < 0;


--Zero COnsumption 

SELECT
    COUNT(*) AS ZeroConsumptionRows
FROM stg.WaterConsumption_Translation_2021_2022
WHERE TotalConsumption = 0;

--And

SELECT
    COUNT(*) AS ZeroConsumptionRows
FROM stg.WaterConsumption_Translation_2023_2025
WHERE TotalConsumption = 0;
