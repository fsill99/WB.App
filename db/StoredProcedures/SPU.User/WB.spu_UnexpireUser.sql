USE WB_APP;
GO

-- active user
CREATE OR ALTER PROC WB.spu_UnexpireUser
    @username VARCHAR(15)
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        DECLARE @existId AS INT,
            @alreadyActive AS BIT

        UPDATE WB.Users
        SET
            expired = 0,
            @existId = userID,
            @alreadyActive = expired
        WHERE username = LOWER(LTRIM(RTRIM(@username)));

        IF @existId IS NULL
            THROW 50404, 'User doesn''t exist!', 1;

        IF @alreadyActive = 0
            THROW 50403, 'User is already active!', 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
