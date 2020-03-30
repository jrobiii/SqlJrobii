set nocount on

use tempdb
declare @junk int

drop table Numbers
go
create table NUMBERS (
	pk int not null IDENTITY primary key
	, CHARCOL char(20)
	)

declare @intcol int

set @intcol = 1

while @intcol < 800000
begin
	insert into NUMBERS (charcol)
	values (@intcol)

	select @intcol = @intcol + 1
end

