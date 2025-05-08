
create database Lesson_15_homework

use Lesson_15_homework;

--task 1

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select * from employees;


select id, name, salary
from employees
where salary = (
    select min(salary)
    from employees);

--task 2

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products;


select * from products
where price >(select avg(price)from products);


--task 3

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

select * from departments;


CREATE TABLE employees2 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);


INSERT INTO employees2 (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);


select * from departments
select * from employees2;

select  employees2.id, employees2.name
from employees2                                                                        -------?????
join departments d on employees2.department_id = d.id
where d.department_name = 'Sales';


--task 4

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

select * from customers;


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);

select * from orders;



select c.customer_id, c.name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.customer_id is null;


--task 5

CREATE TABLE products2 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products2 (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);

select * from products2;

SELECT products2.id, products2.product_name, products2.price, products2.category_id
FROM products2
WHERE products2.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE products2.category_id = products2.category_id);

--task 6

CREATE TABLE departments2 (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments2 (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

select * from departments2;

CREATE TABLE employees3 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO employees3 (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

select * from employees3;


SELECT id, name, salary, department_id
FROM employees3
WHERE department_id = (SELECT department_id FROM (
        SELECT department_id, AVG(salary) AS avg_salary
        FROM employees3
        GROUP BY department_id
    ) AS avg_salaries
    WHERE avg_salary = (
        SELECT MAX(avg_salary)
        FROM (
            SELECT department_id, AVG(salary) AS avg_salary
            FROM employees3
            GROUP BY department_id
        ) AS inner_avg ));

--task 7

CREATE TABLE employees4 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees4 (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);

select * from employees4;

SELECT employees4.id, employees4.name, employees4.salary, employees4.department_id
FROM employees4
WHERE employees4.salary > (
    SELECT AVG(e4.salary)
    FROM employees4 e4
    WHERE e4.department_id = employees4.department_id
);


--task 8

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

select * from students;

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select * from grades;


SELECT s.student_id, s.name, g.course_id, g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);


--task 9 

CREATE TABLE products3 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products3 (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

select * from products3;


SELECT id, product_name, price, category_id
FROM (
    SELECT 
        id, 
        product_name, 
        price, 
        category_id,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
    FROM products3
) ranked_products
WHERE price_rank = 3;


--task 10

CREATE TABLE employees5 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees5 (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);

select * from employees5;


SELECT employees5.id, employees5.name, employees5.salary, employees5.department_id
FROM employees5
WHERE employees5.salary > (
    SELECT AVG(salary) FROM employees5
)
AND employees5.salary < (
    SELECT MAX(s.salary)
    FROM employees5 s
    WHERE s.department_id = employees5.department_id
);

