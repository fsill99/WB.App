USE WB_APP;
GO

-- Add new category
CREATE OR ALTER PROC WB.spu_AddCategory
    @categoryName VARCHAR(25)
    AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        INSERT INTO WB.ActionCategory ([name])
        VALUES (LOWER(LTRIM(RTRIM(@categoryName))))
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 2627
            THROW 50004, 'Action category already exist!', 1;
        ELSE
            THROW;
    END CATCH
END;
GO
