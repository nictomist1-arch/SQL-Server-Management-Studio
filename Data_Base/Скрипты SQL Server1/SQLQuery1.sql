CREATE COLUMNSTORE INDEX ind
	ON orders2(price)
	WHERE price < 10000
	AND price < 1000