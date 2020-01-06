USE WB_APP;
GO

-- restore action
CREATE OR ALTER PROC WB.spu_RestoreAction
    @actionId INT
AS
BEGIN
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY
        DECLARE @existId AS INT,
            @alreadyActive AS BIT

        UPDATE WB.Action
        SET
            isDeleted = 0,
            @existId = actionID,
            @alreadyActive = isDeleted
        WHERE actionID = @actionId

        IF @alreadyActive = 0
            THROW 50403, 'You cannot restore action not deleted!', 1;

        IF @existId IS NULL
            THROW 50404, 'Action doesn''t exist!', 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO
