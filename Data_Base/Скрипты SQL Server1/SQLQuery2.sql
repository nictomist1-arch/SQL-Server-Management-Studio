SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

USE master;
GO

IF DB_ID(N'TestIndex') IS NULL
	CREATE DATABASE TestIndex;
GO

USE TestIndex;
GO

IF OBJECT_ID(N'dbo.orders2', 'U') IS NOT NULL
	DROP TABLE dbo.orders2;
GO

CREATE TABLE orders2 (
	id UNIQUEIDENTIFIER NOT NULL,
	product_id UNIQUEIDENTIFIER NOT NULL,
	customer_id UNIQUEIDENTIFIER NOT NULL,
	price MONEY NOT NULL
);
GO

DECLARE @search_id UNIQUEIDENTIFIER = NEWID();

INSERT INTO orders2 (id, product_id, customer_id, price)
VALUES
	(@search_id, NEWID(), NEWID(), 10.50),
	(NEWID(), NEWID(), NEWID(), 25.00),
	(NEWID(), NEWID(), NEWID(), 99.99);
GO

CREATE CLUSTERED INDEX cl_index
	ON orders2(id);
GO

-- Point lookup by id (clustered index seek)
DECLARE @search_id UNIQUEIDENTIFIER =
(
	SELECT TOP (1) id FROM orders2 ORDER BY price
);

SELECT *
FROM orders2
WHERE id = @search_id;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
