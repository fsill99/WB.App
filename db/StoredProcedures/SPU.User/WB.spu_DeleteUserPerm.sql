USE WB_APP;
GO

-- delete user permanently
CREATE OR ALTER PROC WB.spu_DeleteUserPerm
    @username VARCHAR(15)
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        DECLARE @rowcount AS INT,
            @activeUserId AS INT

        SELECT @activeUserId = userID
        FROM WB.ActiveUsers
        WHERE username = LOWER(LTRIM(RTRIM(@username)));

        IF @activeUserId IS NOT NULL
            THROW 50455, 'Only expired user can be deleted!', 1;

        BEGIN TRAN;
            DELETE FROM WB.ExpiredUsers
            WHERE username = LOWER(LTRIM(RTRIM(@username)));

            SET @rowcount = @@ROWCOUNT;

            IF @rowcount = 0
                THROW 50413, 'User doesn''t exist!', 1;

            IF @rowcount > 1
            BEGIN;
                DECLARE @anomalyMessage AS VARCHAR(65) = 'YOU DELETE ' + CAST(@rowcount AS VARCHAR(10)) + ' ROWS! This is an ANOMALY! Rollback...';
                THROW 55555, @anomalyMessage, 1;
            END;
        COMMIT TRAN;
    END TRY
    BEGIN CATCH;
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH;
END;
GO
