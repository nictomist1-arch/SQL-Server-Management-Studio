USE DB1
go
CREATE TABLE product1(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	product_number varchar(40),
	standart_cost money,
	list_price money
)
INSERT product1 (name, product_number, standart_cost, list_price)
SELECT Name, ProductNumber, StandardCost, ListPrice
FROM AdventureWorks2019.Production.Product

SELECT *
FROM AdventureWorks2019.Production.Product