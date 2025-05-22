
Create database Lesson_20_homework

use Lesson_20_homework

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

select * from #Sales;

-- task 1

select 
  s1.CustomerName,
  s1.SaleDate
from #Sales s1

where Exists (
  select 1
  from #Sales s2
  where s1.SaleID = s2.SaleID and 
      month(s1.SaleDate) = 3
      )

-- task 2

SELECT 
  Product from  #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT Product, SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS Revenues
);

-- task 3

SELECT *
FROM #Sales AS S1
WHERE 2 = (
    SELECT COUNT(*) 
    FROM #Sales AS S2
    WHERE S2.Product = S1.Product
      AND S1.Quantity * S1.Price <= S2.Quantity * S2.Price
)
ORDER BY S1.Product, S1.Quantity * S1.Price;

-- task 4

SELECT DISTINCT
    DATENAME(MONTH, SaleDate) AS SaleMonth,
    DATENAME(YEAR, SaleDate)  AS SaleYear,
    (
        SELECT SUM(S.Quantity)
        FROM #Sales AS S
        WHERE YEAR(S.SaleDate) = YEAR(S1.SaleDate)
          AND MONTH(S.SaleDate) = MONTH(S1.SaleDate)
    ) AS TotalQuantity
FROM #Sales AS S1
ORDER BY SaleYear, SaleMonth;

-- task 5

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);

--task 6

create table Fruits (Name varchar(50), Fruit varchar(50))

insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')

select * from Fruits;


SELECT 
    Name,
    Fruit,
    COUNT(Fruit) AS FruitCount
FROM 
    Fruits
GROUP BY 
    Name, Fruit;


	--task 7

create table Family(ParentId int, ChildID int)

insert into Family values (1, 2), (2, 3), (3, 4)

select * from Family;


SELECT 
    ParentId AS OlderPerson,
    ChildID AS YoungerPerson
FROM 
    Family;

--task 8

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);


select * from #Orders;


SELECT *
FROM #Orders
WHERE DeliveryState = 'TX'
  AND CustomerID IN (
      SELECT DISTINCT CustomerID
      FROM #Orders
      WHERE DeliveryState = 'CA'
  );

  --task 9

  create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

select * from #residents;


UPDATE #residents
SET fullname = 
    CASE 
        WHEN CHARINDEX('name=', address) > 0 
        THEN SUBSTRING(
                address,
                CHARINDEX('name=', address) + 5,
                CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - CHARINDEX('name=', address) - 5
             )
        ELSE fullname
    END
WHERE fullname IS NULL OR fullname = '';

SELECT * FROM #residents;

--task 10

CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

select * from #Routes;


select route,cost from (
select *,MAX(cost) over() as max_val,min(cost) over() as min_val from (
select concat(bekat1.DepartureCity,'-',bekat1.ArrivalCity,'-',bekat2.ArrivalCity,'-',bekat3.ArrivalCity,'-',bekat4.ArrivalCity) as route,
    bekat1.cost + bekat2.Cost + isnull(bekat3.Cost,0) + isnull(bekat4.Cost,0) as cost from (
select * from #Routes 
where DepartureCity = 'Tashkent') as  bekat1
join #Routes as bekat2 on bekat1.ArrivalCity = bekat2.DepartureCity
left join #Routes as bekat3 on bekat2.ArrivalCity = bekat3.DepartureCity
left join #Routes as bekat4 on bekat3.ArrivalCity = bekat4.DepartureCity) as A) as B
where B.cost = B.max_val or B.cost = B.min_val

--task 11

CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

select * from #RankingPuzzle;


WITH ProductGroups AS (
    SELECT 
        ID,
        Vals,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
            OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
            AS ProductGroup
    FROM #RankingPuzzle
)
SELECT 
    ID,
    Vals,
    CASE 
        WHEN Vals <> 'Product' THEN ProductGroup 
        ELSE NULL 
    END AS ProductRank
FROM ProductGroups
WHERE Vals <> 'Product'
ORDER BY ID;


--task 12

CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

select * from #EmployeeSales;


WITH DeptAvg AS (
    SELECT 
        Department,
        AVG(SalesAmount) AS AvgDeptSales
    FROM #EmployeeSales
    GROUP BY Department
)
SELECT 
    e.EmployeeName,
    e.Department,
    e.SalesAmount,
    d.AvgDeptSales
FROM 
    #EmployeeSales e
JOIN 
    DeptAvg d ON e.Department = d.Department
WHERE 
    e.SalesAmount > d.AvgDeptSales
ORDER BY 
    e.Department, e.SalesAmount DESC;

	--task 13

	SELECT e.EmployeeName, e.Department, e.SalesAmount, e.SalesMonth, e.SalesYear
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales sub
    WHERE sub.SalesMonth = e.SalesMonth
      AND sub.SalesYear = e.SalesYear
      AND sub.SalesAmount > e.SalesAmount
)
ORDER BY e.SalesMonth;

--task 14 

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

select * from Products;


SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth
        FROM #EmployeeSales
    ) AS m
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales s
        WHERE s.EmployeeName = e.EmployeeName
          AND s.SalesMonth = m.SalesMonth
    )
)
ORDER BY e.EmployeeName;


--task 15

SELECT 
    Name,
    Price,
    (SELECT AVG(Price) FROM Products) AS AveragePrice
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)
ORDER BY Price DESC;

--task 16

SELECT 
    Name, 
    Stock,
    (SELECT MAX(Stock) FROM Products) AS MaxStock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products)
ORDER BY Stock DESC;

--task 17

SELECT Name
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
)
AND Name <> 'Laptop';

--task 18

SELECT *
FROM Products
WHERE Category = 'Electronics'
  AND Price > (
      SELECT MIN(Price)
      FROM Products
      WHERE Category = 'Electronics'
  );

  --task 19

  CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

select * from Orders;

SELECT *
FROM Products P
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = P.Category
);

--task 20

SELECT DISTINCT min(P.Name)
FROM Products P
JOIN Orders O ON P.ProductID = O.ProductID;

--task 21

SELECT P.Name
FROM Products P
JOIN Orders O ON P.ProductID = O.ProductID
GROUP BY P.ProductID, P.Name
HAVING SUM(O.Quantity) > (
    SELECT AVG(TotalQty)
    FROM (
        SELECT SUM(Quantity) AS TotalQty
        FROM Orders
        GROUP BY ProductID
    ) AS ProductSums
);

--task 22

SELECT P.ProductID, P.Name
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.OrderID IS NULL;

--task 23

SELECT TOP 1 P.ProductID, P.Name, SUM(O.Quantity) AS TotalQuantityOrdered
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY P.ProductID, P.Name
ORDER BY TotalQuantityOrdered DESC;




