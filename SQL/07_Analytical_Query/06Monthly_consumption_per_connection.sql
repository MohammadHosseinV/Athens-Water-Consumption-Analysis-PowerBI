
SELECT
    f.DateKey,

    DATEFROMPARTS(
        f.DateKey / 100,
        f.DateKey % 100,
        1
    ) AS MonthStartDate,

    SUM(f.TotalConsumption) AS TotalMonthlyConsumption,

    SUM(f.NumberOfConnections) AS TotalMonthlyConnections,

    CAST(
        SUM(f.TotalConsumption) * 1.0
        / NULLIF(SUM(f.NumberOfConnections), 0)
        AS DECIMAL(18, 2)
    ) AS MonthlyConsumptionPerConnection

FROM dw.FactWaterConsumption AS f

GROUP BY
    f.DateKey

ORDER BY
    f.DateKey;