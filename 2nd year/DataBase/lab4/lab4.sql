USE Cafe
SELECT * FROM Tables
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--inserare tabele in Tables
INSERT INTO Tables(Name)
VALUES ('Snacks')
GO
INSERT INTO Tables(Name)
VALUES ('CoffeeDrinks')
GO
INSERT INTO Tables(Name)
VALUES ('Menu')

DELETE FROM Tables

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--view with SELECT on 1 table
CREATE VIEW viewSnacks AS
	SELECT * 
	FROM Snacks
GO
--view with SELECT on 2 tables 
CREATE VIEW viewMenuSnacks AS
	SELECT s.Name AS MenuSnacks, s.Quantity, s.MainIngredient, m.Price AS MenuPrice
	FROM Snacks s INNER JOIN Menu m on s.IdSnack=m.IdSnack

--view SELECT on 2 tables with GROUP BY
CREATE VIEW viewMenuDrinks AS
	SELECT co.Name AS Drink, co.QuantityML, m.Price AS MenuPrice 
	FROM Menu m INNER JOIN CoffeeDrinks co on m.IdDrink=co.IdDrink 
	GROUP BY co.Name, co.QuantityML, m.Price

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--inserare views in VIEWS
INSERT INTO Views(Name)
VALUES('viewSnacks')
INSERT INTO Views(Name)
VALUES('viewMenuSnacks')
GO
INSERT INTO Views(Name)
VALUES('viewMenuDrinks')

SELECT * FROM Views

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--inserare in TESTS
INSERT INTO Tests 
VALUES ('select_view'),('insertSnack'),('deleteSnack'),('inserTCoffeeDrinks'),('deleteCoffeDrinks'),('insertMenu'),('deleteMenu')

SELECT * FROM Tests

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--inserare in TestViews
INSERT INTO TestViews
VALUES (1,1),(1,2),(1,3)

SELECT * FROM TestViews

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--inserare in TestTables(TestID, TableID, NOofRows, Position)
INSERT INTO TestTables
VALUES (2,1,100,1),(4,2,100,2),(6,3,100,3)
SELECT * FROM TestTables
INSERT INTO TestTables
VALUES (7,3,100,4),(5,2,100,5),(3,1,100,6)

--proceduri
--insert into Snacks 100 rows
CREATE OR ALTER PROC insertSnack
AS
BEGIN
	DECLARE @crt INT = 1
	DECLARE @rows INT
	DECLARE @sname VARCHAR(30)

	SELECT @rows = NoOfRows FROM TestTables WHERE TestID=2
	--PRINT(@rows)
	WHILE @crt <= @rows
		BEGIN
			SET @sname = 'Snack' + CONVERT(VARCHAR(5),@crt)
			INSERT INTO Snacks VALUES(@sname, 10, 50, 'ingredient')
			SET @crt = @crt +1
		END
END

--insert into CoffeeDrinks 100 rows
CREATE OR ALTER PROC inserTCoffeeDrinks
AS
BEGIN
	DECLARE @crt INT = 1
	DECLARE @fk INT
	DECLARE @rows INT
	DECLARE @sname VARCHAR(30)
	SELECT @fk = min(IdType) FROM CoffeeTypes
	--PRINT(@fk)
	SELECT @rows = NoOfRows FROM TestTables WHERE TestID=4
	--PRINT(@rows)
	WHILE @crt <= @rows
		BEGIN
			SET @sname = 'Coffee' + CONVERT(VARCHAR(5),@crt)
			INSERT INTO CoffeeDrinks VALUES(@sname, 12, 200, @fk)
			SET @crt = @crt +1
		END
END
EXEC inserTCoffeeDrinks
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--INSERT INTO Menu 100 rows
CREATE OR ALTER PROC insertMenu
AS
BEGIN
	DECLARE @minS INT
	DECLARE @crt INT = 1
	DECLARE @rows INT
	DECLARE @item INT
	DECLARE @minD INT
	SELECT @minS = min(IdSnack) FROM Snacks 
	--SELECT @minD = min(IdDrink) FROM CoffeeDrinks
	SELECT @rows = NoOfRows FROM TestTables WHERE TestID = 6
	WHILE (@crt<= @rows AND @minS IS NOT NULL)
	BEGIN
		SELECT @minD = min(IdDrink) FROM CoffeeDrinks
		WHILE (@crt<= @rows AND @minD IS NOT NULL)
		BEGIN
			SET @item = NULL
			SELECT @item = Price FROM Menu WHERE IdSnack=@minS AND IdDrink=@minD
			IF @item IS NULL
			BEGIN
				INSERT INTO Menu VALUES (@minS, @minD, 5)
				SET @crt = @crt +1
			END
			SELECT @minD = min(IdDrink) FROM CoffeeDrinks WHERE IdDrink > @minD

		END
		SELECT @minS = min(IdSnack) FROM Snacks WHERE IdSnack > @minS
	END
END

-->>>>>>>>>>>>>>>>>>>
--DELETE 100 FROM Menu
CREATE OR ALTER PROC deleteMenu
AS
BEGIN
	DECLARE @crt INT = 1
	DECLARE @rows INT
	DECLARE @idS INT
	DECLARE @idD INT
	SELECT @rows = NoOfRows FROM TestTables WHERE TestID=7
	WHILE @crt <= @rows
	BEGIN
		SELECT TOP 1 @idS =IdSnack, @idD = IdDrink FROM Menu ORDER BY Price ASC
		DELETE FROM Menu WHERE IdSnack=@idS AND IdDrink=@idD
		SET @crt = @crt +1
	END
END

-->>>>>>>>>>>>>>>>>>>>>>
--DELETE 100 FROM CoffeeDrinks
CREATE OR ALTER PROC deleteCoffeDrinks
AS
BEGIN
	DECLARE @crt INT = 1
	DECLARE @rows INT
	DECLARE @idD INT
	SELECT @rows = NoOfRows FROM TestTables WHERE TestID=5
	WHILE @crt <= @rows
	BEGIN
		SELECT TOP 1 @idD = IdDrink FROM CoffeeDrinks ORDER BY IdDrink DESC
		DELETE FROM CoffeeDrinks WHERE IdDrink=@idD
		SET @crt = @crt +1
	END
END

-->>>>>>>>>>>>>>>>>>>>>
--DELETE 100 FROM Snacks
CREATE OR ALTER PROC deleteSnack
AS
BEGIN
	DECLARE @crt INT = 1
	DECLARE @rows INT
	DECLARE @idS INT
	SELECT @rows = NoOfRows FROM TestTables WHERE TestID=3
	WHILE @crt <= @rows
	BEGIN
		SELECT TOP 1 @idS = IdSnack FROM Snacks ORDER BY IdSnack DESC
		DELETE FROM Snacks WHERE IdSnack=@idS
		SET @crt = @crt +1
	END
END

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--main procedure for tables TestRuns, TestRunTables and TestRunViews


CREATE OR ALTER PROC main
AS
BEGIN
	DECLARE @ds DATETIME-- start time test
	DECLARE @di DATETIME-- intermediate time test
	DECLARE @de DATETIME-- end time test
	DECLARE @v INT
	DECLARE @id INT 
	DECLARE @proc VARCHAR(30)
	DECLARE @crt INT = 1
	DECLARE @testid INT
	-- insert into table Snacks
	-- delete from table Snacks
	--DELETE FROM TestRuns
	--DELETE FROM TestRunTables
	--DELETE FROM TestRunViews

	SET @ds = GETDATE()
	EXEC insertSnack
	EXEC deleteSnack
	SET @di=GETDATE()
	SELECT * FROM viewSnacks
	SET @de=GETDATE()
	SELECT @v = ViewID FROM Views WHERE Name = 'viewSnacks'
	INSERT INTO TestRuns VALUES('>Snacks', @ds, @de)
	SET @id = @@IDENTITY
	INSERT INTO TestRunTables VALUES (@id,1,@ds, @di)
	INSERT INTO TestRunViews VALUES (@id,@v,@di, @de)

	-- insert into table Snacks
	--insert into table CoffeeDrinks
	--delete from table CoffeeDrinks
	-- delete from table Snacks
	SET @ds = GETDATE()
	EXEC insertSnack
	EXEC inserTCoffeeDrinks
	EXEC deleteCoffeDrinks
	EXEC deleteSnack
	SET @di=GETDATE()
	SELECT * FROM viewMenuSnacks
	SET @de=GETDATE()
	SELECT @v = ViewID FROM Views WHERE Name = 'viewMenuSnacks'
	INSERT INTO TestRuns VALUES('>Snacks>CoffeeDr', @ds, @de)
	SET @id = @@IDENTITY
	INSERT INTO TestRunTables VALUES (@id,2,@ds, @di)
	INSERT INTO TestRunViews VALUES (@id,@v,@di, @de)
	
	-- insert into table Snacks
	--insert into table CoffeeDrinks
	--insert into table Menu
	--delete from table Menu
	--delete from table CoffeeDrinks
	-- delete from table Snacks
	SET @ds = GETDATE()
	WHILE @crt<=6
	BEGIN
		SELECT @testid = TestID FROM TestTables WHERE Position = @crt
		SELECT @proc = Name FROM Tests WHERE TestID = @testid
		EXEC @proc
		SET @crt = @crt + 1
	END
	SET @di=GETDATE()
	SELECT * FROM viewMenuDrinks
	SET @de=GETDATE()
	SELECT @v = ViewID FROM Views WHERE Name = 'viewMenuDrinks'

	INSERT INTO TestRuns VALUES('Snacks>CoffeeDr>>Menu', @ds, @de)
	SET @id = @@IDENTITY
	INSERT INTO TestRunTables VALUES (@id,3,@ds, @di)
	INSERT INTO TestRunViews VALUES (@id,@v,@di, @de)
	SELECT * FROM TestRuns
	SELECT * FROM TestRunTables
	SELECT * FROM TestRunViews
END

EXEC main