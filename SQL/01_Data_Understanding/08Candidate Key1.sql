--PostalCode + Zone + ConsumptionMonth

SELECT
    PostalCode,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS RecordCount
FROM stg.WaterConsumption_Translation_2021_2022
GROUP BY
    PostalCode,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1
ORDER BY RecordCount DESC;

--And

SELECT
    PostalCode,
    Zone,
    ConsumptionMonth,
    COUNT(*) AS RecordCount
FROM stg.WaterConsumption_Translation_2023_2025
GROUP BY
    PostalCode,
    Zone,
    ConsumptionMonth
HAVING COUNT(*) > 1
ORDER BY RecordCount DESC;


--Number of Groups
SELECT
    COUNT(*) AS TotalGroups
FROM
(
    SELECT
        PostalCode,
        Zone,
        ConsumptionMonth
    FROM stg.WaterConsumption_Translation_2021_2022
    GROUP BY
        PostalCode,
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
        Zone,
        ConsumptionMonth
    FROM stg.WaterConsumption_Translation_2023_2025
    GROUP BY
        PostalCode,
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
        Zone,
        ConsumptionMonth
    FROM stg.WaterConsumption_Translation_2021_2022
    GROUP BY
        PostalCode,
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
        Zone,
        ConsumptionMonth
    FROM stg.WaterConsumption_Translation_2023_2025
    GROUP BY
        PostalCode,
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
        Zone,
        ConsumptionMonth,
        COUNT(*) AS RecordCount
    FROM stg.WaterConsumption_Translation_2021_2022
    GROUP BY
        PostalCode,
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
        Zone,
        ConsumptionMonth,
        COUNT(*) AS RecordCount
    FROM stg.WaterConsumption_Translation_2023_2025
    GROUP BY
        PostalCode,
        Zone,
        ConsumptionMonth
    HAVING COUNT(*) > 1
) x;




