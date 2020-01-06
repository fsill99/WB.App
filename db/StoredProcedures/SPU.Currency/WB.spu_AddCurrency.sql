USE WB_APP;
GO

-- Add new currency
CREATE OR ALTER PROC WB.spu_AddCurrency
    @currencyName VARCHAR(10),
    @currencySymbol NVARCHAR(1)
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        INSERT INTO WB.Currency
        ([name], symbol)
    VALUES
        (LOWER(LTRIM(RTRIM(@currencyName))), @currencySymbol)
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 2627
            THROW 50004, 'Currency already exist!', 1;
        ELSE
            THROW;
    END CATCH
END;
GO
