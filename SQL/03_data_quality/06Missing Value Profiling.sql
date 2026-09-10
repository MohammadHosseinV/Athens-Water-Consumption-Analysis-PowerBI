SELECT
    COUNT(*) AS TotalRows,

    COUNT(PostalCode) AS NonMissingPostalCode,
    COUNT(*) - COUNT(PostalCode) AS MissingPostalCode,

    COUNT(AreaGreek) AS NonMissingAreaGreek,
    COUNT(*) - COUNT(AreaGreek) AS MissingAreaGreek,

    COUNT(AreaEnglish) AS NonMissingAreaEnglish,
    COUNT(*) - COUNT(AreaEnglish) AS MissingAreaEnglish,

	COUNT(ConsumptionMonth) As NonMissingConsumptionMonth,
	COUNT(*) - COUNT(ConsumptionMonth) As MissingConsumptionMoth,

	COUNT(Zone) As NonMissingZone,
	COUNT(*) - COUNT([Zone]) As MissingZone
FROM stg.WaterConsumption_Translation_2021_2022


SELECT
    COUNT(*) AS TotalRows,

    COUNT(PostalCode) AS NonMissingPostalCode,
    COUNT(*) - COUNT(PostalCode) AS MissingPostalCode,

    COUNT(AreaGreek) AS NonMissingAreaGreek,
    COUNT(*) - COUNT(AreaGreek) AS MissingAreaGreek,

    COUNT(AreaEnglish) AS NonMissingAreaEnglish,
    COUNT(*) - COUNT(AreaEnglish) AS MissingAreaEnglish,

	COUNT(ConsumptionMonth) As NonMissingConsumptionMonth,
	COUNT(*) - COUNT(ConsumptionMonth) As MissingConsumptionMoth,

	COUNT(Zone) As NonMissingZone,
	COUNT(*) - COUNT([Zone]) As MissingZone
FROM stg.WaterConsumption_Translation_2023_2025



SELECT
    ConsumptionMonth,
    COUNT(*) AS TotalRows,

    SUM(
        CASE
            WHEN PostalCode IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingPostalCode,

    SUM(
        CASE
            WHEN AreaGreek IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingAreaGreek


FROM stg.WaterConsumption_Translation_2021_2022

GROUP BY ConsumptionMonth
ORDER BY ConsumptionMonth;



SELECT
    ConsumptionMonth,
    COUNT(*) AS TotalRows,

    SUM(
        CASE
            WHEN PostalCode IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingPostalCode,

    SUM(
        CASE
            WHEN AreaGreek IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingAreaGreek


FROM stg.WaterConsumption_Translation_2023_2025

GROUP BY ConsumptionMonth
ORDER BY ConsumptionMonth;


--Percentage

    COUNT(*) AS TotalRows,

    SUM(CASE WHEN PostalCode IS NULL THEN 1 ELSE 0 END) AS MissingPostalCode,

    CAST(
        100.0 * SUM(CASE WHEN PostalCode IS NULL THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS MissingPostalCodePct

FROM stg.WaterConsumption_Translation_2021_2022;

--And

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN PostalCode IS NULL THEN 1 ELSE 0 END) AS MissingPostalCode,

    CAST(
        100.0 * SUM(CASE WHEN PostalCode IS NULL THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS MissingPostalCodePct

FROM stg.WaterConsumption_Translation_2023_2025;
