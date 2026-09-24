USE master
go

CREATE DATABASE Data_Base_8
ON PRIMARY
(
	NAME = Data_Base_8,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Data_Base_8.mdf'
),
FILEGROUP FG_DATA
(
	NAME = Data_Base_8_Data,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Data_Base_8_Data.ndf'
),
FILEGROUP FG_INDEX
(
	NAME = Data_Base_8_Index,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Data_Base_8_Index.ndf'
)
LOG ON
(
	NAME = Data_Base_8_log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Data_Base_8_log.ldf'
)
go

ALTER DATABASE Data_Base_8 MODIFY FILEGROUP FG_DATA DEFAULT
go

use Data_Base_8
go

CREATE TABLE warehouses(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	address varchar(255),
	city varchar(100),
	country varchar(100),
	phone varchar(30),
	capacity int,
	is_active bit
) ON FG_DATA
go

CREATE TABLE suppliers(
	id int Primary Key IDENTITY(1,1),
	name varchar(150),
	contact_person varchar(100),
	phone varchar(30),
	email varchar(100),
	country varchar(100),
	rating decimal(3,1),
	warehouse_id int FOREIGN KEY REFERENCES warehouses(id)
) ON FG_DATA
go

CREATE TABLE categories(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	description varchar(255),
	code varchar(20),
	sort_order int,
	is_active bit,
	created_at datetime,
	supplier_id int FOREIGN KEY REFERENCES suppliers(id)
) ON FG_DATA
go

CREATE TABLE brands(
	id int Primary Key IDENTITY(1,1),
	name varchar(100),
	country varchar(100),
	website varchar(255),
	founded_year int,
	description varchar(255),
	is_active bit,
	category_id int FOREIGN KEY REFERENCES categories(id)
) ON FG_INDEX
go

CREATE TABLE products(
	id int Primary Key IDENTITY(1,1),
	name varchar(150),
	product_number varchar(40),
	standart_cost money,
	list_price money,
	quantity int,
	color varchar(40),
	brand_id int FOREIGN KEY REFERENCES brands(id),
	category_id int FOREIGN KEY REFERENCES categories(id),
	supplier_id int FOREIGN KEY REFERENCES suppliers(id),
	warehouse_id int FOREIGN KEY REFERENCES warehouses(id)
) ON FG_INDEX
go

