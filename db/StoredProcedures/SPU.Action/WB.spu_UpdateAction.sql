USE WB_APP;
GO

-- update action
CREATE OR ALTER PROC WB.spu_UpdateAction
    @actionId INT,
    @user VARCHAR(15),
    @amount DECIMAL(19, 2),
    @currencyName VARCHAR(10),
    @currencySymbol NVARCHAR(1),
    @actionCategory VARCHAR(25),
    @description NVARCHAR(70),
    @actionDate DATE
AS
BEGIN

    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        DECLARE @userIDCreated AS INT,
            @userIDUpdated AS INT,
            @currencyId AS INT,
            @actionCategoryId AS INT,
            @actionActived AS INT,
            @rowcount AS INT

        -- check if active
        SELECT @actionActived=actionID
        FROM WB.ActionTrashBin
        WHERE actionID=@actionId

        IF @actionActived IS NOT NULL
            THROW 50655, 'You cannot update deleted action!',1;


        -- check user
        SELECT @userIDCreated = userID
        FROM WB.ActiveAction
        WHERE actionID=@actionId

        EXEC WB.spu_GetUserIdByUsername @username=@user, @userId=@userIDUpdated OUTPUT;

        IF @userIDCreated <> @userIDUpdated
            THROW 50403, 'Action User cannot be changed!', 1;


        -- get currency id
        SET @currencyId = WB.udf_GetCurrencyId(@currencyName, @currencySymbol);

        IF @currencyId IS NULL
            THROW 50404, 'Currency doesn''t exist!', 1;


        -- get category id
        EXEC WB.spu_GetCateroryActionId @CatName = @actionCategory, @CatId = @actionCategoryId OUTPUT;

        -- update
        UPDATE WB.ActiveAction
        SET
            amount = @amount,
            actionCategoryID = @actionCategoryId,
            [description] = @description,
            takeDate = @actionDate
        WHERE actionID=@actionId;

        SET @rowcount = @@ROWCOUNT;

        IF @rowcount = 0
            THROW 50413, 'Action doesn''t exist!', 1;

    END TRY
    BEGIN CATCH;
        THROW;
    END CATCH;
END;
GO
