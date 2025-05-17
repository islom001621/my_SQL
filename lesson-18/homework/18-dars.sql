
create database Lesson_18_homework;

use Lesson_18_homework;

--Tables

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);


INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

select * from Products;

---------------------------------------------------------------------------------------------

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

select * from Sales;

-------------------------------------------------------------------------------------------

--task 1

select * from Products;
select * from Sales;

CREATE TABLE #MonthlySales (
    ProductID INT,
    ProductName VARCHAR(100),
    TotalQuantity INT,
    TotalRevenue DECIMAL(12,2)
);

INSERT INTO #MonthlySales (ProductID, ProductName, TotalQuantity, TotalRevenue)
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE 
    MONTH(s.SaleDate) = MONTH(GETDATE()) AND
    YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY p.ProductID, p.ProductName;

SELECT * FROM #MonthlySales;

--task 2

CREATE VIEW vw_ProductSalesSummary AS(
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category, p.Price);

select * from vw_ProductSalesSummary;

--task 3

CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)

BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;

SELECT dbo.fn_GetTotalRevenueForProduct(1) AS TotalRevenue;
------------------------------


--task 4

CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @TotalSales INT;

    SELECT @TotalSales = SUM(s.Quantity)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE p.Category = @Category;

    RETURN ISNULL(@TotalSales, 0);
END;

SELECT dbo.fn_GetSalesByCategory('Electronics') AS TotalSalesForElectronics;

--task 5 

CREATE FUNCTION dbo.fn_IsPrimeYesNo (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @inc INT = 2
    DECLARE @Result VARCHAR(3) = 'Yes'

    IF @Number < 2
        RETURN 'No'

    WHILE @inc * @inc <= @Number
    BEGIN
        IF @Number % @inc = 0
        BEGIN
            SET @Result = 'No'
            BREAK
        END
        SET @inc = @inc + 1
    END

    RETURN @Result
END;

SELECT dbo.fn_IsPrimeYesNo(7) AS Result;   
SELECT dbo.fn_IsPrimeYesNo(25) AS Result;  
SELECT dbo.fn_IsPrimeYesNo(1) AS Result;   

--task 6

CREATE FUNCTION fn_GetNumbersBetween (
    @Start INT,
    @End INT
)
RETURNS @NumberList TABLE (
    Number INT
)
AS
BEGIN
    DECLARE @Current INT = @Start;

    WHILE @Current <= @End
    BEGIN
        INSERT INTO @NumberList (Number)
        VALUES (@Current);

        SET @Current = @Current + 1;
    END

    RETURN;
END;

SELECT * FROM fn_GetNumbersBetween(5,12);

--task 7

CREATE TABLE Employee (
    EmpID INT,
    EmpName VARCHAR(50),
    Salary INT
);

INSERT INTO Employee VALUES
(1, 'Ali', 50000),
(2, 'Vali', 60000),
(3, 'Sami', 50000),
(4, 'John', 70000),
(5, 'Mary', 80000);

select * from Employee;


DECLARE @N INT = 3;

SELECT MIN(Salary) AS NthHighestSalary
FROM (
    SELECT DISTINCT Salary
    FROM Employee
    ORDER BY Salary DESC
    OFFSET 0 ROWS FETCH NEXT @N ROWS ONLY
) AS TopSalaries;

--task 8

SELECT user_id, COUNT(*) AS total_friends
FROM Friendships
GROUP BY user_id
ORDER BY total_friends DESC
LIMIT 1;

--task 9

CREATE TABLE Customers2 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO Customers2 (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

select * from Customers2;
-------------------------------------------------------------------

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers2(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);


INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);

select * from Orders;


CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    Customers2.customer_id,
    Customers2.name,
    Customers2.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers2 c
LEFT JOIN Orders o ON Customers2.customer_id = o.customer_id
GROUP BY Customers2.customer_id, c.name, c.city;

SELECT * FROM vw_CustomerOrderSummary;

--task 10 

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);

select * from Gaps;

SELECT 
    RowNumber,
    MAX(TestCase) OVER (
        ORDER BY RowNumber
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS FilledTestCase
FROM Gaps;
