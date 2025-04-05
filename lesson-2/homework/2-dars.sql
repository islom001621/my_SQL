create database lesson_2_homework
use lesson_2_homework
 
 create table employees(
 empid int primary key,
 name varchar(50),
 salary decimal(10,2)
 )

 select * from employees;

 insert into employees (empid,Name,salary)
values (10,'john',1000),
       (20,'jack',2000),
	   (30,'jerry',3000);


update employees set salary=4000 where empid=1;

delete from employees where empid=2;

alter table employees 
alter column name varchar(100);

alter table employees add department varchar (50);


select * from employees;   

alter table employees
alter column salary float;


create table Departs(
departid int primary key,
departname varchar(50)
)

select * from Departs;

truncate table employees;

insert into Departs (departid,departname)
select top 5 empid,Name
from employees;

update employees set department ='manegement'where salary>1300

select * from employees; 

alter table employees
drop column department;

exec sp_rename 'employees','staffmembers1';

select * from staffmembers

Drop table Departs;

create table products(
  ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
)
select * from products;

alter table products
add constraint check_price check(Price>0)

alter table products
add StockQuantity int default 50

exec sp_rename 'products.Category','Productcategory','column'

select * from products;

INSERT INTO Products (ProductID, ProductName, Productcategory, Price, StockQuantity)
VALUES (1, 'Laptop', 'Electronics', 1200.00, 30);

INSERT INTO Products (ProductID, ProductName, Productcategory, Price, StockQuantity)
VALUES (2, 'Smartphone', 'Electronics', 800.00, 50);

INSERT INTO Products (ProductID, ProductName, Productcategory, Price, StockQuantity)
VALUES (3, 'Chair', 'Furniture', 150.00, 100);

INSERT INTO Products (ProductID, ProductName, Productcategory, Price, StockQuantity)
VALUES (4, 'Notebook', 'Stationery', 2.50, 500);

INSERT INTO Products (ProductID, ProductName, Productcategory, Price, StockQuantity)
VALUES (5, 'Water Bottle', 'Accessories', 10.00, 200);

select * from products;

select * into products_backup
from products

exec sp_rename 'products','inventory';
select * from inventory;

alter table inventory add constraint  check_price  check (price>0)

alter table inventory
alter column price float;

alter table inventory add constraint check_price 

INSERT INTO inventory (ProductID, ProductName, Productcategory, Price, StockQuantity)
VALUES (23332, 'Water Bottle', 'Accessories', 25, 100);

select * from inventory;

alter table inventory add productcode int identity(1000,5);

select * from inventory;




