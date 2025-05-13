
create database Lesson_17_Homework;

use Lesson_17_Homework;

--Task 1

CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);

INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

 select * from #RegionSales;

 -- 1. Avval distributorlardan va regionlardan kombinatsiya olish (CROSS JOIN)
WITH DistRegions AS (
    SELECT d.Distributor, r.Region
    FROM (SELECT DISTINCT Distributor FROM #RegionSales) d
    CROSS JOIN (SELECT DISTINCT Region FROM #RegionSales) r
)

-- 2. CROSS JOIN natijasini asl savdo jadvali bilan LEFT JOIN orqali birlashtirish
SELECT 
    dr.Region,
    dr.Distributor,
    COALESCE(rs.Sales, 0) AS Sales
FROM DistRegions dr
LEFT JOIN #RegionSales rs 
    ON dr.Region = rs.Region AND dr.Distributor = rs.Distributor
ORDER BY dr.Distributor, dr.Region;


--Task 2

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);


INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select * from Employee;

SELECT 
    managerId AS ManagerID,
    COUNT(*) AS DirectReports
FROM 
    Employee
WHERE 
    managerId IS NOT NULL
GROUP BY 
    managerId
HAVING 
    COUNT(*) >= 5;


--Task 3

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));

INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');

select * from Products;

CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);

INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select * from Orders;

select * from Products;
select * from Orders;

SELECT 
    p.product_name,
    SUM(o.unit) AS total_units
FROM 
    Orders o
JOIN 
    Products p ON o.product_id = p.product_id
WHERE 
    o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;

--Task 4

CREATE TABLE Orders2(
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);

INSERT INTO Orders2 values 
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

select * from Orders2;



WITH VendorOrderCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS order_count
    FROM Orders2
    GROUP BY CustomerID, Vendor
),
RankedVendors AS (
    SELECT 
        CustomerID,
        Vendor,
        order_count,
        RANK() OVER (PARTITION BY CustomerID ORDER BY order_count DESC) AS rnk
    FROM VendorOrderCounts
)
SELECT 
    CustomerID,
    Vendor,
    order_count
FROM RankedVendors
WHERE rnk = 1;

--Task 5

DECLARE @Check_Prime INT = 91;

DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';



--Task 6

CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);

INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

select * from Device;


WITH LocationCounts AS (
    SELECT Locations, COUNT(*) AS total_signals
    FROM Device
    GROUP BY Locations
),
DeviceCounts AS (
    SELECT Device_id, COUNT(*) AS total_signals_per_device
    FROM Device
    GROUP BY Device_id
),
MaxLocation AS (
    SELECT TOP 1 Locations AS top_location, total_signals
    FROM LocationCounts
    ORDER BY total_signals DESC
)
-- Barcha natijalarni birinchi qismda chiqarish
SELECT 
    (SELECT COUNT(DISTINCT Locations) FROM Device) AS total_unique_locations,
    top_location,
    total_signals AS max_signals_in_location
FROM MaxLocation;

-- Qurilmalar bo‘yicha signal soni
SELECT * FROM DeviceCounts;


--Task 7

CREATE TABLE Employee2 (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);

INSERT INTO Employee2  Values
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select * from Employee2;


SELECT 
    E.EmpID,
    E.EmpName,
    E.Salary
FROM 
    Employee2 E
JOIN (
    SELECT 
        DeptID,
        AVG(Salary) AS AvgSalary
    FROM 
        Employee2
    GROUP BY 
        DeptID
) AS DeptAvg
ON 
    E.DeptID = DeptAvg.DeptID
WHERE 
    E.Salary > DeptAvg.AvgSalary;


	-- Task 8

	CREATE TABLE Numbers (
    Number INT
);

INSERT INTO Numbers 
VALUES
(25),
(45),
(78)

SELECT * FROM Numbers;


CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

INSERT INTO Tickets (TicketID, Number) VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

SELECT * FROM Tickets;


SELECT 
    t.TicketID,
    CASE 
        WHEN COUNT(n.Number) = 3 THEN 100
        WHEN COUNT(n.Number) > 0 THEN 10
        ELSE 0
    END AS Prize
FROM Tickets t
LEFT JOIN Numbers n ON t.Number = n.Number
GROUP BY t.TicketID;

SELECT 
    t.TicketID,
    CASE 
        WHEN COUNT(n.Number) = 3 THEN 100
        WHEN COUNT(n.Number) > 0 THEN 10
        ELSE 0
    END AS Prize
FROM Tickets t
LEFT JOIN Numbers n ON t.Number = n.Number
GROUP BY t.TicketID;


--task 9

	CREATE TABLE Spending2 (
	  User_id INT,
	  Spend_date DATE,
	  Platform VARCHAR(10),
	  Amount INT
	);

INSERT INTO Spending2      Values
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

select * from Spending2;


WITH UserPlatformSummary AS (
  SELECT 
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS used_mobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_desktop,
    SUM(Amount) AS total_amount
  FROM Spending2
  GROUP BY User_id, Spend_date
)

SELECT 
  Spend_date,

  -- Faqat Mobile
  COUNT(CASE WHEN used_mobile = 1 AND used_desktop = 0 THEN 1 END) AS mobile_only_users,
  SUM(CASE WHEN used_mobile = 1 AND used_desktop = 0 THEN total_amount END) AS mobile_only_amount,

  -- Faqat Desktop
  COUNT(CASE WHEN used_mobile = 0 AND used_desktop = 1 THEN 1 END) AS desktop_only_users,
  SUM(CASE WHEN used_mobile = 0 AND used_desktop = 1 THEN total_amount END) AS desktop_only_amount,

  -- Ikkalasi ham
  COUNT(CASE WHEN used_mobile = 1 AND used_desktop = 1 THEN 1 END) AS both_users,
  SUM(CASE WHEN used_mobile = 1 AND used_desktop = 1 THEN total_amount END) AS both_amount

FROM UserPlatformSummary
GROUP BY Spend_date
ORDER BY Spend_date;


--Task 10

CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);

INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

select * from Grouped;


WITH Numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
),
Expanded AS (
  SELECT g.Product
  FROM Grouped g
  JOIN Numbers n ON n <= g.Quantity
)
SELECT * FROM Expanded
ORDER BY Product
OPTION (MAXRECURSION 1000);
