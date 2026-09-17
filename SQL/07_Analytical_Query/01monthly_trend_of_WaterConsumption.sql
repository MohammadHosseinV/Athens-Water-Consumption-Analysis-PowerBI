

SELECT
    d.DateKey,
    DATEFROMPARTS(
        d.DateKey / 100,
        d.DateKey % 100,
        1
    ) AS MonthStartDate,

    SUM(f.TotalConsumption) AS TotalMonthlyConsumption,

    SUM(f.ConsumptionDays) AS TotalConsumptionDays,

    SUM(f.NumberOfConnections) AS TotalNumberOfConnections,

    CAST(
        SUM(f.TotalConsumption) * 1.0
        / NULLIF(SUM(f.ConsumptionDays), 0)
        AS DECIMAL(18, 2)
    ) AS RecalculatedAverageDailyConsumption

FROM dw.FactWaterConsumption AS f

INNER JOIN dw.DimDate AS d
    ON f.DateKey = d.DateKey

GROUP BY
    d.DateKey

ORDER BY
    d.DateKey;

