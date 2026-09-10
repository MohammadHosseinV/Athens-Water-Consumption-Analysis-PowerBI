
--Query1
SELECT TOP 100
    ConsumptionMonth,
    NumberOfConnections,
    ConsumptionDays,

    CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
        AS DaysPerConnection

FROM stg.WaterConsumption_Translation_2021_2022

ORDER BY
    ABS(
        (CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0))
        - 30
    );

	--And

	SELECT TOP 100
    ConsumptionMonth,
    NumberOfConnections,
    ConsumptionDays,

    CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
        AS DaysPerConnection

FROM stg.WaterConsumption_Translation_2023_2025

ORDER BY
    ABS(
        (CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0))
        - 30
    );




	--Query2
	SELECT
    MIN(
        CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
    ) AS MinDaysPerConnection,

    MAX(
        CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
    ) AS MaxDaysPerConnection,

    AVG(
        CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
    ) AS AvgDaysPerConnection

FROM stg.WaterConsumption_Translation_2021_2022
WHERE NumberOfConnections > 0;

--And

SELECT
    MIN(
        CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
    ) AS MinDaysPerConnection,

    MAX(
        CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
    ) AS MaxDaysPerConnection,

    AVG(
        CAST(ConsumptionDays AS DECIMAL(18,2))
        / NULLIF(NumberOfConnections, 0)
    ) AS AvgDaysPerConnection

FROM stg.WaterConsumption_Translation_2023_2025
WHERE NumberOfConnections > 0;
