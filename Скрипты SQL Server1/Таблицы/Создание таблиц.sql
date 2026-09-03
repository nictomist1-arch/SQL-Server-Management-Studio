 USE DB1
 
 CREATE TABLE users3(
	id int Primary Key Identity(1, 1),
	first_name nvarchar(100) not null,
	email varchar(100) unique,
	age tinyint,
	balance real not null
 )
