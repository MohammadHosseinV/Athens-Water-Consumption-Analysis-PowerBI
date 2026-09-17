--DimGeography
SELECT
    COUNT(*) AS OrphanGeographyRowCount
FROM dw.FactWaterConsumption AS F
LEFT JOIN dw.DimGeography AS G
    ON F.GeographyKey = G.GeographyKey
WHERE G.GeographyKey IS NULL;

--DimDate
SELECT
    F.DateKey,
    COUNT_BIG(*) AS AffectedFactRowCount
FROM dw.FactWaterConsumption AS F
LEFT JOIN dw.DimDate AS D
    ON F.DateKey = D.DateKey
WHERE D.DateKey IS NULL
GROUP BY
    F.DateKey
ORDER BY
    AffectedFactRowCount DESC,
    F.DateKey;

--DimZone
SELECT
    COUNT(*) AS OrphanGeographyRowCount
FROM dw.FactWaterConsumption AS F
LEFT JOIN dw.DimZone AS Z
    ON F.ZoneKey = Z.ZoneKey
WHERE Z.ZoneKey IS NULL;


