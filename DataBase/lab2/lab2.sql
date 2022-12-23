USE Cafe
GO

INSERT INTO CoffeeShop(Name, Location, Rating)
VALUES ('5toGo', 'Centru', 7)
INSERT INTO CoffeeShop(Name, Location, Rating)
VALUES ('Teds', 'Baritiu', 9)
INSERT INTO CoffeeShop(Name, Location, Rating)
VALUES ('Captain Bean', '21 Decembrie', 8)

INSERT INTO Client(Name, Surname, Age, Email)
VALUES ('Popescu', 'Ioan', 35, 'pop.ioan@yahoo.com')
INSERT INTO Client(Name, Surname, Age, Email)
VALUES ('Munteanu', 'Ecaterina', 20, 'mnt.katy@gmail.com')
INSERT INTO Client(Name, Surname, Age, Email)
VALUES ('Ciprian', 'Vasile', 24, 'cipri_v@yahoo.com')
INSERT INTO Client(Name, Surname, Age, Email)
VALUES ('Mihai', 'Andrei', 22, 'andr.mih@yahoo.com')

INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (1, 1, 7, '2022-10-12')
INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (2,4,8,'2022-09-23')
INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (2,1,10,'2022-07-28')
INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (2,2,9,'2022-09-18')
INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (2,3,9,'2022-03-21')
INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (3,2,8,'2022-05-17')
INSERT INTO Feedback(IdCafe, IdClient, Rating, Date)
VALUES (3,4,9,'2022-07-29')

INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Latte', 166, 1)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Cold Brew', 260, 1)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Iced coffee', 297, 1)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Latte', 166, 1)
DELETE FROM CoffeeTypes WHERE IdType=4;
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Espresso', 63, 1)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Latte', 166, 2)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Brewed coffee', 210, 2)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Iced coffee', 300, 2)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Cappucino', 75, 2)
DELETE FROM CoffeeTypes WHERE IdType=8;
DELETE FROM CoffeeTypes WHERE IdType=9;
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Black tea', 48, 3)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Decaf coffee',3, 3)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Flat white', 166, 3)
INSERT INTO CoffeeTypes(Type, CaffeineMg, IdCafe)
VALUES('Latte', 166, 3)

INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Caramel latte', 10, 240,1)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Cold Brew latte', 14, 250,2)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Vanilla iced coffee', 16, 300,3)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Esspresso',8, 30,5)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Pumpkin spice latte',15,240,6)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Brew latte',17,250,7)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Earl grey', 13,200,10)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Decoffee', 10, 180, 11)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Flat white', 12,150,12)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Amaretto Latte', 14, 250, 13)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Caramel iced coffee', 16, 300, 14)
INSERT INTO CoffeeDrinks(Name, Price, QuantityML, IdType)
VALUES ('Cappucino', 12, 150, 15)

INSERT INTO Snacks(Name, Price, Quantity, MainIngredient)
VALUES ('Ice cream', 11, 250, 'milk')
INSERT INTO Snacks(Name, Price, Quantity, MainIngredient)
VALUES ('Muffins',11,200, 'eggs/flour')
INSERT INTO Snacks(Name, Price, Quantity, MainIngredient)
VALUES ('Cookies',12,150,'flour')
INSERT INTO Snacks(Name, Price, Quantity, MainIngredient)
VALUES ('Chips',9,200,'potatoes')
INSERT INTO Snacks(Name, Price, Quantity, MainIngredient)
VALUES ('Croissant',7,200,'flour')

INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(3,1,15)
INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(3,5,15)
INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(4,8,10)
INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(5,7,13)
INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(6,9,12)
INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(7,12,16)
INSERT INTO Menu(IdSnack, IdDrink, Price)
VALUES(7,10,16)

INSERT INTO Adress(Street, Block, StaircaseNR, Apartment)
VALUES ('Dorobantilor','x2',1,5)
INSERT INTO Adress(Street, Block, StaircaseNR, Apartment)
VALUES ('21 Decembrie','e2',4,13)
INSERT INTO Adress(Street, Block, StaircaseNR, Apartment)
VALUES ('Plopilor','a2',4,9)
INSERT INTO Adress(Street, Block, StaircaseNR, Apartment)
VALUES ('Aurel Vlaicu','c4',3,21)

