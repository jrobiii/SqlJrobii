# Getting the first and last day of the month
```sql
declare @Date date = getdate()

select datefromparts(YEAR(@Date), month(@Date), 1) as FirstDayOfThisMonth
select dateadd(DAY, -1, datefromparts(year(@Date), month(@Date) +1, 1)) as LastDayOfThisMonth
```