USE WB_APP;
GO

-- Add new User
CREATE OR ALTER PROC WB.spu_LoginUser
    @username VARCHAR(15),
    @password NVARCHAR(15)
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        DECLARE @userID AS INT,
            @checkPassword AS NVARCHAR(15);
        
        -- get user id
        EXEC WB.spu_GetUserIdByUsername @username=@username, @userId=@userID OUTPUT;

        SELECT @checkPassword = [password]
        FROM WB.ActiveUsers
        WHERE userID = @userID

        IF @checkPassword <> @password
            THROW 50401, 'password is wrong!', 1;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
