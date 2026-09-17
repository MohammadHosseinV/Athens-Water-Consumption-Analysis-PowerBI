-- Validation 02
-- Additive measure differences must equal zero

SELECT
    B.TotalConsumptionBefore,
    A.TotalConsumptionAfter,
    A.TotalConsumptionAfter - B.TotalConsumptionBefore
        AS TotalConsumptionDifference,

    B.ConsumptionDaysBefore,
    A.ConsumptionDaysAfter,
    A.ConsumptionDaysAfter - B.ConsumptionDaysBefore
        AS ConsumptionDaysDifference,

    B.ConnectionsBefore,
    A.ConnectionsAfter,
    A.ConnectionsAfter - B.ConnectionsBefore
        AS ConnectionsDifference
FROM
(
    SELECT
        SUM(CAST(TotalConsumption AS DECIMAL(38, 6)))
            AS TotalConsumptionBefore,
        SUM(CAST(ConsumptionDays AS BIGINT))
            AS ConsumptionDaysBefore,
        SUM(CAST(NumberOfConnections AS BIGINT))
            AS ConnectionsBefore
    FROM [tr].[WaterConsumptionAggregated]
) B
CROSS JOIN
(
    SELECT
        SUM(CAST(TotalConsumption AS DECIMAL(38, 6)))
            AS TotalConsumptionAfter,
        SUM(CAST(ConsumptionDays AS BIGINT))
            AS ConsumptionDaysAfter,
        SUM(CAST(NumberOfConnections AS BIGINT))
            AS ConnectionsAfter
    FROM [tr].[WaterConsumptionCleaned]
) A;