SELECT
    COUNT(*) AS [RCount1]
FROM stg.WaterConsumption_Translation_2021_2022;

SELECT
    COUNT(*) AS [RCount2]
FROM stg.WaterConsumption_Translation_2023_2025;

--Combined

SELECT
    SUM(T.RCount) AS TotalRowCount
FROM
(
    SELECT COUNT(*) AS [RCount]
    FROM stg.WaterConsumption_Translation_2021_2022

    UNION ALL

    SELECT COUNT(*) AS [RCount]
    FROM stg.WaterConsumption_Translation_2023_2025
) AS T
