USE DB4
GO

------------------------------------------------------------
-- 1. Создать 2 схемы: Persons, Products
------------------------------------------------------------
CREATE SCHEMA Persons
GO

CREATE SCHEMA Products
GO

------------------------------------------------------------
-- 2. В схеме Persons создать 2 таблицы с id NULL и +4 поля
------------------------------------------------------------
CREATE TABLE Persons.clients(
	id int NULL,
	first_name nvarchar(50) NULL,
	last_name nvarchar(50) NULL,
	email varchar(100) NULL,
	phone varchar(20) NULL
)
GO

CREATE TABLE Persons.employees(
	id int NULL,
	full_name nvarchar(100) NULL,
	position nvarchar(50) NULL,
	salary money NULL,
	hire_date date NULL
)
GO

------------------------------------------------------------
-- 3. Исправить id NULL на id PRIMARY KEY IDENTITY
--    (в SQL Server IDENTITY нельзя просто ALTER COLUMN —
--     удаляем старый id и добавляем новый)
------------------------------------------------------------
ALTER TABLE Persons.clients
	DROP COLUMN id
GO

ALTER TABLE Persons.clients
	ADD id int IDENTITY(1, 1) NOT NULL PRIMARY KEY
GO

ALTER TABLE Persons.employees
	DROP COLUMN id
GO

ALTER TABLE Persons.employees
	ADD id int IDENTITY(1, 1) NOT NULL PRIMARY KEY
GO

------------------------------------------------------------
-- 4. В схеме Products создать 2 таблицы
--    с id PRIMARY KEY IDENTITY и +2 поля
------------------------------------------------------------
CREATE TABLE Products.goods(
	id int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	title nvarchar(100) NOT NULL,
	price money NOT NULL
)
GO

CREATE TABLE Products.categories(
	id int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	title nvarchar(50) NOT NULL,
	description nvarchar(200) NULL
)
GO

-- Тестовые данные, чтобы при переносе было что переносить
INSERT INTO Products.goods(title, price)
VALUES (N'Ноутбук', 75000),
	   (N'Мышь', 1500)
GO

INSERT INTO Products.categories(title, description)
VALUES (N'Электроника', N'Техника и гаджеты'),
	   (N'Аксессуары', N'Периферия и доп. товары')
GO

------------------------------------------------------------
-- 5. Перенести таблицы из Products в Persons со всеми данными
------------------------------------------------------------
ALTER SCHEMA Persons TRANSFER Products.goods
GO

ALTER SCHEMA Persons TRANSFER Products.categories
GO
