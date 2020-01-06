USE WB_APP;
GO

-- change user password
CREATE OR ALTER PROC WB.spu_ChangeUserPassword
    @username VARCHAR(15),
    @oldPassword NVARCHAR(15),
    @newPassword NVARCHAR(15)
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        BEGIN TRAN;
            DECLARE @getOldPassword AS NVARCHAR(15),
                @userID AS INT,
                @rowcount AS INT;

            -- get user id
            EXEC WB.spu_GetUserIdByUsername @username=@username, @userId=@userID OUTPUT;

            SELECT @getOldPassword = [password]
            FROM WB.ActiveUsers
            WHERE userID = @userID;

            IF @oldPassword <> @getOldPassword
                THROW 50403, 'old password is wrong!', 1;

            IF @newPassword = @oldPassword
                THROW 50123, 'the new password can''t be the same as the old one', 1;

            UPDATE WB.ActiveUsers
            SET [password] = @newPassword
            WHERE userID = @userID;

            SET @rowcount = @@ROWCOUNT;

            IF @rowcount > 1
            BEGIN;
                DECLARE @anomalyMessage AS VARCHAR(65) = 'YOU UPDATE ' + CAST(@rowcount AS VARCHAR(10)) + ' ROWS! This is an ANOMALY! Rollback...';
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
