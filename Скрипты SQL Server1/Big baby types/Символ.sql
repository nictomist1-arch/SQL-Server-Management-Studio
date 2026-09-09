DECLARE @char char(5) = 'dddddddd'
DECLARE @char2 nchar(10) = 'текст на русском'
DECLARE @vchar varchar(5000) = 'dadasaasda'

--DECLARE @text text = 'sdsdasfasdvzcxzas'

SELECT *
FROM sys.databases
PRINT @vchar
