USE DB3

INSERT INTO users3(first_name, email, age, balance)
VALUES (N'Petr', 'pedro@google.gmail', 19, 1000),
		(N'MAX', 'MAX@google.gmail', 11, 100),
		(N'Issac', 'issac@google.gmail', 5, 10),
		(N'George', 'george@google.gmail', 29, 1)

SELECT *
FROM users3
