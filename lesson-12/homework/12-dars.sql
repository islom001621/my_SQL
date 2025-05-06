
create database Lesson_12_homework

use Lesson_12_homework;


--Task 1

Create table Person (personId int, firstName varchar(255), lastName varchar(255))

insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')

select * from Person;


Create table Address (addressId int, personId int, city varchar(255), state varchar(255))

insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

select * from Person
select * from Address;



select 
    p.firstName, 
    p.lastName, 
    a.city, 
    a.state
from Person p
left join Address a on  p.personId = a.personId;


--task 2

Create table Employee (id int, name varchar(255), salary int, managerId int)

insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

select * from Employee;

select  e.name as Employee
from  Employee e
join  Employee m on e.managerId = m.id
where e.salary > m.salary;


--task 3


create table Person1 (id int, email varchar(255));

insert into Person1 (id, email) values(1, 'a@b.com');
insert into Person1 (id, email) values (2, 'c@d.com');
insert into Person1 (id, email) values(3, 'a@b.com');

select * from Person1;


select email
from Person1 group by email
having count(*) > 1;


--task 4

select * from Person1;

delete from Person1
where id not in (
    select min(id)
    from Person1
    group by email);

-- task 5

CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  

select * from boys;

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

select * from girls;


select distinct b.ParentName
from boys b
join girls g
on b.ParentName = g.ParentName;


--task 6


SELECT 
    CustomerID,
    SUM(SalesAmount) AS TotalSalesAmount_WeightGT50,
    MIN(Weight) AS LeastOrderWeight
FROM 
    Sales.Orders
WHERE 
    Weight > 50
GROUP BY 
    CustomerID;


-- task 7


CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');

select * from Cart1;


CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');


select * from Cart1;
select * from Cart2;


select 
    c1.Item as [Item Cart 1],
    c2.Item as [Item Cart 2]
from Cart1 c1
full outer join Cart2 c2 on c1.Item = c2.Item;


--task 8 

Create table Customers (id int, name varchar(255))

insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')

select * from Customers;


Create table Orders (id int, customerId int)

insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

select * from Orders;



select c.id, c.name
from Customers c
left join Orders o  on c.id = o.customerId
where o.id is null;


--task 9

Create table Students (student_id int, student_name varchar(20))

insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')

select * from Students;


Create table Subjects (subject_name varchar(20))

insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')

select * from Subjects;


Create table Examinations (student_id int, subject_name varchar(20))

insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')

select * from Examinations;



select student_id, subject_name, count(*) as exam_count
from  Examinations
group by student_id, subject_name
order by student_id, subject_name;


