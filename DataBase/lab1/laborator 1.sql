Create database Cafe
go
use Cafe
go

CREATE TABLE CoffeeShop
(IdCafe INT PRIMARY KEY IDENTITY,
Name varchar(50),
Location varchar(100) NOT NULL,
Rating int)

CREATE TABLE Client
(IdClient INT PRIMARY KEY IDENTITY(1,1),
Name varchar(50),
Surname varchar(50),
Age int,
Email varchar(100))

CREATE TABLE Feedback
(IdCafe INT FOREIGN KEY REFERENCES CoffeeShop(IdCafe),
IdClient INT FOREIGN KEY REFERENCES Client(IdCLient),
Rating INT,
Date DATE,
CONSTRAINT pk_Feedback PRIMARY KEY (IdCafe,IdClient))

CREATE TABLE CoffeeTypes
(IdType INT PRIMARY KEY IDENTITY,
Type varchar(50) DEFAULT 'latte',
CaffeineMg INT,
IdCafe INT FOREIGN KEY REFERENCES CoffeeShop(IdCafe))

CREATE TABLE CoffeeDrinks
(IdDrink INT PRIMARY KEY IDENTITY,
Name varchar(50),
Price INT,
QuantityML INT,
IdType INT FOREIGN KEY REFERENCES CoffeeTypes(IdType))

CREATE TABLE Snacks
(IdSnack INT PRIMARY KEY IDENTITY,
Name varchar(50),
Price INT,
Quantity INT,
MainIngredient varchar(100))

CREATE TABLE Menu
(IdSnack INT FOREIGN KEY REFERENCES Snacks(IdSnack),
IdDrink INT FOREIGN KEY REFERENCES CoffeeDrinks(IdDrink),
Price INT,
CONSTRAINT pk_Menu PRIMARY KEY (IdSnack,IdDrink))

CREATE TABLE Adress
(IdAdress INT PRIMARY KEY IDENTITY(1,1),
Street varchar(100),
Block varchar(10),
StaircaseNR INT,
Apartment INT)

CREATE TABLE OnlineOrder
(IdDrink INT FOREIGN KEY REFERENCES CoffeeDrinks(IdDrink),
IdAdress INT FOREIGN KEY REFERENCES Adress(IdAdress),
NumberOfDrinks INT,
Date DATE,
Time TIME,
TotalPrice INT,
CONSTRAINT pk_OnlineOrder PRIMARY KEY (IdDrink,IdAdress))

CREATE TABLE Employee
(IdEmployee INT PRIMARY KEY IDENTITY,
Name varchar(50),
Experience INT,
HoursOfWork INT,
IdCafe INT FOREIGN KEY REFERENCES CoffeeShop(IdCafe))

CREATE TABLE Salary
(IdSalary INT FOREIGN KEY REFERENCES Employee(IdEmployee),
MoneyAmount INT,
PaymentDay INT,
CONSTRAINT pk_Salary PRIMARY KEY(IdSalary))
