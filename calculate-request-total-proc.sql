use PRSDb;
go
CREATE or ALTER procedure CalculateRequestTotal
	@RequestId int = null
AS
BEGIN
	IF @RequestId is null
	BEGIN
		PRINT 'RequestId is Required';
		RETURN -1;
	END
	IF NOT Exists(Select 1 from Requests where ID = @RequestId)
	BEGIN
		PRINT 'Request not found';
		return -2;
	end
	DECLARE @Total decimal(9,2);
	SELECT @Total = sum(rl.quantity * p.price)
		from requests r
		join Requestlines rl on rl.RequestId = r.Id
		join Products p on p.id = rl.ProductId
		where r.ID = @requestId;
	Select @total 'Total';
	UPDATE Requests set
		total = @Total
		where ID = @RequestId;
	PRINT 'Updated Successfully! Return code is 0';
	RETURN 0;

END
go

EXEC CalculateRequestTotal 1;
go