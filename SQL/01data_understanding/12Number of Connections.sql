SELECT
    MIN(NumberOfConnections) AS MinConnections,
    MAX(NumberOfConnections) AS MaxConnections,
    AVG(NumberOfConnections) AS AvgConnections
FROM stg.WaterConsumption_Translation_2021_2022;

--And

SELECT
    MIN(NumberOfConnections) AS MinConnections,
    MAX(NumberOfConnections) AS MaxConnections,
    AVG(NumberOfConnections) AS AvgConnections
FROM stg.WaterConsumption_Translation_2023_2025;
