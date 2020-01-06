USE WB_APP;
GO

-- Add new User
CREATE OR ALTER PROC WB.spu_SubmitUser
    @username VARCHAR(15),
    @firstname VARCHAR(15),
    @lastname VARCHAR(15),
    @password NVARCHAR(15),
    @email VARCHAR(30),
    @birthday DATE = NULL
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY

        BEGIN TRAN;

            INSERT INTO WB.Users (username, firstName, lastName, [password], email, birthdate)
            VALUES (
                LOWER(LTRIM(RTRIM(@username))),
                LTRIM(RTRIM(@firstname)),
                LTRIM(RTRIM(@lastname)),
                LTRIM(RTRIM(@password)),
                LOWER(LTRIM(RTRIM(@email))),
                @birthday
            )

        COMMIT TRAN;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        IF ERROR_NUMBER() = 2627
            THROW 52627, 'User already exist!', 1;

        IF ERROR_NUMBER() = 547 AND CHARINDEX('"CHK_password"', ERROR_MESSAGE()) > 0
            THROW 50002, 'Password must be at least 6 characters!', 1;

        IF ERROR_NUMBER() = 547 AND CHARINDEX('"CHK_birthdate"', ERROR_MESSAGE()) > 0
            THROW 50547, 'Birthday is invalid!', 1;

        THROW;
    END CATCH
END;
GO
