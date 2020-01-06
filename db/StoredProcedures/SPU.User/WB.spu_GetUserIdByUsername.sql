USE WB_APP;
GO

-- Get user ID by username
CREATE OR ALTER PROC WB.spu_GetUserIdByUsername
    @username VARCHAR(15),
    @userId INT OUTPUT
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY

        SELECT @userId = userID
        FROM WB.ExpiredUsers
        WHERE username = LOWER(LTRIM(RTRIM(@username)));

        IF @userId IS NOT NULL
            THROW 50456, 'user is expired!', 1;

        SELECT @userId = userID
        FROM WB.ActiveUsers
        WHERE username = LOWER(LTRIM(RTRIM(@username)));

        IF @userId IS NULL
            THROW 50413, 'user doesn''t exist!', 1;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
