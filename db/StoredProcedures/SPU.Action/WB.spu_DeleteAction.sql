USE WB_APP;
GO

-- remove  action
CREATE OR ALTER PROC WB.spu_DeleteAction
    @actionId INT
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        DECLARE @existId AS INT,
            @alreadyDeleted AS BIT;

        UPDATE WB.Action
        SET
            isDeleted = 1,
            @existId = actionID,
            @alreadyDeleted = isDeleted
        WHERE actionID = @actionId;

        IF @alreadyDeleted = 1
            THROW 50403, 'Action is already deleted!', 1;

        IF @existId IS NULL
            THROW 50404, 'Action doesn''t exist!', 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
