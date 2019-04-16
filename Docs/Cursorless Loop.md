# Loop over a dataset with out using a cursor

This method assumes that the values in the dataset to be iterated over are unique.  

The primary reason that this method works comes down to the behavior of the aggregate `min`. First, @Database is initialized with the smallest DatabaseName in the table.  In the table below that would set @DatabaseName to "Fruit".
| |DatabaseName|
|---|---|
|->|Fruit|
||Meat|
||Vegetable|

The iteration occurs in the `set` statement. The @DatabaseName is set to the smallest value of DatabaseName in the @Databases table where the value is greater then the previous value of @DatabaseName. 

In otherwords, carrying forward with the previous example, @DatabaseName was initialized to "Fruit".  The first time that the iteration (using the set statement) is encountered the smallest record that is greater than "Fruit" is "Meat".  The next time through the loop the smallest record that is greater than "Meat" is "Vegetable" and the third iteration through the loop there are no more records that are greater than "Vegetable".

This is where the beauty of `min` comes in.  When no records meet the criteria `min` will return `NULL`.  This will cause the `while` statement to terminate the loop

```sql
declare @Databases table (DatabaseName sysname not null)
insert into @Databases
    select name from sys.databases where database_id > 4

declare @DatabaseName = (select min(DatabaseName) from @Databases)

while (@DatabaseName is not null) begin

    -- Put your work to be done for each iteration here.
    print @DatabaseName

    set @DatabaseName = (select min(DatabaseName) from @Databases where DatabaseName > @DatabaseName)
end
```