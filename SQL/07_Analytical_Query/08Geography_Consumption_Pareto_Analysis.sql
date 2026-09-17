/*==============================================================
  Analytical Query 08
  Geography Consumption Contribution and Pareto Analysis
==============================================================*/

;WITH LatestMonth AS
(
    SELECT
        MAX(DateKey) AS LatestDateKey
    FROM dw.FactWaterConsumption
),
GeographyConsumption AS
(
    SELECT
        f.DateKey,
        f.GeographyKey,
        SUM(f.TotalConsumption) AS GeographyConsumption

    FROM dw.FactWaterConsumption AS f

    INNER JOIN LatestMonth AS lm
        ON f.DateKey = lm.LatestDateKey

    GROUP BY
        f.DateKey,
        f.GeographyKey
),
GeographyShare AS
(
    SELECT
        DateKey,
        GeographyKey,
        GeographyConsumption,

        SUM(GeographyConsumption) OVER ()
            AS TotalMonthConsumption,

        SUM(GeographyConsumption) OVER
        (
            ORDER BY GeographyConsumption DESC, GeographyKey
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS CumulativeConsumption

    FROM GeographyConsumption
)
SELECT
    gs.DateKey,
    gs.GeographyKey,
    g.PostalCode,
    g.AreaGreek,
    g.AreaEnglish,
    g.HasUnknownArea,
    gs.GeographyConsumption,

    CAST(
        gs.GeographyConsumption * 100.0
        / NULLIF(gs.TotalMonthConsumption, 0)
        AS DECIMAL(18, 4)
    ) AS ConsumptionSharePercent,

    CAST(
        gs.CumulativeConsumption * 100.0
        / NULLIF(gs.TotalMonthConsumption, 0)
        AS DECIMAL(18, 4)
    ) AS CumulativeConsumptionPercent,

    CASE
        WHEN gs.CumulativeConsumption * 100.0
             / NULLIF(gs.TotalMonthConsumption, 0) <= 80
            THEN 'Within First 80 Percent'
        ELSE 'After 80 Percent'
    END AS ParetoGroup

FROM GeographyShare AS gs

INNER JOIN dw.DimGeography AS g
    ON gs.GeographyKey = g.GeographyKey

ORDER BY
    gs.GeographyConsumption DESC,
    gs.GeographyKey;