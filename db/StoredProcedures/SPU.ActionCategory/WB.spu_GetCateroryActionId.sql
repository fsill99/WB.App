USE WB_APP;
GO

-- Get category ID by category name
CREATE OR ALTER PROC WB.spu_GetCateroryActionId
    @CatName VARCHAR(15),
    @CatId INT OUTPUT
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        SELECT @CatId = actionCategoryID
        FROM WB.ActionCategory
        WHERE [name] = LOWER(LTRIM(RTRIM(@CatName)))

        IF @CatId IS NULL
            THROW 50413, 'Action Category doesn''t exist!', 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO