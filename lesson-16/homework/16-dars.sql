
use Lesson_16_homework;

--Tables


CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

select * from Numbers1;
--------------------------------------------------------------------------------------

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')

select * from FindSameCharacters;
-------------------------------------------------------------------------------------------------------

CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )

select * from RemoveDuplicateIntsFromNames;
-----------------------------------------------------------------------------------------

CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');

select * from Example;
-------------------------------------------------------------------------------------------------

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

select * from Employees;
---------------------------------------------------------------------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

select * from Departments;
-------------------------------------------------------------------------------------------------------

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES

(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

select * from Sales;
----------------------------------------------------------------------------

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);


select * from Products;
-----------------------------------------------------------------------------------------------

--Task 1

select * from Numbers1;


WITH  number AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM number
    WHERE num < 1000)
	select * from number
	option (maxrecursion 1000); 

--Task 2

select Employees.EmployeeID,Employees.FirstName,Totalsales
	from Employees
join 
	(select employeeID,sum(salesamount) as Totalsales
from Sales
	group by employeeid) Sales on Employees.EmployeeID=Sales.EmployeeID;

--Task 3

WITH AvgSalaryCTE AS (
    SELECT AVG(salary) AS avg_salary
    FROM Employees
)
SELECT * FROM AvgSalaryCTE;

--Task 4

select Products.ProductID,Products.ProductName,Maxsalary
	from Products
join 
	(select ProductID,max(salesamount) as Maxsalary
from Sales
	group by ProductID) Sales on Products.ProductID=Sales.ProductID;


-- task 5

With cte as (
select 1 as num 
union all 
select num * 2
from cte 
where num * 2 < 1000000
)
select num from cte
option(maxrecursion 0)


-- task 6

with cte as (
select S.EmployeeID, Count(*) as SaleCount
from Sales S
group by EmployeeID
Having Count(*) > 5
)
select E.FirstName
from cte
join Employees E on E.EmployeeID = cte.EmployeeID

-- task 7 

with cte as (
select ProductID, Sum(SalesAmount) as SumAmount
from Sales
Group by ProductID
Having Sum(SalesAmount) > 500
)
select 
  Products.ProductName,
  cte.SumAmount
from cte
join Products on Products.ProductID = cte.ProductID

-- task 8

with cte as (
select 
  Avg(Salary) as AvgSalary
from Employees
)
select
  FirstName,
  Salary
from Employees
cross join cte 
where Employees.Salary > cte.AvgSalary

-------------  Medium Tasks  -----------------

-- task 1

SELECT TOP 5 E.FirstName, S.OrderCount
FROM (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) AS S
JOIN Employees E ON E.EmployeeID = S.EmployeeID
ORDER BY S.OrderCount DESC;

-- task 2

SELECT P.CategoryID, SUM(SalesByProduct.TotalSales) AS TotalSales
FROM (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) AS SalesByProduct
JOIN Products P ON SalesByProduct.ProductID = P.ProductID
GROUP BY P.CategoryID;


-- task 3

WITH FactorialCTE AS (
    SELECT Number, 1 AS Step, 1 AS Factorial
    FROM Numbers1

    UNION ALL

    SELECT f.Number, f.Step + 1, f.Factorial * (f.Step + 1)
    FROM FactorialCTE f
    WHERE f.Step + 1 <= f.Number
)
SELECT Number, MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
OPTION (MAXRECURSION 1000);


-- task 5

