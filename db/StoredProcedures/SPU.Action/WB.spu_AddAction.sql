USE WB_APP;
GO

-- Add Action
CREATE OR ALTER PROC WB.spu_AddAction
    @amount DECIMAL(19, 2),
    @currencyName VARCHAR(10) = NULL,
    @currencySymbol NVARCHAR(1) = NULL,
    @user VARCHAR(15),
    @actionCategory VARCHAR(25),
    @description NVARCHAR(70),
    @actionDate DATE = NULL
AS
BEGIN;

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY

        BEGIN TRAN
            -- get currency id if null
            DECLARE @currencyId AS INT;

            IF @currencyName IS NULL AND @currencySymbol IS NULL
            BEGIN;
                SET @currencyId = WB.udf_GetCurrencyId('euro', DEFAULT);
            END;
            ELSE
            BEGIN;
                SET @currencyId = WB.udf_GetCurrencyId(@currencyName, @currencySymbol);
            END;

            IF @currencyId IS NULL
                THROW 50404, 'Currency doesn''t exist!', 1;

            -- get user id
            DECLARE @userID AS INT;
            EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userID OUTPUT;

            -- get category id
            DECLARE @actionCategoryId AS INT;
            EXEC WB.spu_GetCateroryActionId @CatName = @actionCategory, @CatId = @actionCategoryId OUTPUT;

            -- insert action
            IF @actionDate IS NULL
                INSERT INTO WB.Action (amount, currencyID, userID, actionCategoryID, [description])
                VALUES (@amount, @currencyId, @userID, @actionCategoryId, @description);
            ELSE
                INSERT INTO WB.Action (amount, currencyID, userID, actionCategoryID, [description], takeDate)
                VALUES (@amount, @currencyId, @userID, @actionCategoryId, @description, @actionDate);

        COMMIT TRAN;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH
END;
GO
