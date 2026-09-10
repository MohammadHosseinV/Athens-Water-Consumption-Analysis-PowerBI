SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    COUNT(*) AS [RowCount]
FROM stg.WaterConsumption_Translation_2021_2022
WHERE AreaGreek IS NULL
  AND AreaEnglish IS NOT NULL
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone
ORDER BY
    PostalCode,
    AreaEnglish;

	--And

	SELECT
    PostalCode,
    AreaEnglish,
    Zone,
    COUNT(*) AS [RowCount]
FROM stg.WaterConsumption_Translation_2023_2025
WHERE AreaGreek IS NULL
  AND AreaEnglish IS NOT NULL
GROUP BY
    PostalCode,
    AreaEnglish,
    Zone
ORDER BY
    PostalCode,
    AreaEnglish;
