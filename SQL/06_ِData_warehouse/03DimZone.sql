--Create
CREATE TABLE [dw].[DimZone]
(
    ZoneKey     INT IDENTITY(1,1) NOT NULL,
    ZoneName    NVARCHAR(200) NOT NULL,

    CONSTRAINT PK_DimZone
        PRIMARY KEY (ZoneKey),

    CONSTRAINT UQ_DimZone_ZoneName
        UNIQUE (ZoneName)
);
GO

--Insert
INSERT INTO [dw].[DimZone]
(
    ZoneName
)
SELECT DISTINCT
    C.Zone
FROM [tr].[WaterConsumptionCleaned] AS C
WHERE C.Zone IS NOT NULL;
GO