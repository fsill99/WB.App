---------------------------------------------------------------------
-- Create Functions
---------------------------------------------------------------------

USE WB_APP;
GO

CREATE OR ALTER FUNCTION WB.udf_GetCurrencyId(@currencyName AS VARCHAR(10) = NULL, @currencySymbol AS NVARCHAR(1) = NULL)
    RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @currencyId AS INT,
        @curNameFormatted AS VARCHAR(10) = LOWER(LTRIM(RTRIM(@currencyName))),
        @curSymbolFormatted AS NVARCHAR(1) = @currencySymbol;

    SELECT @currencyId = currencyID
    FROM WB.Currency
    WHERE ([name] = @curNameFormatted AND symbol = @curSymbolFormatted)
        OR ([name] = @curNameFormatted AND @curSymbolFormatted IS NULL)
        OR (symbol = @curSymbolFormatted AND @curNameFormatted IS NULL);

    RETURN @currencyId;
END;
GO
