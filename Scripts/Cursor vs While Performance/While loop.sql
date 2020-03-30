declare @datetime datetime
declare @junk int
set @datetime = GETDATE()

declare @counter int = (select min(PK) from Numbers)
declare @MaxCounter int = (select max(PK) from Numbers)

while (@counter <= @MaxCounter)
begin
	select @junk=PK from Numbers where pk = @counter

	select @counter = @counter + 1
end

select DATEDIFF(ms, @datetime, GETDATE())
go
