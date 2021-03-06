USE WB_APP;
GO

-- Get total of money grouped by action category
CREATE OR ALTER PROC WB.spu_GetTotMoneyByCategoryInMonth
    @user VARCHAR(15),
    @actionsDate DATE
AS
BEGIN;
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

        SELECT AC.name AS category, SUM(A.amount) as [totalMoney], CU.symbol AS currency
        FROM (WB.ActiveAction AS A INNER JOIN WB.ActionCategory AS AC ON A.actionCategoryID=AC.actionCategoryID) INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
        WHERE A.userID = @userID AND
            A.takeDate > @beginDate AND
            A.takeDate <=  @endDate
        GROUP BY AC.name, CU.currencyID, CU.symbol;
    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO