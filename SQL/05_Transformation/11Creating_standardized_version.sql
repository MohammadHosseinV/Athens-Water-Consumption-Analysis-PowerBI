IF OBJECT_ID('[tr].[WaterConsumptionCleaned]', 'U') IS NOT NULL
    DROP TABLE [tr].[WaterConsumptionCleaned];
GO

WITH NormalizedData AS
(
    SELECT
        PostalCode,

        NULLIF(
            LTRIM(RTRIM(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(AreaGreek, NCHAR(160), N' '),
                            N'  ', N' '
                        ),
                        N'  ', N' '
                    ),
                    N'  ', N' '
                )
            )),
            N''
        ) AS CleanAreaGreek,

        NULLIF(
            LTRIM(RTRIM(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(AreaEnglish, NCHAR(160), N' '),
                            N'  ', N' '
                        ),
                        N'  ', N' '
                    ),
                    N'  ', N' '
                )
            )),
            N''
        ) AS CleanAreaEnglish,

        NULLIF(
            LTRIM(RTRIM(
                REPLACE(
                    REPLACE(Zone, NCHAR(160), N' '),
                    N'  ', N' '
                )
            )),
            N''
        ) AS CleanZone,

        TotalConsumption,
        ConsumptionDays,
        AverageDailyConsumption,
        NumberOfConnections,
        ConsumptionMonth

    FROM [tr].[WaterConsumptionAggregated]
)
SELECT
    PostalCode,
    CleanAreaGreek   AS AreaGreek,
    CleanAreaEnglish AS AreaEnglish,
    CleanZone        AS Zone,

    SUM(TotalConsumption) AS TotalConsumption,
    SUM(ConsumptionDays) AS ConsumptionDays,

    CAST(
        CASE
            WHEN SUM(ConsumptionDays) > 0
            THEN SUM(TotalConsumption) * 1.0
                 / SUM(ConsumptionDays)
            ELSE 0
        END
        AS DECIMAL(18, 6)
    ) AS AverageDailyConsumption,

    SUM(NumberOfConnections) AS NumberOfConnections,
    ConsumptionMonth,

    CASE
        WHEN CleanAreaGreek IS NULL
         AND CleanAreaEnglish IS NULL
            THEN 1
        ELSE 0
    END AS HasUnknownArea

INTO [tr].[WaterConsumptionCleaned]

FROM NormalizedData

GROUP BY
    PostalCode,
    CleanAreaGreek,
    CleanAreaEnglish,
    CleanZone,
    ConsumptionMonth;
GO