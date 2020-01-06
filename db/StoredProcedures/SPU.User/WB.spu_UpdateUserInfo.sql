USE WB_APP;
GO

-- update user info
CREATE OR ALTER PROC WB.spu_UpdateUserInfo
    @oldUsername VARCHAR(15),
    @newFirstName VARCHAR(15),
    @newLastName VARCHAR(15),
    @newEmail VARCHAR(30),
    @newBirthdate DATE = NULL
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        BEGIN TRAN;
            DECLARE @rowcount AS INT;

            UPDATE WB.ActiveUsers
            SET
                firstName = LTRIM(RTRIM(@newFirstName)),
                lastName = LTRIM(RTRIM(@newLastName)),
                email = LOWER(LTRIM(RTRIM(@newEmail))),
                birthdate = @newBirthdate
            WHERE username = LOWER(LTRIM(RTRIM(@oldUsername)))

            SET @rowcount = @@ROWCOUNT;

            IF @rowcount = 0
                THROW 50413, 'User doesn''t exist!', 1;

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

        IF ERROR_NUMBER() = 547 AND CHARINDEX('"CHK_birthdate"', ERROR_MESSAGE()) > 0
            THROW 50547, 'Birthday is invalid!', 1;
        ELSE
            THROW;
    END CATCH;
END;
GO
