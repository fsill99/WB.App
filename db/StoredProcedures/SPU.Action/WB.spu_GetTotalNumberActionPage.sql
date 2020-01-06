USE WB_APP;
GO

-- Get Action page
CREATE OR ALTER PROC WB.spu_GetTotalNumberActionPage
    @user VARCHAR(15),
    @pagesize BIGINT
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        -- get user id
        DECLARE @userID AS INT;
        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

        -- get total number of pages
        SELECT (
            CASE elementnum % @pagesize
                WHEN 0 THEN elementnum / @pagesize
                ELSE elementnum / @pagesize + 1
            END) AS totalpage
        FROM (
            SELECT MAX(rownum) AS elementnum
            FROM WB.udf_GetOrderedAction(@userID) ) AS maxvalue;
    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO