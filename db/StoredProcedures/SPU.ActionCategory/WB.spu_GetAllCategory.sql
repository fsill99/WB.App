USE WB_APP;
GO

-- Get all Action category
CREATE OR ALTER PROC WB.spu_GetAllCategory
AS
BEGIN

    SET XACT_ABORT ON;

    SELECT [name]
    FROM WB.ActionCategory

END;
GO
