/*==============================================================
  Analytical Query 05
  Geography Consumption Ranking
==============================================================*/

;WITH MonthlyGeography AS
(
    SELECT
        f.DateKey,
        f.GeographyKey,

        SUM(f.TotalConsumption) AS MonthlyConsumption,
        SUM(f.ConsumptionDays) AS MonthlyConsumptionDays,
        SUM(f.NumberOfConnections) AS MonthlyConnections

    FROM dw.FactWaterConsumption AS f

    GROUP BY
        f.DateKey,
        f.GeographyKey
),
GeographySummary AS
(
    SELECT
        GeographyKey,
        COUNT(*) AS ActiveMonthCount,
        SUM(MonthlyConsumption) AS TotalPeriodConsumption,
        SUM(MonthlyConsumptionDays) AS TotalConsumptionDays,

        AVG(CAST(MonthlyConnections AS DECIMAL(18, 2)))
            AS AverageMonthlyConnections

    FROM MonthlyGeography

    GROUP BY
        GeographyKey
)
SELECT
    gs.GeographyKey,
    g.PostalCode,
    g.AreaGreek,
    g.AreaEnglish,
    g.HasUnknownArea,
    gs.ActiveMonthCount,
    gs.TotalPeriodConsumption,

    CAST(
        gs.TotalPeriodConsumption * 1.0
        / NULLIF(gs.TotalConsumptionDays, 0)
        AS DECIMAL(18, 2)
    ) AS RecalculatedAverageDailyConsumption,

    CAST(
        gs.AverageMonthlyConnections
        AS DECIMAL(18, 2)
    ) AS AverageMonthlyConnections,

    DENSE_RANK() OVER
    (
        ORDER BY gs.TotalPeriodConsumption DESC
    ) AS GeographyConsumptionRank

FROM GeographySummary AS gs

INNER JOIN dw.DimGeography AS g
    ON gs.GeographyKey = g.GeographyKey

ORDER BY
    GeographyConsumptionRank,
    gs.GeographyKey;