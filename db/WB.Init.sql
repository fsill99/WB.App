USE master;
GO

IF(db_id(N'WB_APP') IS NULL)
BEGIN

    CREATE DATABASE WB_APP;
END;
GO

USE WB_APP;
GO

---------------------------------------------------------------------
-- Create Schema
---------------------------------------------------------------------
CREATE SCHEMA WB AUTHORIZATION dbo;
GO


---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

CREATE TABLE WB.Users
(
    userID INT NOT NULL IDENTITY(1, 1),
    username VARCHAR(15) NOT NULL,
    firstName VARCHAR(15) NOT NULL,
    lastName VARCHAR(15) NOT NULL,
    [password] NVARCHAR(15) NOT NULL,
    email VARCHAR(30) NOT NULL,
    birthdate DATE,
    expired BIT
        CONSTRAINT DFT_expired DEFAULT 0,
    -- roleID INT NOT NULL,
    CONSTRAINT PK_usersID PRIMARY KEY (userID),
    -- CONSTRAINT FK_roleID FOREIGN KEY(roleID)
    --     REFERENCES WB.Currency(roleID),
    CONSTRAINT UNQ_username UNIQUE (username),
    CONSTRAINT CHK_password CHECK(LEN([password]) >= 6),
    CONSTRAINT CHK_birthdate CHECK(birthdate <= CAST(SYSDATETIME() AS DATE) OR birthdate IS NULL)
);
GO

CREATE TABLE WB.ActionCategory
(
    actionCategoryID INT NOT NULL IDENTITY(1, 1),
    [name] VARCHAR(25) NOT NULL,
    CONSTRAINT PK_actionCategoryID PRIMARY KEY (actionCategoryID),
    CONSTRAINT UNQ_name UNIQUE ([name])
);
GO

CREATE TABLE WB.Currency
(
    currencyID INT NOT NULL IDENTITY(1, 1),
    [name] VARCHAR(10) NOT NULL,
    symbol NVARCHAR(1) NOT NULL,
    CONSTRAINT PK_currencyID PRIMARY KEY (currencyID),
    CONSTRAINT UNQ_name_symbol UNIQUE ([name], symbol)
);
GO

CREATE TABLE WB.Action
(
    actionID INT NOT NULL IDENTITY(1, 1),
    amount DECIMAL(19, 2) NOT NULL,
    currencyID INT NOT NULL,
    userID INT NOT NULL,
    actionCategoryID INT NOT NULL,
    [description] NVARCHAR(70) NULL,
    takeDate DATE NOT NULL
        CONSTRAINT DFT_takeDate DEFAULT CAST(CURRENT_TIMESTAMP AS DATE),
    isDeleted BIT
        CONSTRAINT DFT_isDeleted DEFAULT 0,
    CONSTRAINT PK_actionID PRIMARY KEY (actionID),
    CONSTRAINT FK_userID FOREIGN KEY(userID)
        REFERENCES WB.Users(userID),
    CONSTRAINT FK_actionCategoryID FOREIGN KEY(actionCategoryID)
        REFERENCES WB.ActionCategory(actionCategoryID),
    CONSTRAINT FK_currencyID FOREIGN KEY(currencyID)
        REFERENCES WB.Currency(currencyID)
);
GO

-- CREATE TABLE WB.Role
-- (
--     roleID INT NOT NULL IDENTITY(1, 1),
--     [name] VARCHAR(10) NOT NULL,
--     CONSTRAINT PK_roleID PRIMARY KEY (roleID),
--     CONSTRAINT UNQ_name UNIQUE ([name])
-- )