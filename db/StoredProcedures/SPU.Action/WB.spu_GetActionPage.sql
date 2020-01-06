USE WB_APP;
GO

-- Get Action page
CREATE OR ALTER PROC WB.spu_GetActionPage
    @user VARCHAR(15),
    @pagenum BIGINT,
    @pagesize BIGINT
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        -- get user id
        DECLARE @userID AS INT;
        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

        -- get page
        SELECT ID, [date], amount, currency, category, [description]
        FROM WB.udf_GetOrderedAction(@userID)
        WHERE rownum BETWEEN (@pagenum -1) * @pagesize + 1 AND @pagenum * @pagesize
    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO