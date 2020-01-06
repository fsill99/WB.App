USE WB_APP;
GO

-- Get total of money grouped by action category
CREATE OR ALTER PROC WB.spu_GetTotMoneyByCategory
    @user VARCHAR(15)
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        -- get user id
        DECLARE @userID AS INT;
        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

        SELECT AC.name AS category, SUM(A.amount) as [totalMoney], CU.symbol AS currency
        FROM (WB.ActiveAction AS A INNER JOIN WB.ActionCategory AS AC ON A.actionCategoryID=AC.actionCategoryID) INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
        WHERE A.userID = @userID
        GROUP BY AC.name, CU.currencyID, CU.symbol;
    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO