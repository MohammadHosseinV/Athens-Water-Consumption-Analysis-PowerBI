SELECT
    MIN(ConsumptionMonth) AS MinMonth,
    MAX(ConsumptionMonth) AS MaxMonth,
    COUNT(DISTINCT ConsumptionMonth) AS DistinctMonths
FROM stg.WaterConsumption_Translation_2021_2022;


SELECT
    MIN(ConsumptionMonth) AS MinMonth,
    MAX(ConsumptionMonth) AS MaxMonth,
    COUNT(DISTINCT ConsumptionMonth) AS DistinctMonths
FROM stg.WaterConsumption_Translation_2023_2025;

--

SELECT
    YEAR(ConsumptionMonth) AS [Year],
    MONTH(ConsumptionMonth) AS [Month],
    COUNT(*) AS RCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY
    YEAR(ConsumptionMonth),
    MONTH(ConsumptionMonth)
ORDER BY
    [Year],
    [Month];
--

SELECT
    YEAR(ConsumptionMonth) AS [Year],
    MONTH(ConsumptionMonth) AS [Month],
    COUNT(*) AS RCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY
    YEAR(ConsumptionMonth),
    MONTH(ConsumptionMonth)
ORDER BY
    [Year],
    [Month];