--Create
CREATE TABLE [dw].[DimDate]
(
    DateKey             INT           NOT NULL,
    FullDate            DATE          NOT NULL,
    CalendarYear        SMALLINT      NOT NULL,
    CalendarQuarter     TINYINT       NOT NULL,
    CalendarMonth       TINYINT       NOT NULL,
    MonthNameEnglish    NVARCHAR(20)  NOT NULL,
    YearMonth           CHAR(7)       NOT NULL,
    YearMonthNumber     INT           NOT NULL,

    CONSTRAINT PK_DimDate
        PRIMARY KEY (DateKey),

    CONSTRAINT UQ_DimDate_FullDate
        UNIQUE (FullDate)
);
GO

--Insert
INSERT INTO [dw].[DimDate]
(
    DateKey,
    FullDate,
    CalendarYear,
    CalendarQuarter,
    CalendarMonth,
    MonthNameEnglish,
    YearMonth,
    YearMonthNumber
)
SELECT DISTINCT
    YEAR(C.ConsumptionMonth) * 100
        + MONTH(C.ConsumptionMonth) AS DateKey,

    C.ConsumptionMonth AS FullDate,

    YEAR(C.ConsumptionMonth) AS CalendarYear,

    DATEPART(QUARTER, C.ConsumptionMonth) AS CalendarQuarter,

    MONTH(C.ConsumptionMonth) AS CalendarMonth,

    CASE MONTH(C.ConsumptionMonth)
        WHEN 1 THEN N'January'
        WHEN 2 THEN N'February'
        WHEN 3 THEN N'March'
        WHEN 4 THEN N'April'
        WHEN 5 THEN N'May'
        WHEN 6 THEN N'June'
        WHEN 7 THEN N'July'
        WHEN 8 THEN N'August'
        WHEN 9 THEN N'September'
        WHEN 10 THEN N'October'
        WHEN 11 THEN N'November'
        WHEN 12 THEN N'December'
    END AS MonthNameEnglish,

    CONVERT(CHAR(7), C.ConsumptionMonth, 120) AS YearMonth,

    YEAR(C.ConsumptionMonth) * 100
        + MONTH(C.ConsumptionMonth) AS YearMonthNumber
FROM [tr].[WaterConsumptionCleaned] AS C
WHERE C.ConsumptionMonth IS NOT NULL;
GO