SELECT
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    NumberOfConnections,
    ConsumptionMonth,
    COUNT(*) AS DuplicateCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    NumberOfConnections,
    ConsumptionMonth
HAVING COUNT(*) > 1;




SELECT
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    NumberOfConnections,
    ConsumptionMonth,
    COUNT(*) AS DuplicateCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    NumberOfConnections,
    ConsumptionMonth
HAVING COUNT(*) > 1;


--??? ?????? ?? ?????? ?? ???? ????? 
SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS DuplicateCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1;

--And

SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS DuplicateCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1;