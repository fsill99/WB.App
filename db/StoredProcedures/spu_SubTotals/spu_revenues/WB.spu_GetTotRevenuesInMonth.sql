USE WB_APP;
GO

-- Get total revenues in month
CREATE OR ALTER PROC WB.spu_GetTotRevenuesInMonth
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

        SELECT SUM(A.amount) as [totalMoney], CU.symbol AS currency
        FROM WB.ActiveAction AS A INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
        WHERE A.userID = @userID AND
            A.amount >= 0 AND
            A.takeDate > @beginDate AND
            A.takeDate <=  @endDate
        GROUP BY CU.currencyID, CU.symbol
    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO