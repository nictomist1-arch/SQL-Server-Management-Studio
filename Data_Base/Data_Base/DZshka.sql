use Data_Base_8
go

CREATE TABLE warehouses(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	cost_rate smallmoney,
	availability decimal(8,2),
	city varchar(100),
	country varchar(100),
	phone varchar(30),
	is_active bit
) ON FG_DATA
go

CREATE TABLE suppliers(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	account_number varchar(40),
	credit_rating tinyint,
	preferred_status bit,
	active_flag bit,
	website varchar(255),
	warehouse_id int FOREIGN KEY REFERENCES warehouses(id)
) ON FG_DATA
go

CREATE TABLE categories(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	code varchar(40),
	description varchar(255),
	sort_order int,
	is_active bit,
	created_at datetime,
	supplier_id int FOREIGN KEY REFERENCES suppliers(id)
) ON FG_DATA
go

CREATE TABLE brands(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	catalog_description varchar(255),
	instructions varchar(255),
	rowguid uniqueidentifier,
	modified_date datetime,
	is_active bit,
	category_id int FOREIGN KEY REFERENCES categories(id)
) ON FG_INDEX
go

CREATE TABLE products(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	product_number varchar(40),
	standart_cost money,
	list_price money,
	color varchar(40),
	safety_stock int,
	brand_id int FOREIGN KEY REFERENCES brands(id),
	category_id int FOREIGN KEY REFERENCES categories(id),
	supplier_id int FOREIGN KEY REFERENCES suppliers(id),
	warehouse_id int FOREIGN KEY REFERENCES warehouses(id)
) ON FG_INDEX
go

CREATE TABLE customers(
	id int Primary Key IDENTITY(1,1),
	account_number varchar(40),
	first_name varchar(100),
	last_name varchar(100),
	email varchar(100),
	city varchar(100),
	country varchar(100),
	warehouse_id int FOREIGN KEY REFERENCES warehouses(id)
) ON FG_DATA
go

CREATE TABLE orders(
	id int Primary Key IDENTITY(1,1),
	order_number varchar(40),
	order_qty int,
	unit_price money,
	line_total money,
	order_date datetime,
	status varchar(20),
	customer_id int FOREIGN KEY REFERENCES customers(id),
	product_id int FOREIGN KEY REFERENCES products(id)
) ON FG_INDEX
go

INSERT warehouses (name, cost_rate, availability, city, country, phone, is_active)
SELECT
	Name,
	CostRate,
	Availability,
	'Simpheropl',
	'Russia',
	'+7 978 827 70 12',
	1
FROM AdventureWorks2019.Production.Location
go

INSERT suppliers (name, account_number, credit_rating, preferred_status, active_flag, website, warehouse_id)
SELECT TOP 100
	Name,
	AccountNumber,
	CreditRating,
	PreferredVendorStatus,
	ActiveFlag,
	PurchasingWebServiceURL,
	1
FROM AdventureWorks2019.Purchasing.Vendor
go

INSERT categories (name, code, description, sort_order, is_active, created_at, supplier_id)
SELECT
	Name,
	'CAT' + CAST(ProductCategoryID AS varchar(10)),
	Name,
	ProductCategoryID,
	1,
	ModifiedDate,
	1
FROM AdventureWorks2019.Production.ProductCategory
go

INSERT brands (name, catalog_description, instructions, rowguid, modified_date, is_active, category_id)
SELECT TOP 100
	Name,
	Name,
	Name,
	rowguid,
	ModifiedDate,
	1,
	1
FROM AdventureWorks2019.Production.ProductModel
go

INSERT products (name, product_number, standart_cost, list_price, color, safety_stock, brand_id, category_id, supplier_id, warehouse_id)
SELECT TOP 200
	Name,
	ProductNumber,
	StandardCost,
	ListPrice,
	Color,
	SafetyStockLevel,
	1,
	1,
	1,
	1
FROM AdventureWorks2019.Production.Product
WHERE ListPrice > 0
go

INSERT customers (account_number, first_name, last_name, email, city, country, warehouse_id)
SELECT TOP 100
	c.AccountNumber,
	p.FirstName,
	p.LastName,
	e.EmailAddress,
	'Seattle',
	'USA',
	1
FROM AdventureWorks2019.Sales.Customer c
INNER JOIN AdventureWorks2019.Person.Person p
	ON c.PersonID = p.BusinessEntityID
INNER JOIN AdventureWorks2019.Person.EmailAddress e
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE c.PersonID IS NOT NULL
go

INSERT orders (order_number, order_qty, unit_price, line_total, order_date, status, customer_id, product_id)
SELECT TOP 100
	CAST(sod.SalesOrderID AS varchar(40)),
	sod.OrderQty,
	sod.UnitPrice,
	sod.LineTotal,
	soh.OrderDate,
	'Completed',
	1,
	1
FROM AdventureWorks2019.Sales.SalesOrderDetail sod
INNER JOIN AdventureWorks2019.Sales.SalesOrderHeader soh
	ON sod.SalesOrderID = soh.SalesOrderID
go

CREATE PROCEDURE uspSale9
	@Discount decimal = 1000,
	@Top_level int = 10,
	@RoundCost int
AS
BEGIN
	SELECT TOP (@Top_level) standart_cost * @Discount AS with_discount, standart_cost
	FROM products
	WHERE standart_cost > @RoundCost
	RETURN @Top_level
END
go

DECLARE @Result INT

EXECUTE @Result = dbo.uspSale9 @Discount = 15, @RoundCost = 1500

SELECT @Result AS Result
go

SELECT *
FROM warehouses
go
SELECT *
FROM suppliers
go
SELECT *
FROM categories
go
SELECT * 
FROM brands
go
SELECT * 
FROM products
go
SELECT *
FROM customers
go
SELECT
* FROM orders
go
