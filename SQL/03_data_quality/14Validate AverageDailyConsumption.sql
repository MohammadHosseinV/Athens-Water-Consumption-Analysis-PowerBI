SELECT TOP 100
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    TotalConsumption / NULLIF(ConsumptionDays, 0)
        AS CalculatedAverageDailyConsumption
FROM stg.WaterConsumption_Translation_2021_2022;

--And

SELECT TOP 100
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption,
    TotalConsumption / NULLIF(ConsumptionDays, 0)
        AS CalculatedAverageDailyConsumption
FROM stg.WaterConsumption_Translation_2023_2025;



--AverageDailyConsumption
SELECT
    COUNT(*) AS TotalRows,

    SUM(
        CASE
            WHEN ABS(
                AverageDailyConsumption
                -
                (
                    TotalConsumption
                    / NULLIF(ConsumptionDays, 0)
                )
            ) > 0.1
            THEN 1
            ELSE 0
        END
    ) AS InconsistentRows

FROM stg.WaterConsumption_Translation_2021_2022

WHERE ConsumptionDays > 0;

--And

SELECT
    COUNT(*) AS TotalRows,

    SUM(
        CASE
            WHEN ABS(
                AverageDailyConsumption
                -
                (
                    TotalConsumption
                    / NULLIF(ConsumptionDays, 0)
                )
            ) > 0.1
            THEN 1
            ELSE 0
        END
    ) AS InconsistentRows

FROM stg.WaterConsumption_Translation_2023_2025

WHERE ConsumptionDays > 0;

