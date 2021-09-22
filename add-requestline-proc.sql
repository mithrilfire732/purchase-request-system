CREAtE or ALTER procedure AddRequestline
	@RequestID int = null,
	@ProductName varchar(30) = null,
	@Quantity int = null
AS BEGIN
	if @RequestID is null OR @ProductName is null OR @Quantity is null
		begin
			PRINT 'All fields are required';
			RETURN -1
		end
	if not exists(select 1 from Requests where ID = @RequestID) begin
		PRINT 'Request not found';
		RETURN -2;
	end
	if not exists(select 1 from products where Name = @ProductName) begin
	Print 'Product not found';
	RETURN -3;
	end
	if @Quantity < 1 BEGIN
		 Print 'Quantity must be GTE zero';
		 RETURN -4;
		 END
	DECLARE @ProductId int;
	SELECT @ProductId = ID from products where name = @ProductName;
	INSERT REQUESTLINES (RequestId,ProductId,Quantity)
		values (@RequestID,@ProductId,@Quantity);
	PRINT 'Insert successful!';
	RETURN 0;
END

exec AddRequestline @requestID = 1, @ProductName = 'Milk', @Quantity = 4