use homeworks

--homework 3

create table Products ( 
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50), 
Price DECIMAL(10,2))

INSERT INTO Products (ProductID,ProductName,Price)
VALUES
  (1, 'Banana', 2.5000),
  (2, 'Snacks', 1.203648),
  (3, 'apple', 3.75012);

  select * from Products

  Drop table Products


ALTER TABLE Products
ADD CONSTRAINT unique_product_name UNIQUE (ProductName);

create table Categories(
categoryId int primary key,
categoryname varchar (100) unique)

 INSERT INTO Categories(categoryId,categoryname)
VALUES
  (1, 'Banana'),
  (2, 'Snacks'),
  (3, 'apple');

select * from Categories

Drop table Categories

create table Customers (
customer_id int,
cust_name varchar(50),
city varchar(50),
grade int,
salesman_id int)

select * from Customers

bulk insert [dbo].[Customers]
from 'C:\Users\LENOVO\Desktop\Customers.csv'
with (
firstrow =2,
rowterminator = '\n',
fieldterminator =','
)
alter table Products 
add categoryId int;

select * from Products

alter table Products
add constraint Products_FK

foreign key (categoryId) references Categories(categoryId)


ALTER TABLE Products ADD CONSTRAINT check_price CHECK (price > 0);

alter table Products add stock int not null default 0

select * from Products

select isnull(categoryid,3) from Products;


CREATE TABLE custs (
    CustID INT PRIMARY KEY,
    LastName VARCHAR(100) not null,
    Age INT not null,
    Email VARCHAR(100),
    CHECK (Age >= 18))

	select * from custs

	create table Orders (
    OrderID int identity(100, 10) primary key,
    CustomerName varchar(100)
)

insert into Orders (CustomerName) values ('Ali'),('Vali'),('Nurali');

select * from Orders

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT NumberoneOrderDetails PRIMARY KEY (OrderID, ProductID)
);

drop table OrderDetails


CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE
)

select * from Employees

CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(100)
)

CREATE TABLE Orders2 (
    Orderid INT PRIMARY KEY,
    CusteID INT,
    CONSTRAINT FK_Customer_Order
        FOREIGN KEY (CusteID)
        REFERENCES Customer(CustID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

select * from Orders2

