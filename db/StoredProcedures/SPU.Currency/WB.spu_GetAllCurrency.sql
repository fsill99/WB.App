USE WB_APP;
GO

-- Get all currency
CREATE OR ALTER PROC WB.spu_GetAllCurrency
AS
BEGIN

    SET XACT_ABORT ON;

    SELECT [name], symbol
    FROM WB.Currency

END;
GO
