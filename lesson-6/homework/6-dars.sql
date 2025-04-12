use homeworks;

-- lesson 6 homework


-- puzzle 1

CREATE TABLE InputTbl ( col1 VARCHAR(10), col2 VARCHAR(10) ); 

INSERT INTO InputTbl (col1, col2) 
VALUES ('a', 'b'), ('a', 'b'), ('b', 'a'), ('c', 'd'), ('c', 'd'), ('m', 'n'), ('n', 'm');

select * from InputTbl;


SELECT DISTINCT col1, col2
FROM  InputTbl;


--puzzle 2 

CREATE TABLE TestMultipleZero ( A INT NULL, B INT NULL, C INT NULL, D INT NULL );


INSERT INTO TestMultipleZero(A,B,C,D) VALUES (0,0,0,1), (0,0,1,0), (0,1,0,0), (1,0,0,0), (0,0,0,0), (1,1,1,0);

select * from TestMultipleZero;

SELECT *
FROM TestMultipleZero
WHERE not (A = 0 AND B = 0 AND C = 0 AND D = 0);


-- puzzle 3

create table section1(id int, name varchar(20));


insert into section1 values (1, 'Been'), (2, 'Roma'), (3, 'Steven'), (4, 'Paulo'), (5, 'Genryh'), (6, 'Bruno'), (7, 'Fred'), (8, 'Andro')


select * from section1;

select * from section1
where id % 2=1;


-- task 4

SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

-- task 5

SELECT *
FROM section1
WHERE id = (SELECT Max(id) FROM section1);

-- task 6

SELECT * 
FROM section1 
WHERE name LIKE 'B%';

-- task 7

CREATE TABLE ProductCodes ( Code VARCHAR(20) );

INSERT INTO ProductCodes (Code) VALUES ('X-123'), ('X_456'), ('X#789'), ('X-001'), ('X%202'), ('X_ABC'), ('X#DEF'), ('X-999');

select * from ProductCodes;


select * from ProductCodes
where Code like '%/_%' escape '/'




