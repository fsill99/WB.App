USE WB_APP;
GO

-- update category
CREATE OR ALTER PROC WB.spu_UpdateCategory
    @oldCatName VARCHAR(25),
    @newCatName  VARCHAR(25)
    AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        UPDATE WB.ActionCategory
        SET [name] = LOWER(LTRIM(RTRIM(@newCatName)))
        WHERE [name] = LOWER(LTRIM(RTRIM(@oldCatName)))
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 2627
            THROW 50004, 'Action category already exist!', 1;
        ELSE
            THROW;
    END CATCH
END;
GO
