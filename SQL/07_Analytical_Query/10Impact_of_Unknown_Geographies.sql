

;WITH GeographyQuality AS
(
    SELECT
        CASE
            WHEN g.PostalCode = -1
                 AND g.HasUnknownArea = 1
                THEN 'Unknown Postal Code and Area'

            WHEN g.PostalCode = -1
                THEN 'Unknown Postal Code'

            WHEN g.HasUnknownArea = 1
                THEN 'Unknown Area'

            ELSE 'Known Geography'
        END AS GeographyQualityGroup,

        COUNT_BIG(*) AS FactRowCount,
        SUM(f.TotalConsumption) AS TotalConsumption

    FROM dw.FactWaterConsumption AS f

    INNER JOIN dw.DimGeography AS g
        ON f.GeographyKey = g.GeographyKey

    GROUP BY
        CASE
            WHEN g.PostalCode = -1
                 AND g.HasUnknownArea = 1
                THEN 'Unknown Postal Code and Area'

            WHEN g.PostalCode = -1
                THEN 'Unknown Postal Code'

            WHEN g.HasUnknownArea = 1
                THEN 'Unknown Area'

            ELSE 'Known Geography'
        END
)
SELECT
    GeographyQualityGroup,
    FactRowCount,
    TotalConsumption,

    CAST(
        FactRowCount * 100.0
        / NULLIF(SUM(FactRowCount) OVER (), 0)
        AS DECIMAL(18, 4)
    ) AS FactRowSharePercent,

    CAST(
        TotalConsumption * 100.0
        / NULLIF(SUM(TotalConsumption) OVER (), 0)
        AS DECIMAL(18, 4)
    ) AS ConsumptionSharePercent

FROM GeographyQuality

ORDER BY
    CASE GeographyQualityGroup
        WHEN 'Known Geography' THEN 1
        WHEN 'Unknown Area' THEN 2
        WHEN 'Unknown Postal Code' THEN 3
        WHEN 'Unknown Postal Code and Area' THEN 4
    END;