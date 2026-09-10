USE DB3
GO

IF OBJECT_ID(N'dbo.users3', N'U') IS NOT NULL
	DROP TABLE dbo.users3
GO

CREATE TABLE users3(
	id int Primary Key Identity(1, 1),
	first_name nvarchar(100) not null,
	email varchar(100) unique,
	age tinyint,
	balance real not null
)
GO
