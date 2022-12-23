USE Cafe
GO
--folosescs tabelele snacks, menu, coffeedrinks

--function to verify if value is in the rigth interval
CREATE FUNCTION TestInterval(@value INT, @a INT, @b INT)
RETURNS INT
AS
BEGIN
	IF @value BETWEEN @a AND @b SET @value=1
	ELSE SET @value=0
	RETURN @value
END

CREATE OR ALTER PROC CRUD_SNACKS
@name VARCHAR(30),
@price INT,
@quantity INT,
@ingredient VARCHAR(30)
AS
BEGIN
	DECLARE @maxS INT
--quantity in interval [150,300]
	IF dbo.TestInterval(@quantity, 150, 300)=1
	BEGIN
		--INSERT
		INSERT INTO Snacks(Name, Price, Quantity, MainIngredient)
		VALUES (@name, @price, @quantity, @ingredient)
		--READ
		SELECT * FROM Snacks
		--UPDATE
		UPDATE Snacks set MainIngredient='Chocolate'
		WHERE Name LIKE '%Cho%'
		SELECT * FROM Snacks
	
		--DELETE
		SELECT @maxS = max(IdSnack) FROM Snacks
		DELETE FROM Snacks WHERE IdSnack = @maxS
		SELECT * FROM Snacks
		PRINT 'CRUD operations for table Snacks'
	END
	ELSE
	BEGIN
		PRINT N'Quantity not in [150,300]'
		RETURN
	END
END

--EXEC CRUD_SNACKS Cartofi,12,200,amidon

CREATE OR ALTER PROC CRUD_DRINKS
@name VARCHAR(30),
@price INT,
@quantity INT,
@idType VARCHAR(30)
AS
BEGIN
	DECLARE @maxD INT
	--price in interval [8,18] and idType exists
	IF (dbo.TestInterval(@price, 8, 18)=1 AND EXISTS(SELECT 1 FROM CoffeeTypes WHERE IdType=@idType))
	BEGIN
		--INSERT
		INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
		VALUES (@name, @price, @quantity, @idType)
		--READ
		SELECT * FROM CoffeeDrinks
		--UPDATE
		UPDATE CoffeeDrinks set QuantityML=300
		WHERE Name LIKE '%ice%' OR Name LIKE '%brew%'
		SELECT * FROM CoffeeDrinks
	
		--DELETE
		SELECT @maxD = max(IdDrink) FROM CoffeeDrinks
		DELETE FROM CoffeeDrinks WHERE IdDrink = @maxD
		SELECT * FROM CoffeeDrinks
		PRINT 'CRUD operations for table CoffeeDrinks'
	END
	ELSE
	BEGIN
		PRINT N'Price not in [8, 18] or CoffeType doesnt exist'
		RETURN
	END
END

--EXEC CRUD_DRINKS Icey,13,250,3

CREATE OR ALTER PROC CRUD_MENU
@idSnack INT,
@idDrink INT,
@price INT
AS
BEGIN
	DECLARE @maxM INT
	--price in interval [10,18] and IdDrink and IdSnacks exists
	IF (dbo.TestInterval(@price, 10, 18)=1 AND EXISTS(SELECT 1 FROM CoffeeDrinks WHERE IdDrink=@idDrink) AND EXISTS(SELECT 1 FROM Snacks WHERE IdSnack=@idSnack))
	BEGIN
		--INSERT
		INSERT INTO Menu(IdSnack, IdDrink, Price)
		VALUES (@idSnack, @idDrink, @price)
		--READ
		SELECT * FROM Menu
		--UPDATE
		UPDATE Menu set Price=Price+1
		SELECT * FROM Menu
	
		--DELETE
		DELETE FROM Menu WHERE IdSnack = @idSnack AND IdDrink = @idDrink 
		SELECT * FROM Menu
		PRINT 'CRUD operations for table Menu'
	END
	ELSE
	BEGIN
		PRINT N'Price not in [10,18] or Snack/Drink doesnt exist'
		RETURN
	END
END

--EXEC CRUD_MENU 6,10,11

--VIEWS and INDEXES
CREATE OR ALTER VIEW Drinks_View AS
	SELECT Name FROM CoffeeDrinks ORDER BY Price OFFSET 0 ROWS

CREATE OR ALTER VIEW SnacksView AS
	SELECT Name FROM Snacks Order by Quantity OFFSET 0 ROWS

SELECT * FROM Drinks_View
--21%
SELECT * FROM SnacksView
--21%