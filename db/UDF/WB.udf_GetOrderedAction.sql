USE WB_APP;
GO

CREATE OR ALTER FUNCTION WB.udf_GetOrderedAction(@userID AS INT)
    RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT ROW_NUMBER() OVER(ORDER BY A.takeDate DESC, A.actionID) AS rownum,
        A.actionID AS ID,
        A.amount AS amount,
        CU.symbol AS currency,
        AC.name AS category,
        A.[description] AS [description],
        A.takeDate AS [date]
    FROM (WB.ActiveAction AS A INNER JOIN WB.ActionCategory AS AC ON A.actionCategoryID=AC.actionCategoryID)
        INNER JOIN WB.Currency AS CU ON A.currencyID=CU.currencyID
    WHERE A.userID = @userID;