--use homeworks

--leeson 1 homework

-- Easy level

--task 1

-- Data (Ma'lumot)
--Ma’lumot – bu faktlar, raqamlar, matnlar yoki boshqa turdagi qiymatlar bo‘lib, ular biror narsa haqida ma’lumot beradi.
--Misol: Ali, 25, Toshkent, 300000 so‘m – bularning barchasi ma’lumot hisoblanadi.

-- Database (Ma’lumotlar bazasi)
--Ma’lumotlar bazasi – bu bir joyda to‘plangan va tartiblangan ma’lumotlar to‘plami bo‘lib, ularni qulay izlash, o‘zgartirish va saqlash uchun ishlatiladi.
--Misol: Talabalar ro‘yxati, ishchilar jadvali yoki internetdagi foydalanuvchilar profili ma’lumotlar bazasida saqlanishi mumkin.

-- Relational Database (Aloqaviy ma’lumotlar bazasi)
--Aloqaviy ma’lumotlar bazasi – bu jadval (table) ko‘rinishida tashkil etilgan ma’lumotlar bazasi bo‘lib, jadvallar bir-biri bilan aloqaga ega bo‘ladi.
--Misol: Talabalar jadvali va Fanlar jadvali orasida talabalar fanlarga yozilganini ko‘rsatadigan bog‘lanish bo‘lishi mumkin.

--Table (Jadval)
--Jadval – bu ma’lumotlarni saqlashning asosiy shakli bo‘lib, qatorlar (rows) va ustunlardan (columns) tashkil topadi.
--Misol: Ishchilar jadvali ID, Ism, Bo‘lim, Maosh ustunlaridan iborat bo‘lishi mumkin.

-- task 2 

--1. Data Storage and Management (Ma’lumotlarni saqlash va boshqarish)
--2. Security (Xavfsizlik)
--3. Backup and Recovery (Zaxira nusxa olish va tiklash)
--4. Transactions and ACID Compliance
--5. High Performance and Scalability

-- task 3

--1. Windows Authentication
--2. SQL Server Authentication
-- SQL Server Mixed Mode Authentication (ya’ni Windows + SQL Authentication) ni ham qo‘llab-quvvatlaydi, bu holatda
--foydalanuvchi har ikkala usuldan foydalanishi mumkin.



--Medium level

-- task 4

CREATE DATABASE SchoolDB;


-- task 5

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);


-- task 6 

--SQL (Structured Query Language)
--Bu nima? — Ma'lumotlar bazasi bilan ishlash uchun til.

--Nima uchun ishlatiladi? — Ma'lumotlarni yaratish, o‘zgartirish, o‘chirish va qidirish uchun.

--Bu nima? — Microsoft tomonidan ishlab chiqilgan ma'lumotlar bazasi menejment tizimi (DBMS).

--Nima qiladi? — SQL kodlarini bajaradi, ma’lumotlarni saqlaydi, boshqaradi va himoya qiladi.

--Xulosa: Ma'lumotlar realda aynan shu yerda saqlanadi.

--🔹 SSMS (SQL Server Management Studio)
--Bu nima? — SQL Server bilan ishlash uchun yaratilgan grafik interfeysli dastur.

--Nima uchun kerak? — Ma'lumotlar bazasi yaratish, so‘rovlar yozish, natijalarni ko‘rish va serverni boshqarish osonroq bo‘ladi.

--Misol: SSMS orqali siz SQL Server'ga ulanasiz va SQL yozasiz.


-- Hard level

-- task 7 

-- DQL (Data Query Language)
--Ma’lumotlarni so‘rash uchun ishlatiladi.


--Buyruq	Maqsad	Misol
--SELECT	Ma'lumotlarni tanlab olish	SELECT * FROM Students;
--Foydalanuvchi ma’lumotlarni ko‘radi, lekin o‘zgartirmaydi.

--2. DML (Data Manipulation Language)
--Ma’lumotlar ustida amallar bajaradi: qo‘shish, o‘chirish, o‘zgartirish.


--Buyruq	Maqsad	Misol
--INSERT	Yangi yozuv qo‘shish	INSERT INTO Students VALUES (1, 'Ali', 20);
--UPDATE	Ma’lumotni yangilash	UPDATE Students SET Age = 21 WHERE StudentID = 1;
--DELETE	Ma’lumotni o‘chirish	DELETE FROM Students WHERE StudentID = 1;
-- 3. DDL (Data Definition Language)
--Ma’lumotlar bazasi strukturasini belgilaydi (jadval, ustun, DB yaratish).


--Buyruq	Maqsad	Misol
--CREATE	Yangi obyekt yaratish	CREATE TABLE Students (ID INT, Name VARCHAR(50));
--ALTER	Jadval tuzilmasini o‘zgartirish	ALTER TABLE Students ADD Age INT;
--DROP	Obyektni o‘chirish	DROP TABLE Students;
--🔸 Bu buyruqlar natijasi odatda darhol va doimiy o‘zgaradi.

--4. DCL (Data Control Language)
--Foydalanuvchi huquqlarini boshqaradi.


--Buyruq	Maqsad	Misol
--GRANT	Huquq berish	GRANT SELECT ON Students TO user1;
--REVOKE	Huquqni olib tashlash	REVOKE SELECT ON Students FROM user1;
--5. TCL (Transaction Control Language)
--Transaction (bitim)larni boshqaradi. DML bilan ishlaganda qo‘llaniladi.


--Buyruq	Maqsad	Misol
--COMMIT	O‘zgarishlarni saqlash	COMMIT;
--ROLLBACK	O‘zgarishlarni bekor qilish	ROLLBACK;
--SAVEPOINT	Oraliq nuqta yaratish	SAVEPOINT my_save;
-- Masalan, birdaniga bir nechta UPDATE qilganda va xato bo‘lsa, ROLLBACK bilan bekor qilinadi.

-- task 8

INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'Ali', 20),
(2, 'Laylo', 22),
(3, 'Jasur', 19);


-- task 9

--Part 1: Backup the SchoolDB database
--Open SSMS and connect to your SQL Server.

--In Object Explorer, expand Databases > right-click on SchoolDB.

--Select Tasks > Back Up…

--In the Back Up Database window:

--Make sure the Database is SchoolDB.

--Backup type: Full

--Backup component: Database

--Under Destination, click Remove, then Add…

--Choose a file location (e.g., C:\Backup\SchoolDB.bak)

--Click OK to start the backup.

--You’ll get a success message once completed.

--Part 2: Restore the SchoolDB database
--In Object Explorer, right-click on Databases > choose Restore Database…

--In the Source section:

--Choose Device, then click … and add the .bak file (e.g., C:\Backup\SchoolDB.bak)

--In the Destination section, database name can be:

--SchoolDB (overwrite) or a new name like SchoolDB_Restore

--Go to Options (left panel):

--Check Overwrite the existing database (WITH REPLACE) if restoring to the same name.

--Click OK to start restoring.

--You’ll get a confirmation message when restore is done.

