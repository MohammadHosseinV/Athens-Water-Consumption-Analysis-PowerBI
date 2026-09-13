;WITH SourceTotals AS
(
    SELECT
        SUM(CAST(TotalConsumption AS decimal(38, 6)))
            AS Source_TotalConsumption,

        SUM(CAST(ConsumptionDays AS decimal(38, 6)))
            AS Source_ConsumptionDays,

        SUM(CAST(NumberOfConnections AS decimal(38, 6)))
            AS Source_NumberOfConnections
    FROM
    (
        SELECT
            TotalConsumption,
            ConsumptionDays,
            NumberOfConnections
        FROM [stg].[WaterConsumption_Translation_2021_2022]

        UNION ALL

        SELECT
            TotalConsumption,
            ConsumptionDays,
            NumberOfConnections
        FROM [stg].[WaterConsumption_Translation_2023_2025]
    ) AS CombinedSource
),
TargetTotals AS
(
    SELECT
        SUM(CAST(TotalConsumption AS decimal(38, 6)))
            AS Target_TotalConsumption,

        SUM(CAST(ConsumptionDays AS decimal(38, 6)))
            AS Target_ConsumptionDays,

        SUM(CAST(NumberOfConnections AS decimal(38, 6)))
            AS Target_NumberOfConnections
    FROM [tr].[WaterConsumptionAggregated] 
)
SELECT
    s.Source_TotalConsumption,
    t.Target_TotalConsumption,
    s.Source_TotalConsumption - t.Target_TotalConsumption
        AS TotalConsumption_Difference,

    s.Source_ConsumptionDays,
    t.Target_ConsumptionDays,
    s.Source_ConsumptionDays - t.Target_ConsumptionDays
        AS ConsumptionDays_Difference,

    s.Source_NumberOfConnections,
    t.Target_NumberOfConnections,
    s.Source_NumberOfConnections - t.Target_NumberOfConnections
        AS NumberOfConnections_Difference
FROM SourceTotals AS s
CROSS JOIN TargetTotals AS t;