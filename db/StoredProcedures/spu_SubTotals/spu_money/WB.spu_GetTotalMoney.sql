USE WB_APP;
GO

-- Get total money
CREATE OR ALTER PROC WB.spu_GetTotalMoney
    @user VARCHAR(15)
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        -- get user id
        DECLARE @userID AS INT;
        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

        SELECT SUM(A.amount) as [totalMoney], CU.symbol AS currency
        FROM WB.ActiveAction AS A INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
        WHERE A.userID = @userID
        GROUP BY CU.currencyID, CU.symbol
    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO