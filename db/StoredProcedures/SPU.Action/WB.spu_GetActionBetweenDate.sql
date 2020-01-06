USE WB_APP;
GO

-- Get Action by date
CREATE OR ALTER PROC WB.spu_GetActionBetweenDate
    @user VARCHAR(15),
    @beginDate DATE,
    @endDate DATE
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        DECLARE @userID AS INT;

        -- get user id
        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

        SELECT A.actionID AS ID, amount, CU.symbol AS currency, AC.name AS category, A.[description], A.takeDate AS [date]
        FROM (WB.ActiveAction AS A INNER JOIN WB.ActionCategory AS AC ON A.actionCategoryID=AC.actionCategoryID) INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
        WHERE A.userID = @userID AND
            A.takeDate BETWEEN @beginDate AND @endDate
        ORDER BY [date], ID;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
