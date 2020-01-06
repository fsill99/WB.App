USE WB_APP;
GO

-- delete action permanently
CREATE OR ALTER PROC WB.spu_DeleteActionPerm
    @actionId INT
AS
BEGIN;
    SET XACT_ABORT, NOCOUNT ON;

    BEGIN TRY;
        DECLARE @rowcount AS INT,
            @activeActionId AS INT

        SELECT @activeActionId = actionID
        FROM WB.ActiveAction
        WHERE actionID = @actionId;

        IF @activeActionId IS NOT NULL
            THROW 50355, 'Only Action in trash bin can be deleted!', 1;

        BEGIN TRAN;

            DELETE FROM WB.ActionTrashBin
            WHERE actionID = @actionId;

            SET @rowcount = @@ROWCOUNT;

            IF @rowcount = 0
                THROW 50313, 'Action doesn''t exist!', 1;

            IF @rowcount > 1
            BEGIN;
                DECLARE @anomalyMessage AS VARCHAR(65) = 'YOU DELETE ' + CAST(@rowcount AS VARCHAR(10)) + ' ROWS! This is an ANOMALY! Rollback...';
                THROW 55555, @anomalyMessage, 1;
            END;
        COMMIT TRAN;
    END TRY
    BEGIN CATCH;
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH;
END;
GO