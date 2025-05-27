
create database Lesson_21_homework


use Lesson_21_homework;

--Tables 

CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);

select * from ProductSales;

--Task 1

Select SaleID, 
       ProductName,
	   SaleAmount, 
	   Quantity, 
	   CustomerID,
	   SaleDate,
	   ROW_NUMBER() over (order by SaleDate) as SaleDateNum  
from ProductSales

--Task 2


Select
       ProductName,
	   Sum(Quantity)  as TotalQuantity ,
       Dense_rank() over (Order by Sum(Quantity)) as RankTotalQuantity
from ProductSales
group by  
       ProductName
	  



--Task 3
;with RankedSales  as (Select CustomerID,
       SaleAmount,
	   ROW_NUMBER() over (partition by CustomerID order by Saleamount desc) as RowSaleamount 
from ProductSales
       where  CustomerID = (Select MAX(CustomerID) from ProductSales))

Select * from RankedSales 
where RowSaleamount=1

--Task 4

Select CustomerID,
       SaleAmount,
	   LEAD(SaleAmount) over ( order by SaleDate ) as NextSaleamount ,
	   SaleDate
from ProductSales
       
--Task 5

Select CustomerID,
       SaleAmount,
	   lag(SaleAmount) over ( order by SaleDate ) as PreviousSaleAmount ,
	   SaleDate
from ProductSales


--Task 6

;with cte as (Select 
       CustomerID,
       SaleAmount,
	   lag(SaleAmount) over ( order by SaleDate ) as PreviousSaleAmount ,
	   SaleDate
from ProductSales)

select * from cte
where SaleAmount>PreviousSaleAmount


--Task 7

SELECT 
    ProductName,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromPrevious
FROM ProductSales;



--Task 8

Select CustomerID,
       SaleAmount,
	   LEAD(SaleAmount) over ( order by SaleDate ) as NextSaleamount ,
	  ( (LEAD(SaleAmount) over ( order by SaleDate )-SaleAmount)/SaleAmount )*100 as PercentageChange
from ProductSales


--Task 9
SELECT 
    ProductName,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
     SaleAmount / nullif(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate),0) AS RatioFromPrevious
FROM ProductSales;

--Task 10
Select ProductName,
       SaleAmount,First_value(SaleAmount) over(partition by ProductName order by SaleDate asc) as FirstValue,
       SaleAmount-First_value(SaleAmount) over(partition by ProductName order by SaleDate asc) as Difference
from ProductSales


--Task 11

;with cte as (Select ProductName,
       SaleAmount,
       lag(SaleAmount) over (partition by ProductName order by Saledate asc) as PreviousSaleAmount
from ProductSales)

Select * from cte
where SaleAmount>PreviousSaleAmount


--Task 12
Select SaleID,
       SaleDate,
	   SaleAmount,
	   Sum(SaleAmount) over (order by SaleDate) as RunningTotal 
from ProductSales


--Task 13

Select 
SaleID,
       SaleDate,
	   SaleAmount,
	   avg(SaleAmount) over (order by SaleDate  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as MovingAverage 
from ProductSales

--Task 14

Select 
SaleID,
       SaleDate,
	   SaleAmount,
	   SaleAmount-avg(SaleAmount) over () as DifferenceFromAverage 
from ProductSales


CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');

select * from Employees1;


--task 15
WITH SalaryRanks AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SalaryRank
FROM SalaryRanks
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM SalaryRanks
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank;


--Task 16
;with cte as (Select  Name,
        Department,
		Salary,
		dense_rank() over (partition by Department order by Salary desc) as RankSalary from Employees1
)

Select Name,Department,Salary,RankSalary from cte
where RankSalary<=2
order by Department,RankSalary


--Task 17
;with cte as (Select  Name,
        Department,
		Salary,
		dense_rank() over (partition by Department order by Salary ) as RankSalary from Employees1
)


Select Name,Department,Salary,RankSalary from cte
where RankSalary=1
order by Department,RankSalary

--Task 18
;with cte as (Select Name,
       Department,
	   Salary,
	   Sum(Salary) over (partition by Department order by Name) as RunningTotal 
from Employees1)

Select Department,sum(RunningTotal)as SumRunningTotal from cte
group by Department


;with cte as (SELECT
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department
        ORDER BY Name
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM
    Employees1)
	Select Department,sum(RunningTotal)as SumRunningTotal from cte
group by Department

--Task 19
Select distinct
Department,
sum(salary) over (partition by Department ) as TotalAmount
from Employees1


--Task 20


Select distinct
Department,
avg(salary) over (partition by Department) as TotalAmount
from Employees1


--Task 21

SELECT
    Name,
    Department,
    Salary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM Employees1;


--Task 22

SELECT 
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY HireDate
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAverage
FROM Employees1
ORDER BY HireDate, Name;



--Task 23

;with cte as (Select Name,Department,Salary,HireDate,  ROW_NUMBER() OVER (ORDER BY HireDate DESC) as RowNum
from Employees1)

Select RowNum,HireDate,Sum(Salary) as LastHired from cte
where RowNum<=3
group by RowNum,HireDate

