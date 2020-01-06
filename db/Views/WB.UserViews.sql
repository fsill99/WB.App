---------------------------------------------------------------------
-- Create UserViews Views
---------------------------------------------------------------------

USE WB_APP;
GO

CREATE OR ALTER VIEW WB.ActiveUsers
  WITH SCHEMABINDING
AS
    SELECT userID, username, firstName, lastName, [password], email, birthdate
    FROM WB.Users
    WHERE expired = 0
    WITH CHECK OPTION;
GO

CREATE OR ALTER VIEW WB.ExpiredUsers
  WITH SCHEMABINDING
AS
    SELECT userID, username, firstName, lastName, [password], email, birthdate
    FROM WB.Users
    WHERE expired = 1
    WITH CHECK OPTION;
GO
