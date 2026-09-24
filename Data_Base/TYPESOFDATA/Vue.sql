USE DB1
go

CREATE PROCEDURE uspSale9
	@Discount decimal = 1000,
	@Top_level int = 10,
	@RoundCost int
AS
BEGIN
	SELECT TOP (@Top_level) standert_cost * @Discount AS with_discount, standert_cost
	FROM product
	WHERE standert_cost > @RoundCost
RETURN @Top_level
END

DECLARE @Result INT;

EXECUTE @Result = dbo.uspSale9 @Discount = 15, @RoundCost = 1500
