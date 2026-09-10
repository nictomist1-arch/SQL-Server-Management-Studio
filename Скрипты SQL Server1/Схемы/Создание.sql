USE DB2
GO

--CREATE SCHEMA departament
--GO
--CREATE SCHEMA customers
--GO
--CREATE TABLE clients.person(id int, name varchar(100))

IF OBJECT_ID(N'clients.person', N'U') IS NOT NULL
	ALTER SCHEMA customers TRANSFER clients.person
GO
