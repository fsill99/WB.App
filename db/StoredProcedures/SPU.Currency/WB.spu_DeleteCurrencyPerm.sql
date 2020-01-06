USE WB_APP;
GO

-- delete currency permanently
CREATE OR ALTER PROC WB.spu_DeleteCurrencyPerm
    @currencyName VARCHAR(10),
    @currencySymbol NVARCHAR(1)
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;
            DECLARE @rowcount AS INT

            DELETE FROM WB.Currency
            WHERE currencyID = WB.udf_GetCurrencyId(@currencyName, @currencySymbol)

            SET @rowcount = @@ROWCOUNT;

            IF @rowcount = 0
                THROW 50413, 'Currency doesn''t exist!', 1;

            IF @rowcount > 1
            BEGIN;
                DECLARE @anomalyMessage AS VARCHAR(65) = 'YOU DELETE ' + CAST(@rowcount AS VARCHAR(10)) + ' ROWS! This is an ANOMALY! Rollback...';
                THROW 55555, @anomalyMessage, 1;
            END;
        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