INSERT INTO OnlineOrder(IdDrink, IdAdress, NumberOfDrinks,Date,Time, TotalPrice)
VALUES (10,1,4,'2022-09-21','14:21:06',58)
INSERT INTO OnlineOrder(IdDrink, IdAdress, NumberOfDrinks,Date,Time, TotalPrice)
VALUES (5,2,3,'2022-10-12','10:02:34',55)
INSERT INTO OnlineOrder(IdDrink, IdAdress, NumberOfDrinks,Date,Time, TotalPrice)
VALUES (7,2,2,'2022-05-24','16:02:34',25)
INSERT INTO OnlineOrder(IdDrink, IdAdress, NumberOfDrinks,Date,Time, TotalPrice)
VALUES (3,3,5,'2022-11-09','11:30:21',90)
INSERT INTO OnlineOrder(IdDrink, IdAdress, NumberOfDrinks,Date,Time, TotalPrice)
VALUES (6,4,2,'2022-08-27','12:12:45',44)
INSERT INTO OnlineOrder(IdDrink, IdAdress, NumberOfDrinks,Date,Time, TotalPrice)
VALUES (2,4,2,'2022-08-27','12:21:45',34)

INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Andrei Gabrian', 8,6,1)
INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Mihaela Popa',9,4,1)
INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Ana Maria',7,4,2)
INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Sergiu Andi',10,8,2)
INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Andra Ioana',9,8,2)
INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Andrei Ioan',9,8,3)
INSERT INTO Employee(Name,Experience,HoursOfWork,IdCafe)
VALUES ('Matilda Ioana',10,8,3)

INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(1,2500,30)
INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(2,1700,28)
INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(3,1800,13)
INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(4,2600,16)
INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(5,2550,17)
INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(6,2500,14)
INSERT INTO Salary(IdSalary,MoneyAmount,PaymentDay)
VALUES(7,2700,25)

SELECT * FROM CoffeeShop
SELECT * FROM Client
SELECT * FROM Feedback
SELECT * FROM CoffeeTypes
SELECT * FROM CoffeeDrinks
SELECT * FROM Snacks
SELECT * FROM Menu
SELECT * FROM Adress
SELECT * FROM OnlineOrder
SELECT * FROM Employee
SELECT * FROM Salary

--interogari cu DISTINCT si WHERE
--interogare care afiseaza toti clientii diferiti, media la review-urile lasate, si numarul de review-uri lasate
--sunt doar clientii cu varste intre 18 si 26 de ani
SELECT DISTINCT cl.Name AS ClientName,cl.Surname,cl.Age,AVG(f.Rating) AS RatingAVG,COUNT(f.IdCafe) AS TotalReviews
FROM Feedback f INNER JOIN Client cl on cl.IdClient=f.IdClient
WHERE cl.Age BETWEEN 18 AND 26
GROUP BY cl.Name,cl.Surname,cl.Age

--arata toate snacksurile distincte din meniuri care incep cu litera "c" si au cantitatea mai mare de 200
SELECT DISTINCT s.Name AS MenuSnacks, s.Quantity, s.MainIngredient 
FROM Snacks s INNER JOIN Menu m on s.IdSnack=m.IdSnack
WHERE s.Name LIKE 'C%' AND s.Quantity >= 200

--arata toate cafenelele distincte si numarul de angajati pentru fiecare
SELECT DISTINCT c.IdCafe, c.Name,COUNT(e.IdCafe) AS NR_Employees
FROM CoffeeShop c INNER JOIN Employee e on e.IdCafe = c.IdCafe
GROUP BY c.IdCafe, c.Name

