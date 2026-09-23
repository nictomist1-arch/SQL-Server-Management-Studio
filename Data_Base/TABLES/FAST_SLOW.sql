USE Fast_Slow
go

CREATE TABLE users
(id int, name text)
ON BAD

CREATE TABLE products
(id int, name text)
ON GOOD
go

While 1 = 1
INSERT INTO users(id)
VALUES (DatePart(MINUTE, GETDATE()))
go 100

INSERT INTO users(id)
VALUES (DatePart(MINUTE, GETDATE()))
go 1000