USE WB_APP;
GO

-- set user as expired
CREATE OR ALTER PROC WB.spu_ExpireUser
    @username VARCHAR(15)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        DECLARE @existId AS INT,
            @alreadyExpired AS BIT

        UPDATE WB.Users
        SET
            expired = 1,
            @existId = userID,
            @alreadyExpired = expired
        WHERE username = LOWER(LTRIM(RTRIM(@username)));

        IF @existId IS NULL
            THROW 50404, 'User doesn''t exist!', 1;

        IF @alreadyExpired = 1
            THROW 50403, 'User is already expired!', 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO