--PostalCode + AreaEnglish + Zone + ConsumptionMonth

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


--Number of Groups

SELECT
    COUNT(*) AS TotalGroups
FROM
(
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
) As X ;

--And

SELECT
    COUNT(*) AS TotalGroups
FROM
(
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
) As X ;


--Number of Duplicate Groups

SELECT
    COUNT(*) AS DuplicateGroups
FROM
(
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
HAVING COUNT(*) > 1
) x;

--And

SELECT
    COUNT(*) AS DuplicateGroups
FROM
(
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
HAVING COUNT(*) > 1
) x;


--Extra Duplicate Rows

SELECT
    SUM(RecordCount - 1) AS ExtraRows
FROM
(
  SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS RecordCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1
) x;

--And

SELECT
    SUM(RecordCount - 1) AS ExtraRows
FROM
(
  SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS RecordCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1
) x;
