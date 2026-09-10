DECLARE @DT datetime = GetDate()
DECLARE @DT2 datetime2 = SysDateTime()

SELECT Cast(@DT2 AS varchar),
	Try_Convert(varchar(max), @DT2, 4),
	Parse(@DT2 AS varchar(100))