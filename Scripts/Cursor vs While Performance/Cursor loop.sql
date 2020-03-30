declare @datetime datetime
declare @junk int 
set @datetime = GETDATE()

declare @PK varchar(20)

declare TEST cursor
    for select charcol from NUMBERS

open TEST

fetch next from TEST into @PK

while (@@FETCH_STATUS = 0)
begin
	select @junk=@PK

	fetch next from TEST into @PK
end

close TEST

deallocate TEST

select DATEDIFF(ms, @datetime, GETDATE())
go