--interogri cu info >2 tabele
--1
--toti angajatii cu salariu mai mare de 2500 de lei si cafeneaua unde lucreaza
SELECT e.Name,s.MoneyAmount,c.Name
FROM Salary s INNER JOIN Employee e on s.IdSalary = e.IdEmployee
INNER JOIN CoffeeShop c on e.IdCafe = c.IdCafe
WHERE s.MoneyAmount >=2500

--relatie m-n
--2
--comenzile online cu bauturi mai scumpe de 10 lei, cantitatea lor medie, adresa unde au fost livrate si data
--ordonate dupa data comenzii
SELECT o.Date,c.Name,AVG(c.QuantityML) AS AvgQuantity,c.Price,a.Street,a.Block,a.Apartment
FROM OnlineOrder o INNER JOIN Adress a on o.IdAdress=a.IdAdress
INNER JOIN CoffeeDrinks c on o.IdDrink=c.IdDrink
WHERE c.Price >=10
GROUP BY o.Date,c.Name,c.Price,a.Street,a.Block,a.Apartment
HAVING AVG(c.QuantityML) >=200
ORDER BY o.Date

--relatie m-n
--3
--toate meniurile care au snack care incepe cu litera "c" si cantitatea medie >=200,
--numele bauturii impreuna cu snackul, ordonate dupa pretul meniului
SELECT co.Name AS Drink, s.Name AS Snack,  AVG(s.Quantity) AS TotalQuantity, m.Price
FROM Menu m INNER JOIN CoffeeDrinks co on m.IdDrink=co.IdDrink 
INNER JOIN Snacks s on m.IdSnack=s.IdSnack
WHERE s.Name LIKE 'C%'
GROUP BY co.Name, s.Name, m.Price
HAVING AVG(s.Quantity)>=200
ORDER BY m.Price

--4
--toate bauturile care contin in nume "latte", "brew" sau "coffee" impreuna cu tipul lor
--trebuie sa aiba cantitatea medie de cafeina mai mare de 200 si sunt ordonate dupa pretul bauturii
SELECT dr.Name AS CoffeeDrink, ty.Type AS Type, sh.Name, dr.Price, AVG(ty.CaffeineMg) AS Caffeine
FROM CoffeeTypes ty INNER JOIN CoffeeDrinks dr on ty.IdType=dr.IdType
INNER JOIN CoffeeShop sh on ty.IdCafe=sh.IdCafe
WHERE ty.Type LIKE '%latte%' OR ty.Type LIKE '%brew%' OR ty.Type LIKE '%coffee%'
GROUP BY dr.Name, ty.Type, sh.Name, dr.Price
HAVING AVG(ty.CaffeineMg) >= 200
ORDER BY dr.Price

--5
--arata toate reviewurile lasate pentru fiecare cafenea, impreuna cu numele clientului si data feedback ului
--ordonate dupa rating descrescator
SELECT cl.Name AS ClientName,cl.Surname, co.Name, f.Rating, f.Date
FROM Feedback f INNER JOIN Client cl on cl.IdClient=f.IdClient
INNER JOIN CoffeeShop co on co.IdCafe=f.IdCafe
ORDER BY f.Rating DESC

--6
--arata top 5 angajati care au cea mai multa experienta ordonati descrescator
--impreuna cu salarul, orele de munca, numele cafenelei unde lucreaza si ratinul cafenelei
SELECT TOP 5 e.Experience,e.Name, s.MoneyAmount, e.HoursOfWork, c.Name, c.Rating
FROM Salary s INNER JOIN Employee e on s.IdSalary = e.IdEmployee
INNER JOIN CoffeeShop c on e.IdCafe = c.IdCafe
ORDER BY e.Experience DESC

--7
--arata top 3 cele mai ieftine meniuri impreuna cu snacksurile si bauturile incluse
-- si cantitatile acestora
SELECT TOP 3 m.Price as CheapestPrice, s.Name AS Snack,s.Quantity,co.Name AS Drink, co.QuantityML
FROM Menu m INNER JOIN CoffeeDrinks co on m.IdDrink=co.IdDrink 
INNER JOIN Snacks s on m.IdSnack=s.IdSnack
ORDER BY m.Price ASC

SELECT * FROM Snacks

