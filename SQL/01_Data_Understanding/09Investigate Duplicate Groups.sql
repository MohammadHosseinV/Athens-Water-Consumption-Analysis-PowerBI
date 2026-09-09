WITH DuplicateGroups AS
(
    SELECT
        PostalCode,
        AreaEnglish,
        Zone,
        ConsumptionMonth
    FROM stg.WaterConsumption_Translation_2023_2025
    GROUP BY
        PostalCode,
        AreaEnglish,
        Zone,
        ConsumptionMonth
    HAVING COUNT(*) > 1
)
SELECT
    s.*
FROM stg.WaterConsumption_Translation_2023_2025 s
INNER JOIN DuplicateGroups d
    ON s.PostalCode = d.PostalCode
    AND s.AreaEnglish = d.AreaEnglish
    AND s.Zone = d.Zone
    AND s.ConsumptionMonth = d.ConsumptionMonth
ORDER BY
    s.PostalCode,
    s.ConsumptionMonth,
    s.Zone;

