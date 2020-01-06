USE WB_APP;
GO

-- Get Actions in month
CREATE OR ALTER PROC WB.spu_GetActionInMonth
    @user VARCHAR(15),
    @actionsDate DATE
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        DECLARE @userID AS INT,
            @beginDate AS DATE,
            @endDate AS DATE;

        -- get user id
        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

        -- set month interval
        SET @beginDate = EOMONTH(@actionsDate, -1 );
        SET @endDate = EOMONTH(@actionsDate);

        SELECT A.actionID AS ID, amount, CU.symbol AS currency, AC.name AS category, A.[description], A.takeDate AS [date]
        FROM (WB.ActiveAction AS A INNER JOIN WB.ActionCategory AS AC ON A.actionCategoryID=AC.actionCategoryID) INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
        WHERE A.userID = @userID AND
            A.takeDate > @beginDate AND
            A.takeDate <=  @endDate
        ORDER BY [date], ID;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
