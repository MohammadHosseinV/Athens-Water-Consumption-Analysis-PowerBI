--Query3
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
    s.PostalCode,
    s.AreaGreek,
    s.AreaEnglish,
    s.Zone,
    s.ConsumptionMonth,
    s.TotalConsumption,
    s.ConsumptionDays,
    s.AverageDailyConsumption,
    s.NumberOfConnections
FROM stg.WaterConsumption_Translation_2023_2025 s
INNER JOIN DuplicateGroups d
    ON s.PostalCode = d.PostalCode
    AND s.AreaEnglish = d.AreaEnglish
    AND s.Zone = d.Zone
    AND s.ConsumptionMonth = d.ConsumptionMonth
ORDER BY
    s.ConsumptionMonth,
    s.TotalConsumption;
