IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'tr'
)
BEGIN
    EXEC('CREATE SCHEMA tr');
END;


--Table
IF OBJECT_ID(N'tr.WaterConsumptionAggregated', N'U') IS NOT NULL
    DROP TABLE tr.WaterConsumptionAggregated;
GO

CREATE TABLE tr.WaterConsumptionAggregated
(
    PostalCode              INT NULL,
    AreaGreek               NVARCHAR(100) NULL,
    AreaEnglish             NVARCHAR(100) NULL,
    Zone                    NVARCHAR(50) NULL,
    TotalConsumption        BIGINT NOT NULL,
    ConsumptionDays         BIGINT NOT NULL,
    AverageDailyConsumption DECIMAL(18,9) NOT NULL,
    NumberOfConnections     INT NOT NULL,
    ConsumptionMonth        DATE NOT NULL
);
GO

