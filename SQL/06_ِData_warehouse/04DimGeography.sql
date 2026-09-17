--Create
CREATE TABLE [dw].[DimGeography]
(
    GeographyKey    INT IDENTITY(1,1) NOT NULL,

    PostalCode      INT NOT NULL,

    AreaGreek       NVARCHAR(300) NOT NULL,

    AreaEnglish     NVARCHAR(300) NOT NULL,

    HasUnknownArea  BIT NOT NULL
        CONSTRAINT DF_DimGeography_HasUnknownArea DEFAULT (0),

    CONSTRAINT PK_DimGeography
        PRIMARY KEY (GeographyKey)
);
GO

--Prevent duplicate geography combinations
CREATE UNIQUE INDEX UX_DimGeography_NaturalKey
ON [dw].[DimGeography]
(
    PostalCode,
    AreaGreek,
    AreaEnglish,
    HasUnknownArea
);
GO

--Insert
INSERT INTO [dw].[DimGeography]
(
    PostalCode,
    AreaGreek,
    AreaEnglish,
    HasUnknownArea
)
SELECT DISTINCT
    ISNULL(C.PostalCode, -1) AS PostalCode,

    ISNULL(C.AreaGreek, N'Unknown') AS AreaGreek,

    ISNULL(C.AreaEnglish, N'Unknown') AS AreaEnglish,

    CAST
    (
        CASE
            WHEN C.PostalCode IS NULL
              OR C.AreaGreek IS NULL
              OR C.AreaEnglish IS NULL
            THEN 1
            ELSE 0
        END
        AS BIT
    ) AS HasUnknownArea

FROM [tr].[WaterConsumptionCleaned] AS C;
GO



/*
  Insert missing Geography members into DimGeography
  Includes PostalCode = -1 / Unknown PostalCode members
*/

INSERT INTO [dw].[DimGeography]
(
    PostalCode,
    AreaGreek,
    AreaEnglish,
    HasUnknownArea
)
SELECT DISTINCT
    ISNULL(C.PostalCode, -1) AS PostalCode,

    CAST(
        ISNULL(C.AreaGreek, N'Unknown')
        AS NVARCHAR(600)
    ) AS AreaGreek,

    CAST(
        ISNULL(C.AreaEnglish, N'Unknown')
        AS NVARCHAR(600)
    ) AS AreaEnglish,

    CAST(C.HasUnknownArea AS BIT) AS HasUnknownArea

FROM [tr].[WaterConsumptionCleaned] AS C

WHERE NOT EXISTS
(
    SELECT 1
    FROM [dw].[DimGeography] AS G
    WHERE G.PostalCode = ISNULL(C.PostalCode, -1)
      AND G.AreaGreek = ISNULL(C.AreaGreek, N'Unknown')
      AND G.AreaEnglish = ISNULL(C.AreaEnglish, N'Unknown')
      AND G.HasUnknownArea = CAST(C.HasUnknownArea AS BIT)
);
GO

