
Create database Lesson_22_homework

Use Lesson_22_homework;

--Tables

CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')


	select * from sales_data;


--Task 1
Select 
    customer_id,
	customer_name,
	total_amount,
	sum(total_amount) over (partition  by customer_name order by order_date  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RunningTotal
from sales_data




--Task 2

Select product_category,count(distinct sale_id) as SaleCouunt from sales_data
group by product_category


--Task 3
Select product_category,max(total_amount) as MaxTotal from sales_data
 group by product_category

 --Task 4
 Select product_category,min(unit_price) as MaxTotal from sales_data
 group by product_category
 
 

 --Task 5
 Select customer_id,
        customer_name,
		product_category,
		total_amount,
		AVG(total_amount) over(order by order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as MovingAvg
                 from  sales_data
 
  --Task 6
 Select distinct 
        region,
		sum(total_amount) over(partition by region ) as SumRegion 
                 from  sales_data
 

  --Task 7
 Select  customer_id,
                 customer_name,  
                 sum(total_amount) AS total_purchase,
                 DENSE_RANK() over (order by  sum(total_amount) desc ) as RankCustomer
                 from  sales_data
				 group by customer_id, customer_name
            
			
  --Task 8

  Select total_amount as CurrentAmount,
         LEAD(total_amount) over(order by order_date) as NextSaleAmount,
		 (total_amount-LEAD(total_amount) over(order by order_date)) as DiffSaleAmount
  from sales_data


  --Task 9

 ;with cte as (Select  product_category,
          product_name,unit_price,
		  dense_rank() over (partition by product_category order by unit_price desc) as Price 
  from sales_data)
  select * from cte 
  where Price<=3

  --Task 10

  Select region,
        order_date,
		total_amount,
		sum(total_amount) over (partition by region order by order_date   
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as SumAmount from  sales_data
  order by region,order_date



 --Task 11


 SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM
    sales_data
ORDER BY
    product_category, order_date;

 --Task 12
 CREATE TABLE numbers (
    ID INT
);

INSERT INTO numbers (ID) VALUES
(1),
(2),
(3),
(4),
(5);

select * from numbers;

Select id,sum(id) over(order by id) as SumPreValues from numbers


 --Task 13
 CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

Select Value,Sum(Value) over (order by Value  ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) as Sum_of_Previous  from OneColumn


 --Task 14


 CREATE TABLE Row_Nums (
    Id INT,
    Vals VARCHAR(10)
);
INSERT INTO Row_Nums VALUES
(101,'a'), (102,'b'), (102,'c'), (103,'f'), (103,'e'), (103,'q'), (104,'r'), (105,'p');

;with cte as (Select id,
                     Vals,
					 row_number() over(  partition by id order by Vals) as row_number_in_group ,
                     2 * DENSE_RANK() OVER (ORDER BY Id) - 1 AS start_odd_number
from Row_Nums)

Select id,
       Vals,
	    bgok9```(start_odd_number + row_number_in_group -1 ) AS RowNumber from cte


 --Task 15
 Select customer_id, 
        customer_name,
		count(distinct product_category) AS num_categories
from sales_data
group by  customer_id, 
        customer_name		
Having count(distinct product_category)>1


 --Task 16

;with Sumcte as (Select customer_id,
	   region,
	   sum(total_amount)  as customer_spending
from sales_data
group by customer_id,
	   region ),


Avgcte as (Select customer_id,
       region,
	   avg(total_amount) AS avg_spending 
from sales_data
group by customer_id,
	   region)

Select s.customer_id,s.region,s.customer_spending,a.avg_spending from Sumcte as S
join Avgcte as A
on s.customer_id=a.customer_id
where s.customer_spending>a.avg_spending




 --Task 17

;with customer_spending as ( 
Select customer_id,
       customer_name,
       region, 
	   SUM(total_amount) AS total_spent from sales_data
 group by  customer_id,customer_name,region,total_amount)

 Select customer_id,
        customer_name,
        region,
		total_spent,
		 dense_rank() over (partition by region order by total_spent desc) as RankRegion
		from customer_spending


--Task 18
;with Sumcte as (Select 
      customer_id,
	  customer_name,
	  total_amount,
	  sum(total_amount) over (partition by customer_id order by order_date) as RunningTotal

from sales_data)

Select customer_id,
       sum(RunningTotal) as SumRunningTotal
 from Sumcte 
 group by customer_id
	      

		 

--Task 19

;with monthlysales as (Select 
FORMAT(order_date, 'YYYY-MM') as Salemonth,
sum(total_amount) AS total_sales 
from sales_data
group by FORMAT(order_date, 'YYYY-MM'))
 

 Select 
 Salemonth,
 total_sales,
       lag(total_sales) over (order by Salemonth ) as PrevMonth,
	  ( (total_sales-lag(total_sales) over (order by Salemonth ))/ lag(total_sales) over (order by Salemonth)) as GrowthRate
 

 from monthlysales
 order by  Salemonth


 --Task 20
;with cte as (Select  customer_id,total_amount,
	     lag(total_amount) over(partition by customer_id order by order_date) as LastOrder  from sales_data
 group by  total_amount,customer_id,order_date)
 
 Select customer_id,total_amount from cte
 where total_amount>LastOrder


 --Task 21

--;with Avgcte as (Select product_category,unit_price,
--        avg(unit_price) over (partition by product_category) as AvgPrice 
		
--from sales_data) 

--Select product_category,unit_price,AvgPrice from  Avgcte
--where unit_price>AvgPrice


SELECT 
    product_name,
    unit_price
FROM 
    sales_data
WHERE 
    unit_price > (
        SELECT AVG(unit_price) FROM sales_data
    );


--Task 22

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);
 
 select * from Mydata;

 Select 
      sum(Val1+Val2) over (partition by Grp) as total_sum  ,
	  ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) as rownumber,
	  CASE WHEN row_number = 1 THEN total_sum ELSE NULL END AS Tot


 
 
 from MyData

 SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL 
    END AS Tot
FROM 
    MyData;


 --Task 23
CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

Select ID,SUM(COST) as Cost,SUM(DISTINCT Quantity) as Quantity from  TheSumPuzzle
group by ID


 --Task 23
CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 

with cte as (
    select 1 as nb 
    union all
    select nb + 1 from cte
    where cte.nb < 54),
cte2 as (
select *,
        isnull(max(SeatNumber) over(order by cte.nb),0) as sth from cte
full join Seats as S 
on S.SeatNumber = cte.nb)
select min(cte2.nb) as GapStart,max(cte2.nb) as GapEnd from cte2
where cte2.nb <> cte2.sth
group by cte2.sth

--TAsk 24
with AllSeats as (
    select top (54) row_number() over (order by (select null)) as SeatNumber
    from master.dbo.spt_values
),
MissingSeats AS (
    select SeatNumber
    from AllSeats
    WHERE SeatNumber NOT IN (SELECT SeatNumber FROM Seats)
),
Grouped AS (
    SELECT 
        SeatNumber,
        SeatNumber - ROW_NUMBER() OVER (ORDER BY SeatNumber) AS grp
    FROM MissingSeats
)
SELECT 
    MIN(SeatNumber) AS StartSeat,
    MAX(SeatNumber) AS EndSeat
FROM Grouped
GROUP BY grp
ORDER BY StartSeat;








--Task 25
;with cte as (Select 
                   id,
				   Vals,
				   row_number() over(  partition by id order by Vals) as row_num_in_group ,
                   2 * DENSE_RANK() OVER (ORDER BY Id)  AS start_even_number
from Row_Nums)

Select id,
      Vals,
      (start_even_number + row_num_in_group -1 ) AS Changed from cte
order by id,Vals





