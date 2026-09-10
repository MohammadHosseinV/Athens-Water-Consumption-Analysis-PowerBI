--Unique PostalCode

SELECT
    COUNT(DISTINCT PostalCode) AS UniquePostalCodes
FROM stg.WaterConsumption_Translation_2021_2022;

--AND

SELECT
    COUNT(DISTINCT PostalCode) AS UniquePostalCodes
FROM stg.WaterConsumption_Translation_2023_2025;


--Unique Area

SELECT
    COUNT(DISTINCT AreaEnglish) AS UniqueAreas
FROM stg.WaterConsumption_Translation_2021_2022;
--And
SELECT
    COUNT(DISTINCT AreaEnglish) AS UniqueAreas
FROM stg.WaterConsumption_Translation_2023_2025;



SELECT
    PostalCode,
    COUNT(DISTINCT AreaEnglish) AS AreaCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY PostalCode
HAVING COUNT(DISTINCT AreaEnglish) > 1
ORDER BY AreaCount DESC;
--And 
SELECT
    PostalCode,
    COUNT(DISTINCT AreaEnglish) AS AreaCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY PostalCode
HAVING COUNT(DISTINCT AreaEnglish) > 1
ORDER BY AreaCount DESC;
