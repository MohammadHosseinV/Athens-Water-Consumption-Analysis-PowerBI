SELECT
    MIN(TotalConsumption) AS MinConsumption,
    MAX(TotalConsumption) AS MaxConsumption,
    AVG(TotalConsumption) AS AvgConsumption,
    SUM(TotalConsumption) AS TotalConsumption
FROM stg.WaterConsumption_Translation_2021_2022;

--And

SELECT
    MIN(TotalConsumption) AS MinConsumption,
    MAX(TotalConsumption) AS MaxConsumption,
    AVG(TotalConsumption) AS AvgConsumption,
    SUM(TotalConsumption) AS TotalConsumption
FROM stg.WaterConsumption_Translation_2023_2025;