CREATE TABLE customers(
	id int Primary Key IDENTITY(1,1),
	full_name varchar(150),
	email varchar(100),
	phone varchar(30),
	city varchar(100),
	country varchar(100),
	is_active bit,
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

INSERT warehouses (name, address, city, country, phone, capacity, is_active)
VALUES
('Central Warehouse', 'Main Street 10', 'Amsterdam', 'Netherlands', '+31 20 111 2233', 5000, 1),
('North Warehouse', 'Harbor Road 25', 'Rotterdam', 'Netherlands', '+31 10 222 3344', 3500, 1),
('South Warehouse', 'Industrial Street 5', 'Eindhoven', 'Netherlands', '+31 40 333 4455', 2800, 1),
('East Store Depot', 'Market Ave 18', 'Utrecht', 'Netherlands', '+31 30 444 5566', 2200, 1)
go

INSERT suppliers (name, contact_person, phone, email, country, rating, warehouse_id)
VALUES
('Tech Supply', 'Jan de Vries', '+31 20 111 2233', 'info@techsupply.nl', 'Netherlands', 9.2, 1),
('Global Electronics', 'Emma Bakker', '+31 10 222 3344', 'sales@globalelec.nl', 'Netherlands', 8.7, 2),
('Digital World', 'Lars Jansen', '+31 40 333 4455', 'contact@digitalworld.nl', 'Netherlands', 8.9, 3),
('Home Retail Co', 'Sophie Meijer', '+31 30 444 5566', 'orders@homeretail.nl', 'Netherlands', 8.5, 4)
go

INSERT categories (name, description, code, sort_order, is_active, created_at, supplier_id)
VALUES
('Smartphones', 'Mobile phones and smartphones', 'SMART', 1, 1, GETDATE(), 1),
('Laptops', 'Portable computers and laptops', 'LAPTOP', 2, 1, GETDATE(), 2),
('Accessories', 'Computer and phone accessories', 'ACC', 3, 1, GETDATE(), 3),
('Audio', 'Headphones speakers and earbuds', 'AUDIO', 4, 1, GETDATE(), 3),
('TV and Monitors', 'Televisions and computer monitors', 'TV', 5, 1, GETDATE(), 4)
go

INSERT brands (name, country, website, founded_year, description, is_active, category_id)
VALUES
('Samsung', 'South Korea', 'https://www.samsung.com', 1938, 'Electronics manufacturer', 1, 1),
('Apple', 'USA', 'https://www.apple.com', 1976, 'Consumer electronics', 1, 1),
('Xiaomi', 'China', 'https://www.mi.com', 2010, 'Smartphones and gadgets', 1, 1),
('Lenovo', 'China', 'https://www.lenovo.com', 1984, 'PC and laptop brand', 1, 2),
('ASUS', 'Taiwan', 'https://www.asus.com', 1989, 'Computer hardware brand', 1, 2),
('HP', 'USA', 'https://www.hp.com', 1939, 'Laptops and printers', 1, 2),
('Logitech', 'Switzerland', 'https://www.logitech.com', 1981, 'Computer peripherals', 1, 3),
('Anker', 'China', 'https://www.anker.com', 2011, 'Charging accessories', 1, 3),
('Sony', 'Japan', 'https://www.sony.com', 1946, 'Audio and electronics', 1, 4),
('JBL', 'USA', 'https://www.jbl.com', 1946, 'Speakers and headphones', 1, 4),
('LG', 'South Korea', 'https://www.lg.com', 1958, 'TV and home electronics', 1, 5)
go

INSERT products (name, product_number, standart_cost, list_price, quantity, color, brand_id, category_id, supplier_id, warehouse_id)
VALUES
('Samsung Galaxy S25', 'SMS-S25', 650.00, 899.99, 25, 'Black', 1, 1, 1, 1),
('iPhone 16', 'APL-IP16', 720.00, 999.99, 15, 'White', 2, 1, 1, 1),
('Xiaomi Redmi Note 13', 'XIA-RN13', 180.00, 249.99, 40, 'Blue', 3, 1, 1, 1),
('Lenovo IdeaPad 5', 'LNV-IP5', 520.00, 749.99, 20, 'Grey', 4, 2, 2, 2),
('ASUS VivoBook 15', 'ASU-VB15', 480.00, 699.99, 18, 'Silver', 5, 2, 2, 2),
('HP Pavilion 15', 'HP-PAV15', 500.00, 729.99, 12, 'Black', 6, 2, 2, 2),
('Logitech MX Master 3S', 'LOG-MX3S', 55.00, 99.99, 40, 'Graphite', 7, 3, 3, 3),
('Anker USB-C Charger 65W', 'ANK-UC65', 18.00, 39.99, 60, 'White', 8, 3, 3, 3),
('Logitech K380 Keyboard', 'LOG-K380', 22.00, 39.99, 35, 'Pink', 7, 3, 3, 3),
('Sony WH-1000XM5', 'SNY-XM5', 280.00, 399.99, 22, 'Black', 9, 4, 3, 3),
('JBL Flip 6', 'JBL-FL6', 70.00, 129.99, 30, 'Blue', 10, 4, 3, 3),
('Sony WF-1000XM4', 'SNY-WF4', 150.00, 229.99, 28, 'Black', 9, 4, 3, 4),
('LG OLED 55 C3', 'LG-C355', 900.00, 1299.99, 8, 'Black', 11, 5, 4, 4),
('Samsung Odyssey G5 27', 'SMS-G527', 220.00, 329.99, 14, 'Black', 1, 5, 4, 4),
('Apple AirPods Pro 2', 'APL-APP2', 180.00, 249.99, 45, 'White', 2, 4, 1, 1)
go

INSERT customers (full_name, email, phone, city, country, is_active, warehouse_id)
VALUES
('Anna Smirnova', 'anna.smirnova@mail.com', '+7 921 111 2233', 'Saint Petersburg', 'Russia', 1, 1),
('Mark Johnson', 'mark.johnson@mail.com', '+1 415 222 3344', 'San Francisco', 'USA', 1, 2),
('Emma Bakker', 'emma.bakker@mail.com', '+31 6 333 4455', 'Amsterdam', 'Netherlands', 1, 1),
('Ivan Petrov', 'ivan.petrov@mail.com', '+7 903 444 5566', 'Moscow', 'Russia', 1, 3),
('Sophie Meijer', 'sophie.meijer@mail.com', '+31 6 555 6677', 'Rotterdam', 'Netherlands', 1, 2),
('John Smith', 'john.smith@mail.com', '+1 212 666 7788', 'New York', 'USA', 1, 4),
('Maria Garcia', 'maria.garcia@mail.com', '+34 612 777 8899', 'Madrid', 'Spain', 1, 3),
('Lars Jansen', 'lars.jansen@mail.com', '+31 6 888 9900', 'Utrecht', 'Netherlands', 1, 4)
go

INSERT orders (order_number, order_qty, unit_price, line_total, order_date, status, customer_id, product_id)
VALUES
('ORD-1001', 1, 899.99, 899.99, GETDATE(), 'Completed', 1, 1),
('ORD-1002', 1, 749.99, 749.99, GETDATE(), 'Completed', 2, 4),
('ORD-1003', 2, 99.99, 199.98, GETDATE(), 'Pending', 3, 7),
('ORD-1004', 1, 39.99, 39.99, GETDATE(), 'Completed', 1, 8),
('ORD-1005', 1, 999.99, 999.99, GETDATE(), 'Completed', 4, 2),
('ORD-1006', 1, 399.99, 399.99, GETDATE(), 'Shipped', 5, 10),
('ORD-1007', 2, 129.99, 259.98, GETDATE(), 'Completed', 6, 11),
('ORD-1008', 1, 1299.99, 1299.99, GETDATE(), 'Pending', 7, 13),
('ORD-1009', 1, 249.99, 249.99, GETDATE(), 'Completed', 8, 3),
('ORD-1010', 3, 39.99, 119.97, GETDATE(), 'Completed', 3, 9),
('ORD-1011', 1, 329.99, 329.99, GETDATE(), 'Shipped', 2, 14),
('ORD-1012', 1, 249.99, 249.99, GETDATE(), 'Completed', 6, 15)
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

EXECUTE @Result = dbo.uspSale9 @Discount = 15, @RoundCost = 150

SELECT @Result AS Result
go

SELECT * FROM warehouses
go
SELECT * FROM suppliers
go
SELECT * FROM categories
go
SELECT * FROM brands
go
SELECT * FROM products
go
SELECT * FROM customers
go
SELECT * FROM orders
go
