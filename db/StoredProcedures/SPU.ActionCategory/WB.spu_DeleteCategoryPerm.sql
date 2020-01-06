USE WB_APP;
GO

-- delete category permanently
CREATE OR ALTER PROC WB.spu_DeleteCategoryPerm
    @categoryName VARCHAR(25)
    AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;
            DECLARE @rowcount AS INT

            DELETE FROM WB.ActionCategory
            WHERE [name] = LOWER(LTRIM(RTRIM(@categoryName)))

            SET @rowcount = @@ROWCOUNT;

            IF @rowcount = 0
                THROW 50413, 'Action Category doesn''t exist!', 1;

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