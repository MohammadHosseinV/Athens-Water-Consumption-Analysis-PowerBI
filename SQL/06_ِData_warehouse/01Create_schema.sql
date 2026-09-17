
IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = 'dw'
)
BEGIN
    EXEC('CREATE SCHEMA [dw]');
END;
GO