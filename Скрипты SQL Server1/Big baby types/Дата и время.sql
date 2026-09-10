DECLARE @DT datetime = GetDate()
DECLARE @D date = '2000-08-31'
DECLARE @T time = GetDate()
DECLARE @DT2 datetime2 = SysDateTime()
DECLARE @DTO datetimeoffset = GetDate()

SET DATEFORMAT myd;
PRINT @DTO
