--Time

SELECT
    ConsumptionMonth,
    COUNT(*) AS [RowCount],
    SUM(TotalConsumption) AS TotalConsumption,
    AVG(TotalConsumption) AS AvgRecordConsumption
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY ConsumptionMonth
ORDER BY ConsumptionMonth;

--And

SELECT
    ConsumptionMonth,
    COUNT(*) AS [RowCount],
    SUM(TotalConsumption) AS TotalConsumption,
    AVG(TotalConsumption) AS AvgRecordConsumption
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY ConsumptionMonth
ORDER BY ConsumptionMonth;



--Zone


SELECT
    Zone,
    COUNT(*) AS [RowCount],
    SUM(TotalConsumption) AS TotalConsumption,
    AVG(TotalConsumption) AS AvgConsumption
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY Zone
ORDER BY TotalConsumption DESC;

--And

SELECT
    Zone,
    COUNT(*) AS [RowCount],
    SUM(TotalConsumption) AS TotalConsumption,
    AVG(TotalConsumption) AS AvgConsumption
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY Zone
ORDER BY TotalConsumption DESC;



--Area

SELECT
    AreaEnglish,
    COUNT(*) AS [RowCount],
    SUM(TotalConsumption) AS TotalConsumption,
    AVG(TotalConsumption) AS AvgConsumption
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY AreaEnglish
ORDER BY TotalConsumption DESC;

--And

SELECT
    AreaEnglish,
    COUNT(*) AS [RowCount],
    SUM(TotalConsumption) AS TotalConsumption,
    AVG(TotalConsumption) AS AvgConsumption
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY AreaEnglish
ORDER BY TotalConsumption DESC;
