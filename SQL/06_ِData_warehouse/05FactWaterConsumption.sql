--Create
CREATE TABLE [dw].[FactWaterConsumption]
(
    WaterConsumptionFactKey BIGINT IDENTITY(1,1) NOT NULL,

    DateKey                 INT NOT NULL,
    GeographyKey            INT NOT NULL,
    ZoneKey                 INT NOT NULL,

    NumberOfConnections     INT NULL,
    TotalConsumption        BIGINT NULL,
    ConsumptionDays         BIGINT NULL,
    AverageDailyConsumption DECIMAL(18,4) NULL,

    CONSTRAINT PK_FactWaterConsumption
        PRIMARY KEY (WaterConsumptionFactKey),

    CONSTRAINT FK_FactWaterConsumption_DimDate
        FOREIGN KEY (DateKey)
        REFERENCES [dw].[DimDate](DateKey),

    CONSTRAINT FK_FactWaterConsumption_DimGeography
        FOREIGN KEY (GeographyKey)
        REFERENCES [dw].[DimGeography](GeographyKey),

    CONSTRAINT FK_FactWaterConsumption_DimZone
        FOREIGN KEY (ZoneKey)
        REFERENCES [dw].[DimZone](ZoneKey)
);
GO

--Insert
INSERT INTO [dw].[FactWaterConsumption]
(
    DateKey,
    GeographyKey,
    ZoneKey,
    NumberOfConnections,
    TotalConsumption,
    ConsumptionDays,
    AverageDailyConsumption
)
SELECT
    D.DateKey,
    G.GeographyKey,
    Z.ZoneKey,
    C.NumberOfConnections,
    C.TotalConsumption,
    C.ConsumptionDays,
    C.AverageDailyConsumption
FROM [tr].[WaterConsumptionCleaned] AS C

INNER JOIN [dw].[DimDate] AS D
    ON D.FullDate = C.ConsumptionMonth

INNER JOIN [dw].[DimGeography] AS G
    ON G.PostalCode = ISNULL(C.PostalCode, -1)
   AND G.AreaGreek = ISNULL(C.AreaGreek, N'Unknown')
   AND G.AreaEnglish = ISNULL(C.AreaEnglish, N'Unknown')
   AND G.HasUnknownArea = CAST(C.HasUnknownArea AS BIT)

INNER JOIN [dw].[DimZone] AS Z
    ON Z.ZoneName = C.Zone;
GO
