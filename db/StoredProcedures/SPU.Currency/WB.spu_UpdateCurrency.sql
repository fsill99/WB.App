USE WB_APP;
GO

-- Update currency
CREATE OR ALTER PROC WB.spu_UpdateCurrency
    @oldCurrencyName VARCHAR(10),
    @oldCurrencySymbol NVARCHAR(1),
    @newCurrencyName VARCHAR(10),
    @newCurrencySymbol NVARCHAR(1)
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        UPDATE WB.Currency
        SET
            [name] = LOWER(LTRIM(RTRIM(@newCurrencyName))),
            symbol = LTRIM(RTRIM(@newCurrencySymbol))
        WHERE currencyID = WB.udf_GetCurrencyId(@oldCurrencyName, @oldCurrencySymbol)
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 2627
            THROW 50004, 'Currency already exist!', 1;
        ELSE
            THROW;
    END CATCH
END;
GO
