

;WITH MonthlyZone AS
(
    SELECT
        f.DateKey,

        DATEFROMPARTS(
            f.DateKey / 100,
            f.DateKey % 100,
            1
        ) AS MonthStartDate,

        f.ZoneKey,
        z.ZoneName,

        SUM(f.TotalConsumption) AS MonthlyConsumption,
        SUM(f.ConsumptionDays) AS MonthlyConsumptionDays,
        SUM(f.NumberOfConnections) AS MonthlyConnections

    FROM dw.FactWaterConsumption AS f

    INNER JOIN dw.DimZone AS z
        ON f.ZoneKey = z.ZoneKey

    GROUP BY
        f.DateKey,
        f.ZoneKey,
        z.ZoneName
)
SELECT
    current_zone.DateKey,
    current_zone.MonthStartDate,
    current_zone.ZoneKey,
    current_zone.ZoneName,
    current_zone.MonthlyConsumption,
    current_zone.MonthlyConnections,

    CAST(
        current_zone.MonthlyConsumption * 1.0
        / NULLIF(current_zone.MonthlyConsumptionDays, 0)
        AS DECIMAL(18, 2)
    ) AS RecalculatedAverageDailyConsumption,

    previous_zone.MonthlyConsumption
        AS PreviousMonthConsumption,

    CAST(
        (
            current_zone.MonthlyConsumption
            - previous_zone.MonthlyConsumption
        ) * 100.0
        / NULLIF(previous_zone.MonthlyConsumption, 0)
        AS DECIMAL(18, 2)
    ) AS MonthOverMonthChangePercent

FROM MonthlyZone AS current_zone

LEFT JOIN MonthlyZone AS previous_zone
    ON current_zone.ZoneKey = previous_zone.ZoneKey
   AND previous_zone.MonthStartDate =
       DATEADD(MONTH, -1, current_zone.MonthStartDate)

ORDER BY
    current_zone.DateKey,
    current_zone.ZoneName;