USE WB_APP;
GO

-- Add Euro currency
EXEC WB.spu_AddCurrency @currencyName = 'euro', @currencySymbol = N'€';
GO