SELECT
    AreaGreek,
    LEN(AreaGreek) AS CharacterLength,
    DATALENGTH(AreaGreek) AS ByteLength
FROM
(
    SELECT AreaGreek
    FROM stg.WaterConsumption_Translation_2021_2022

    UNION

    SELECT AreaGreek
    FROM stg.WaterConsumption_Translation_2023_2025
) AS A
WHERE AreaGreek IS NOT NULL
ORDER BY
    AreaGreek;

	--

	SELECT DISTINCT
    AreaGreek
FROM
(
    SELECT AreaGreek
    FROM stg.WaterConsumption_Translation_2021_2022

    UNION

    SELECT AreaGreek
    FROM stg.WaterConsumption_Translation_2023_2025
) AS A
WHERE
    AreaGreek IS NOT NULL
    AND AreaGreek LIKE N'%  %'
ORDER BY
    AreaGreek;



--
SELECT
    PostalCode,
    AreaGreek,
    AreaEnglish,
    Zone,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    NumberOfConnections,
    ConsumptionMonth
FROM
(
    SELECT *
    FROM stg.WaterConsumption_Translation_2021_2022

    UNION ALL

    SELECT *
    FROM stg.WaterConsumption_Translation_2023_2025
) AS S
WHERE PostalCode = 18903
  AND AreaEnglish = N'AIANTEIO NATO'
ORDER BY
    ConsumptionMonth,
    Zone,
    AreaGreek,
    TotalConsumption;