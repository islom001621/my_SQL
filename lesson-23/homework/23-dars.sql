
create database Lesson_23_homework;

use Lesson_23_homework;



CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');

select * from Dates;

--Task 1

Select *, CASE 
    WHEN MONTH(dt) < 10 THEN CONCAT('0', MONTH(dt))
    ELSE CAST(MONTH(dt) AS CHAR)
  END AS  MonthPrefixedWithZero   from Dates


--Task 2

CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);

select * from MyTabel;


;with cte as (Select  Id  ,rID,max(Vals) as MaxVals  from MyTabel 
group by Id,rID )

select COUNT(distinct Id) as Distinct_Ids  ,rID,Sum(MaxVals) as TotalOfMaxVals  from cte
group by rID


CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

Select * from TestFixLengths;

Select * from TestFixLengths
WHERE Vals IS NOT NULL AND  LEN(Vals) BETWEEN 6 AND 10



CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);

select * from TestMaximum;

--Task 4


SELECT *
FROM TestMaximum t
WHERE Vals = (
    SELECT MAX(Vals)
    FROM TestMaximum
    WHERE ID = t.ID
)






CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

select * from SumOfMax;

--Task 5

SELECT Id, SUM(MaxVal) AS SumOfMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS max_per_group
GROUP BY Id;


CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

select * from TheZeroPuzzle;

--Task 6

SELECT 
    Id, 
    a, 
    b, 
    CASE 
        WHEN a - b = 0 THEN '' 
        ELSE CAST(a - b AS VARCHAR)
    END AS OUTPUT
FROM TheZeroPuzzle;


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);

select * from Sales;

--Task 7
Select sum(QuantitySold*UnitPrice) as TotalRevenue from Sales

--Task 8
Select avg(UnitPrice) as AvgPrice from Sales

--Task 9
SELECT COUNT(*) AS TotalTransactions
FROM Sales;

--TAsk 10

SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales

--TAsk 11
Select Category,sum(QuantitySold) SumSold from Sales
group by Category

--Task 12
Select Region,sum(QuantitySold*UnitPrice) as TotalRev from Sales
group by Region

--Task 13

SELECT TOP 1
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM 
    Sales
GROUP BY
    Product
ORDER BY
    TotalRevenue DESC;


--Task 14

Select s1.SaleID,
       s1.SaleDate,
	   (s1.QuantitySold*s1.UnitPrice) as revenue,
	   (Select Sum(QuantitySold*UnitPrice) FRom Sales as S2
	   where s2.SaleDate<=s1.SaleDate) as runningtotal
		
from Sales as s1
order by s1.SaleDate


--Task 15


SELECT
    category,
    sum (QuantitySold*UnitPrice) as Revenue ,
    ROUND(100.0 * SUM(QuantitySold*UnitPrice) / (SELECT SUM(QuantitySold*UnitPrice) FROM sales), 2) AS percentage_of_total
FROM sales
GROUP BY category
ORDER BY Revenue DESC;



CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);
INSERT INTO Customers (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');

select * from Customers;

--Task 17
Select s.SaleID,c.CustomerName from Customers as C
join Sales as S
on c.CustomerID=s.CustomerID

--TAsk 18

Select c.CustomerID,c.CustomerName from Customers as C
 left join Sales as S
on c.CustomerID=s.CustomerID
where c.CustomerID is null


--TAsk 19
Select c.CustomerName, sum(s.QuantitySold*s.UnitPrice) as Revenue from Customers as C
join Sales as S
on c.CustomerID=s.CustomerID
group by c.CustomerName
ORDER BY Revenue DESC;

--Task 20

;with cte as (Select  c.CustomerName, 
        sum(s.QuantitySold*s.UnitPrice) as Revenue,
		ROW_NUMBER() over (order by sum(s.QuantitySold*s.UnitPrice) desc) as rankrev
		from Customers as C
join Sales as S
on c.CustomerID=s.CustomerID
group by c.CustomerName)

Select CustomerName,Revenue from cte
where rankrev=1
group by CustomerName,Revenue


--TAsk 21
Select c.CustomerName, sum(s.QuantitySold*s.UnitPrice) as totalsales from Customers as C
left join Sales as S
on c.CustomerID=s.CustomerID
group by c.CustomerName
ORDER BY totalsales DESC;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

select * from Products;

--Task 22
Select DISTINCT P.* from Products AS p
JOIN Sales AS S
ON P.ProductName=S.Product


--Task 23

Select ProductName,CostPrice  from Products 
where CostPrice =(Select max(CostPrice)  from Products )

--Task 24
Select Category,SellingPrice  from Products p
where SellingPrice >(Select avg(SellingPrice)  from Products
where Category=p.Category)