WITH MonthlySales AS (
    SELECT 
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesDifference AS (
    SELECT 
        curr.SaleYear,
        curr.SaleMonth,
        curr.TotalSales AS CurrentSales,
        prev.TotalSales AS PreviousSales,
        curr.TotalSales - ISNULL(prev.TotalSales, 0) AS SalesDifference
    FROM MonthlySales curr
    LEFT JOIN MonthlySales prev
        ON (prev.SaleYear = CASE 
                WHEN curr.SaleMonth = 1 THEN curr.SaleYear - 1 
                ELSE curr.SaleYear 
           END)
        AND (prev.SaleMonth = CASE 
                WHEN curr.SaleMonth = 1 THEN 12 
                ELSE curr.SaleMonth - 1 
           END)
)
SELECT *
FROM SalesDifference
ORDER BY SaleYear, SaleMonth;


-- task 6

SELECT 
    e.EmployeeID,
    e.FirstName,
    q.SaleYear,
    q.Quarter,
    q.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        YEAR(SaleDate) AS SaleYear,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) q ON e.EmployeeID = q.EmployeeID
ORDER BY e.EmployeeID, q.SaleYear, q.Quarter;


----------------------  Difficult Tasks  --------------------------

-- task 1

WITH FibonacciCTE AS (
    -- Bazaviy holat: 0 va 1
    SELECT 0 AS FibonacciNumber, 1 AS Position
    UNION ALL
    -- Rekursiv qism: Fibonacci sonini hisoblash
    SELECT f.FibonacciNumber + prev.FibonacciNumber, f.Position + 1
    FROM FibonacciCTE f
    JOIN FibonacciCTE prev ON f.Position = prev.Position + 1
    WHERE f.Position < 20  -- Fibonacci soni 20 tagacha bo'lishi kerak
)
SELECT FibonacciNumber
FROM FibonacciCTE
ORDER BY Position
OPTION (MAXRECURSION 20);  -- Rekursiyani 20 martagacha cheklash




-- task 2

SELECT Vals
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND Vals NOT LIKE '%[^' + LEFT(Vals, 1) + ']%';

-- task 3

DECLARE @n INT = 5;

WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(100)) AS SequenceStr
    UNION ALL
    SELECT num + 1, CAST(SequenceStr + CAST(num + 1 AS VARCHAR(100)) AS VARCHAR(100))
    FROM Numbers
    WHERE num + 1 <= @n
)
SELECT SequenceStr
FROM Numbers
ORDER BY num
OPTION (MAXRECURSION 1000);

-- task 4

SELECT EmployeeID, TotalSales
FROM (
    SELECT e.EmployeeID, SUM(s.SalesAmount) AS TotalSales
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
    WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())  
    GROUP BY e.EmployeeID
) AS DerivedTable
WHERE TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT SUM(s.SalesAmount) AS TotalSales
        FROM Sales s
        WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY s.EmployeeID
    ) AS MaxSales
);

-- task 5

WITH SplitNumbers AS (
    -- Har bir 'Pawan_slug_name'dagi raqamlarni ajratib olish
    SELECT 
        PawanName,
        Pawan_slug_name,
        value AS Number
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(Pawan_slug_name, '-')  -- '-' belgisi orqali ajratamiz
    WHERE ISNUMERIC(value) = 1  -- Faqat raqamlarni tanlaymiz
),
UniqueNumbers AS (
    -- Har bir 'Pawan_slug_name'dagi raqamlarni alohida ajratamiz, takrorlarini olib tashlaymiz
    SELECT 
        PawanName,
        Pawan_slug_name,
        -- Raqamlarni ajratib olish
        STUFF((SELECT '-' + Number
               FROM SplitNumbers sn
               WHERE sn.PawanName = s.PawanName
               FOR XML PATH('')), 1, 1, '') AS CleanedNumbers
    FROM RemoveDuplicateIntsFromNames s
    GROUP BY PawanName, Pawan_slug_name
),
FinalCleanedData AS (
    -- Yagona raqamni olib tashlash
    SELECT 
        PawanName,
        Pawan_slug_name,
        CleanedNumbers,
        CASE
            WHEN CHARINDEX('1', CleanedNumbers) > 0 THEN REPLACE(CleanedNumbers, '1', '') -- Agar '1' bo'lsa, uni olib tashlash
            ELSE CleanedNumbers
        END AS CleanedName
    FROM UniqueNumbers
)
SELECT PawanName, CleanedName
FROM FinalCleanedData;
