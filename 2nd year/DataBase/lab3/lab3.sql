use Cafe
go
--Created version table and added value 0 
--because it is in the initial state
CREATE TABLE Version
(VersionNO int default 0)
INSERT INTO Version(VersionNO)
VALUES(0)
SELECT* FROM Version

--1
--modify type of column
--modified column Date from table OnlineOrder, from type date to varchar
CREATE PROCEDURE do_proc_1
AS
BEGIN
ALTER TABLE OnlineOrder
ALTER COLUMN Date varchar(50) NOT NULL
PRINT N'Am modificat coloana Date (OnlineOrder) din tip date in tip varchar'
SELECT*FROM OnlineOrder
END

--1 UNDO
CREATE PROCEDURE undo_proc_1
AS
BEGIN
ALTER TABLE OnlineOrder
ALTER COLUMN Date date
PRINT N'Am modificat la loc coloana Date (OnlineOrder) din tip varchar in tip date'
SELECT*FROM OnlineOrder
END

--2
--added default constraint 1500 to column MoneyAmount from salary
--EXEC do_proc_2
CREATE PROCEDURE do_proc_2
AS
BEGIN
ALTER TABLE Salary
ADD CONSTRAINT df_1500 DEFAULT 1500 FOR MoneyAmount
PRINT N'Am adaugat default constraint 1500 pentru MoneyAmount din Salary'
END

--2 UNDO
--remove default constraint for MoneyAmount
--EXEC undo_proc_2
CREATE PROCEDURE undo_proc_2
AS
BEGIN
ALTER TABLE Salary
DROP CONSTRAINT df_1500
PRINT N'Am eliminat default constraintul de 1500 pentru MoneyAmount din Salary'
END

--3
--created a new table Smoothies with the columns: IdSm, Name, Volume, MainFruit
CREATE PROCEDURE do_proc_3
AS
BEGIN
CREATE TABLE Smoothies(
IdSm INT NOT NULL PRIMARY KEY,
Name varchar(50),
Volume int,
MainFruit varchar(50)
);
PRINT N'Am creat tabelul Smoothies cu urmatoarele coloane: ID,nume, volum si fruct principal'
SELECT * FROM Smoothies
END

--3 UNDO
--remove table Smoothies
CREATE PROCEDURE undo_proc_3
AS
BEGIN
DROP TABLE Smoothies
PRINT N'Am sters tabelul Smoothies'
END

--4
--added a new column City in the table Client
CREATE PROCEDURE do_proc_4
AS
BEGIN
ALTER TABLE Client
ADD City varchar(50)
PRINT N'Am aduagat coloana City in tabelul Client'
SELECT * FROM Client
END

--4 UNDO
--remove the column City from table Client
CREATE PROCEDURE undo_proc_4
AS
BEGIN
ALTER TABLE Client
DROP COLUMN City
PRINT N'Am eliminat coloana City din tabelul Client'
SELECT * FROM Client
END

--5
--created a foreign key constraint for table CoffeeTypes
CREATE PROCEDURE do_proc_5
AS
BEGIN
ALTER TABLE CoffeeTypes
ADD CONSTRAINT fk_CoffeeTypes_Coffeeshop FOREIGN KEY(IdCafe) REFERENCES CoffeeShop(IdCafe)
PRINT N'Am adaugat constrangere de cheie straina in CoffeeTypes pentru CoffeeShop'
END

--5 UNDO
--remove foreign key constraint for table CoffeeTypes
CREATE PROCEDURE undo_proc_5
AS
BEGIN
ALTER TABLE CoffeeTypes
DROP CONSTRAINT fk_CoffeeTypes_Coffeeshop
PRINT N'Am eliminat constrangerea de cheie straina din tabelul CoffeeTypes'
END

CREATE PROCEDURE main
--versiunea la care vrem sa ajungem
@newVers int
AS
BEGIN
	--versiunea curenta
	DECLARE @crtVers INT
	SET @crtVers = (SELECT V.VersionNO FROM Version V)
	PRINT 'Versiunea curenta este ' + CAST(@crtVers AS VARCHAR(3))
	PRINT N''
	--procedura ce trebuie executata in functie de conditii
	DECLARE @procedure VARCHAR(50)
	--validare versiune
	IF ISNUMERIC(@newVers) != 1
		BEGIN
			PRINT 'Versiunea introdusa nu este numar'
			RETURN
		END
	ELSE
		BEGIN
			IF @newVers<0 OR @newVers>5
			BEGIN
				PRINT 'Versiunea trebuie sa fie intre 0 si 5'
				RETURN
			END
		END
	IF @crtVers<@newVers
	BEGIN
		WHILE @crtVers<@newVers
		BEGIN
			SET @crtVers = @crtVers + 1
			SET @procedure = 'do_proc_' + CAST(@crtVers AS VARCHAR(3))
			EXEC @procedure
		END
	END
	ELSE 
	BEGIN
		WHILE @crtVers>@newVers
		BEGIN
			SET @procedure = 'undo_proc_' + CAST(@crtVers AS VARCHAR(3))
			EXEC @procedure
			SET @crtVers = @crtVers - 1		
		END
	END
	UPDATE Version SET VersionNO = @newVers;
	PRINT 'Versiunea noua curenta a bazei de date este ' + CAST(@crtVers AS VARCHAR(3))
END

EXEC main 11
SELECT * FROM Version