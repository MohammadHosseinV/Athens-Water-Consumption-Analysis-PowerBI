
 -- Section 2: Insert aggregated data



SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

   
    TRUNCATE TABLE [tr].[WaterConsumptionAggregated];

    ;WITH CombinedSource AS
    (
       
        SELECT
            PostalCode,
            AreaGreek,
            AreaEnglish,
            Zone,
            TotalConsumption,
            ConsumptionDays,
            AverageDailyConsumption,
            NumberOfConnections,
            ConsumptionMonth
        FROM [stg].[WaterConsumption_Translation_2021_2022]

        UNION ALL

       
        SELECT
            PostalCode,
            AreaGreek,
            AreaEnglish,
            Zone,
            TotalConsumption,
            ConsumptionDays,
            AverageDailyConsumption,
            NumberOfConnections,
            ConsumptionMonth
        FROM [stg].[WaterConsumption_Translation_2023_2025]
    ),
    ValidRowsAggregated AS
    (
        
        SELECT
            PostalCode,

            MAX
            (
                NULLIF(LTRIM(RTRIM(AreaGreek)), '')
            ) AS AreaGreek,

            AreaEnglish,
            Zone,

            SUM
            (
                CAST(TotalConsumption AS DECIMAL(38,9))
            ) AS TotalConsumption,

            SUM
            (
                CAST(ConsumptionDays AS BIGINT)
            ) AS ConsumptionDays,

            MAX
            (
                CAST(
                    AverageDailyConsumption
                    AS DECIMAL(38,9)
                )
            ) AS OriginalAverageDailyConsumption,

            SUM
            (
                CAST(NumberOfConnections AS BIGINT)
            ) AS NumberOfConnections,

            ConsumptionMonth,

            COUNT_BIG(*) AS RawCount
        FROM CombinedSource
        WHERE NULLIF(LTRIM(RTRIM(AreaEnglish)), '') IS NOT NULL
        GROUP BY
            PostalCode,
            AreaEnglish,
            Zone,
            ConsumptionMonth
    ),
    ValidRowsFinal AS
    (
        SELECT
            PostalCode,
            AreaGreek,
            AreaEnglish,
            Zone,
            TotalConsumption,
            ConsumptionDays,

            CAST
            (
                CASE
                  
                    WHEN RawCount > 1 THEN
                        CAST(TotalConsumption AS DECIMAL(38,9))
                        /
                        NULLIF
                        (
                            CAST(ConsumptionDays AS DECIMAL(38,9)),
                            0
                        )

                   
                    ELSE OriginalAverageDailyConsumption
                END
                AS DECIMAL(18,9)
            ) AS AverageDailyConsumption,

            NumberOfConnections,
            ConsumptionMonth
        FROM ValidRowsAggregated
    ),
    InvalidAreaEnglishRows AS
    (
        
        SELECT
            PostalCode,
            AreaGreek,
            AreaEnglish,
            Zone,

            CAST(
                TotalConsumption
                AS DECIMAL(38,9)
            ) AS TotalConsumption,

            CAST(
                ConsumptionDays
                AS BIGINT
            ) AS ConsumptionDays,

            CAST(
                AverageDailyConsumption
                AS DECIMAL(18,9)
            ) AS AverageDailyConsumption,

            CAST(
                NumberOfConnections
                AS BIGINT
            ) AS NumberOfConnections,

            ConsumptionMonth
        FROM CombinedSource
        WHERE NULLIF(LTRIM(RTRIM(AreaEnglish)), '') IS NULL
    ),
    FinalData AS
    (
        
        SELECT
            PostalCode,
            AreaGreek,
            AreaEnglish,
            Zone,
            TotalConsumption,
            ConsumptionDays,
            AverageDailyConsumption,
            NumberOfConnections,
            ConsumptionMonth
        FROM ValidRowsFinal

        UNION ALL

        SELECT
            PostalCode,
            AreaGreek,
            AreaEnglish,
            Zone,
            TotalConsumption,
            ConsumptionDays,
            AverageDailyConsumption,
            NumberOfConnections,
            ConsumptionMonth
        FROM InvalidAreaEnglishRows
    )
    INSERT INTO tr.WaterConsumptionAggregated
    (
        PostalCode,
        AreaGreek,
        AreaEnglish,
        Zone,
        TotalConsumption,
        ConsumptionDays,
        AverageDailyConsumption,
        NumberOfConnections,
        ConsumptionMonth
    )
    SELECT
        PostalCode,
        AreaGreek,
        AreaEnglish,
        Zone,
        TotalConsumption,
        ConsumptionDays,
        AverageDailyConsumption,
        NumberOfConnections,
        ConsumptionMonth
    FROM FinalData;

    DECLARE @InsertedRows BIGINT = @@ROWCOUNT;

    COMMIT TRANSACTION;

    SELECT
        @InsertedRows AS InsertedRowCount,
        'INSERT COMPLETED SUCCESSFULLY' AS InsertStatus;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage;

    THROW;
END CATCH;


