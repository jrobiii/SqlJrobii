-- U.S. Holdays derived from http://www.usa.gov/citizens/holidays.shtml
if object_id('HolidayDefinitionStatic') is not null drop table HolidayDefinitionStatic
go

create table dbo.HolidayDefinitionStatic (
     [Month]      tinyint not null
    ,[DayOfMonth] tinyint not null 
    ,Name         sysname not null
    ,IsFederal    bit not null 
    ,constraint PK_HolidayDefinitionStatic primary key clustered ([Month], [DayOfMonth])
    ,constraint UQ_HolidayDefinitionStatic_Name unique nonclustered (Name)
)

insert into dbo.HolidayDefinitionStatic
    values
         ( 1,  1, 'New Years',             1)
        ,( 2,  2, 'Groundhog Day',         0)
        ,( 2, 14, 'Valentine''s Day',      0)
        ,( 3, 17, 'St. Patrick''s Day',    0)
        ,( 4,  1, 'April Fools Day',       0)
        ,( 4, 22, 'Earth Day',             0)
        ,( 5,  5, 'Cinco de Mayo',         0)
        ,( 5,  1, 'May Day',               0)
        ,( 6, 14, 'Flag Day',              0)
        ,( 7,  4, 'U.S. Independence Day', 1)
        ,( 9, 11, 'Patriot Day',           0)
        ,(10, 31, 'Holoween',              0)
        ,(11, 11, 'Veterans Day',          1)
        ,(12,  7, 'Pearl Harbor Day',      0)
        ,(12, 24, 'Christmas Eve',         1)
        ,(12, 25, 'Christmas',             1)
        ,(12, 31, 'New Years Eve',         1)


if object_id('dbo.HolidayDefinitionOrdinal') is not null drop table dbo.HolidayDefinitionOrdinal
go

create table dbo.HolidayDefinitionOrdinal (
     [Month]      tinyint not null
    ,[DayOfWeek]  tinyint not null 
    ,Ordinal   varchar(10) not null 
    ,Name         sysname not null
    ,HolidayRule  sysname not null
    ,IsFederal    bit not null 
    ,constraint PK_HolidayDefinitionOrdinal primary key clustered ([Month], [DayOfWeek], [Ordinal])
    ,constraint UQ_HolidayDefinitionOrdinal_Name unique nonclustered (Name)
)

go

if object_id('dbo.HolidayOrdinalValidOccurances') is not null drop rule dbo.HolidayOrdinalValidOccurances
go

create rule dbo.HolidayOrdinalValidOccurances as 
    @Value in ('first', 'last', 'second', 'third', 'fourth', 'fifth', '1', '2', '3', '4', '5')

go

exec sp_bindrule 'dbo.HolidayOrdinalValidOccurances', 'dbo.HolidayDefinitionOrdinal.Ordinal'

insert into HolidayDefinitionOrdinal
    values
         (11, 5, 'Fourth', 'Thanksgiving',           'Fourth Thursday in November', 1)
        ,( 1, 2, 'Third',  'Martin Luther King Day', 'Third Monday in January',     1)
        ,( 2, 2, 'Third',  'Washington''s Birthday', 'Third Monday in February',    1)
        ,( 4, 6, 'Last',   'Arbor Day',              'Last Friday in April',        0)
        ,( 5, 2, 'Last',   'Memorial Day',           'Last Monday in May',          1)
        ,( 5, 1, 'Second', 'Mother''s Day',          'Second Sunday in May',        0)
        ,( 6, 1, 'Third',  'Father''s Day',          'Third Sunday in June',        0)
        ,( 9, 2, 'First',  'Labor Day',              'First Monday in September',   1)
        ,(10, 2, 'Second', 'Columbus Day',           'Second Monday in October',    0)

if object_id('dbo.Holidays') is not null drop table dbo.Holidays
go

create table Holidays ( 
    Date       date not null
    ,Name      sysname not null 
    ,IsFederal bit not null 
    ,constraint PK_Holidays primary key clustered (Date, Name)
)

;with MonthsAndYears as ( 
    select 
        Year
        ,Month
    from Dates
    group by 
        Year
        ,Month
)
insert into Holidays (Date, Name, IsFederal)
    select 
         datefromparts(may.Year, may.Month, hds.DayOfMonth)
        ,hds.Name
        ,hds.IsFederal
    from 
        MonthsAndYears may
        inner join HolidayDefinitionStatic hds 
            on hds.Month = may.Month
    order by 
         may.Year
        ,may.Month

;with Years as ( 
    select Year from Dates d group by Year
)
insert into Holidays (Date, Name, IsFederal)
    select 
        case 
            when hdo.Ordinal = 'First' or hdo.Ordinal = '1' then 
                (select date from Dates d where d.Month = hdo.Month and d.DayOfWeek = hdo.DayOfWeek and d.Year = y.Year and d.DayOfWeekOrdinal = 1)
            when hdo.Ordinal = 'Second' or hdo.Ordinal = '2' then 
                (select date from Dates d where d.Month = hdo.Month and d.DayOfWeek = hdo.DayOfWeek and d.Year = y.Year and d.DayOfWeekOrdinal = 2)
            when hdo.Ordinal = 'Third' or hdo.Ordinal = '3' then 
                (select date from Dates d where d.Month = hdo.Month and d.DayOfWeek = hdo.DayOfWeek and d.Year = y.Year and d.DayOfWeekOrdinal = 3)
            when hdo.Ordinal = 'Fourth' or hdo.Ordinal = '4' then 
                (select date from Dates d where d.Month = hdo.Month and d.DayOfWeek = hdo.DayOfWeek and d.Year = y.Year and d.DayOfWeekOrdinal = 4)
            when hdo.Ordinal = 'Fifth' or hdo.Ordinal = '5' then 
                (select date from Dates d where d.Month = hdo.Month and d.DayOfWeek = hdo.DayOfWeek and d.Year = y.Year and d.DayOfWeekOrdinal = 5)
            when hdo.Ordinal = 'Last' then 
                (select date from Dates d1 
                    where   
                        d1.Month = hdo.Month 
                        and d1.DayOfWeek = hdo.DayOfWeek 
                        and d1.Year = y.Year 
                        and d1.DayOfWeekOrdinal = (select max(DayOfWeekOrdinal) from Dates where Year = y.Year and Month = hdo.Month and DayOfWeek = hdo.DayOfWeek))
            else NULL
        end
        ,hdo.Name
        ,hdo.IsFederal
    from 
        Years y 
        cross join dbo.HolidayDefinitionOrdinal hdo 
    order by 
        y.Year
        ,hdo.Month
        ,hdo.DayOfWeek

--select * from Holidays

