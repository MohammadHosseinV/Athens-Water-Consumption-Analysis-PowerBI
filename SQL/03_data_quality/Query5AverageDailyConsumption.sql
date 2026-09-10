SELECT TOP 100
    TotalConsumption,
    NumberOfConnections,
    ConsumptionDays,
    AverageDailyConsumption,
    CAST(TotalConsumption AS DECIMAL(18,4))
        / NULLIF(NumberOfConnections, 0)
        / 30.0
        AS CalculatedAverageDailyConsumption
FROM stg.WaterConsumption_Translation_2021_2022
ORDER BY
    ABS(
        AverageDailyConsumption -
        (
            CAST(TotalConsumption AS DECIMAL(18,4))
            / NULLIF(NumberOfConnections, 0)
            / 30.0
        )
    ) DESC;


	--And

	SELECT TOP 100
    TotalConsumption,
    NumberOfConnections,
    ConsumptionDays,
    AverageDailyConsumption,

    CAST(TotalConsumption AS DECIMAL(18,4))
        / NULLIF(NumberOfConnections, 0)
        / 30.0
        AS CalculatedAverageDailyConsumption

FROM stg.WaterConsumption_Translation_2023_2025

ORDER BY
    ABS(
        AverageDailyConsumption -
        (
            CAST(TotalConsumption AS DECIMAL(18,4))
            / NULLIF(NumberOfConnections, 0)
            / 30.0
        )
    ) DESC;




	--
	SELECT
    COUNT(*) AS TotalRows,
    SUM(
        CASE
            WHEN ABS(
                AverageDailyConsumption -
                (
                    CAST(TotalConsumption AS DECIMAL(18,4))
                    / NULLIF(NumberOfConnections, 0)
                    / 30.0
                )
            ) <= 0.1
            THEN 1
            ELSE 0
        END
    ) AS ConsistentRows,
    SUM(
        CASE
            WHEN ABS(
                AverageDailyConsumption -
                (
                    CAST(TotalConsumption AS DECIMAL(18,4))
                    / NULLIF(NumberOfConnections, 0)
                    / 30.0
                )
            ) > 0.1
            THEN 1
            ELSE 0
        END
    ) AS InconsistentRows

FROM stg.WaterConsumption_Translation_2021_2022
WHERE NumberOfConnections > 0;

--And

SELECT
    COUNT(*) AS TotalRows,
    SUM(
        CASE
            WHEN ABS(
                AverageDailyConsumption -
                (
                    CAST(TotalConsumption AS DECIMAL(18,4))
                    / NULLIF(NumberOfConnections, 0)
                    / 30.0
                )
            ) <= 0.1
            THEN 1
            ELSE 0
        END
    ) AS ConsistentRows,
    SUM(
        CASE
            WHEN ABS(
                AverageDailyConsumption -
                (
                    CAST(TotalConsumption AS DECIMAL(18,4))
                    / NULLIF(NumberOfConnections, 0)
                    / 30.0
                )
            ) > 0.1
            THEN 1
            ELSE 0
        END
    ) AS InconsistentRows

FROM stg.WaterConsumption_Translation_2023_2025
WHERE NumberOfConnections > 0;

