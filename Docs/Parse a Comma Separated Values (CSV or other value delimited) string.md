
# Parse a Comma Separated Values (CSV or other value delimited) string

## Method One

This method is a little easier to follow, but it basically takes chunks off of the left of the string based on the position of the next delimiter.  The original string is preserved.

```sql
use tempdb;

declare @_CsvString varchar(max) = 'This|that|those|them|this|again'
declare @_Delimiter varchar(10) = '|'

declare @WordList table (WordId int identity(1, 1), Word varchar(max))
declare @WorkingString varchar(max) = @_CsvString
declare @Word varchar(max)

while (len(@WorkingString) is not null) begin 
    if (charindex(@_Delimiter, @WorkingString) < 1) begin
        set @Word = @WorkingString
        set @WorkingString = NULL
    end else begin
        set @Word = left(@WorkingString, charindex(@_Delimiter, @WorkingString) -1)
        set @WorkingString = right(@WorkingString, len(@WorkingString) - len(@Word)-1)
    end
    insert into @WordList (Word)
        select @Word
end

select * from @WordList
```

## Method Two

This method comes from ![Rob Volk at SQL Team](http://www.sqlteam.com/article/parsing-csv-values-into-multiple-rows#) (mondo cool). Here I have reformatted to suit my style and stuffed it in a Table Valued Function. I'm really starting to shine on this method as it is set based (not to mention rather clever)

```sql
if (not exists (select 1 from sys.schemas where name = 'Utility')) begin
    exec ('create schema Utility')
end
go

if (not exists (select 1 from sys.tables where name = 'Numbers' and schema_id = schema_id('Utility'))) begin
    create table Utility.Numbers(
        Number int not null
        ,constraint PK_Numbers primary key clustered(Number)
    )

    set nocount on
    declare @Counter int =  1
    while (@Counter < 8000) begin
        insert into Utility.Numbers values (@Counter)
        set @Counter +=1
    end
end
go

if object_id('dbo.ParseDelimitedString') is not null drop function dbo.ParseDelimitedString
go

create function dbo.ParseDelimitedString (
     @_String varchar(8000)
    ,@_Delimiter varchar(10) = ','
)
returns @Words table (Id int identity(1, 1), Word varchar(max))
as begin

    insert into @Words
        select
            nullif(SubString(@_Delimiter + @_String + @_Delimiter , Number , CharIndex(@_Delimiter , @_Delimiter + @_String + @_Delimiter , Number) - Number) , '') AS Word
        from Utility.Numbers
        where
            Number <= len(@_Delimiter + @_String + @_Delimiter)
            and substring(@_Delimiter + @_String + @_Delimiter , Number - 1, 1) = @_Delimiter
            and charindex(@_Delimiter , @_Delimiter + @_String + @_Delimiter , Number) - Number > 0
    return
end
```
