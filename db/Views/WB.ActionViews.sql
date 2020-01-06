---------------------------------------------------------------------
-- Create Action Views
---------------------------------------------------------------------

USE WB_APP;
GO

CREATE OR ALTER VIEW WB.ActiveAction
  WITH SCHEMABINDING
AS
    SELECT actionID, amount, currencyID, userID, actionCategoryID, [description], takeDate
    FROM WB.Action
    WHERE isDeleted = 0
    WITH CHECK OPTION;
GO

CREATE OR ALTER VIEW WB.ActionTrashBin
  WITH SCHEMABINDING
AS
    SELECT actionID, amount, currencyID, userID, actionCategoryID, [description], takeDate
    FROM WB.Action
    WHERE isDeleted = 1
    WITH CHECK OPTION;
GO
