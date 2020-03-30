if object_id( 'dbo.Dates' )is not null
    begin
        drop table
            dbo.Dates;
    end;
go

create table Dates(
    DateId int not null
  , [Date] date not null
  , NextDate date not null
  , [Year] smallint not null
  , YearQuarter int not null
  , YearMonth int not null
  , YearDayOfYear int not null
  , Quarter tinyint not null
  , [Month] tinyint not null
  , DayOfYear smallint not null
  , DayOfMonth smallint not null
  , DayOfWeek tinyint not null
  , DayOfWeekOrdinal tinyint not null
  , YearName varchar( 4 )not null
  , YearQuarterName varchar( 7 )not null
  , YearMonthName varchar( 8 )not null
  , YearMonthNameLong varchar( 14 )not null
  , QuarterName varchar( 2 )not null
  , MonthName varchar( 3 )not null
  , MonthNameLong varchar( 9 )not null
  , WeekdayName varchar( 3 )not null
  , WeekdayNameLong varchar( 9 )not null
  , StartOfYearDate date not null
  , EndOfYearDate date not null
  , StartOfQuarterDate date not null
  , EndOf_QuarterDate date not null
  , StartOfMonthDate date not null
  , EndOfMonthDate date not null
  , StartOfWeekStartingsunDate date not null
  , EndOfWeekStartingsunDate date not null
  , StartOfWeekStartingmonDate date not null
  , EndOfWeekStartingmonDate date not null
  , StartOfWeekStartingtueDate date not null
  , EndOfWeekStartingtueDate date not null
  , StartOfWeekStartingweDDate date not null
  , EndOfWeekStartingweDDate date not null
  , StartOfWeekStartingthuDate date not null
  , EndOfWeekStartingthuDate date not null
  , StartOfWeekStartingfriDate date not null
  , EndOfWeekStartingfriDate date not null
  , StartOfWeekStartingsatDate date not null
  , EndOfWeekStartingsatDate date not null
  , QuarterOffset int not null
  , MonthOffset int not null
  , WeekStartsunOffset int not null
  , WeekStartmonOffset int not null
  , WeekStarttueOffset int not null
  , WeekStartwedOffset int not null
  , WeekStartthuOffset int not null
  , WeekStartfriOffset int not null
  , WeekStartsatOffset int not null
  , JulianDate int not null
  , ModifiedJulianDate int not null
  , IsoDate varchar( 10 )not null
  , IsoYearWeekNumber int not null
  , IsoWeekNumber smallint not null
  , IsoDayOfWeek tinyint not null
  , IsYearWeekName varchar( 8 )not null
  , IsoYearWeekdayOfWeekName varchar( 10 )not null
  , DateFormatYYYYMMDD varchar( 10 )not null
  , DateFormatYYYYMD varchar( 10 )not null
  , DateFormatMMDDYYYY varchar( 10 )not null
  , DateFormatMDYYYY varchar( 10 )not null
  , DateFormatMMmDYYYY varchar( 12 )not null
  , DateFormatMMMMMMMMmDYYYY varchar( 18 )not null
  , DateFormatMMDDYY varchar( 8 )not null
  , DateFormatMDYY varchar( 8 )not null
  , constraint PK_Dates primary key clustered( DateId )
  , constraint UQ_Dates_Date unique nonclustered( [Date] ));

go

if object_id( 'dbo.GenerateDates' )is null
    begin exec ( 'create procedure dbo.GenerateDates as print ''''' );
    end;
go

alter procedure dbo.GenerateDates
    @_FirstDate date
  , @_LastDate date
as
begin
    declare
        @Date table(
        DateId int not null
                   primary key clustered
      , [Date] date not null
      , NextDate date not null
      , [Year] smallint not null
      , YearQuarter int not null
      , YearMonth int not null
      , YearDayOfYear int not null
      , Quarter tinyint not null
      , [Month] tinyint not null
      , DayOfYear smallint not null
      , DayOfMonth smallint not null
      , DayOfWeek tinyint not null
      , DayOfWeekOrdinal tinyint not null
      , YearName varchar( 4 )not null
      , YearQuarterName varchar( 7 )not null
      , YearMonthName varchar( 8 )not null
      , YearMonthNameLong varchar( 14 )not null
      , QuarterName varchar( 2 )not null
      , MonthName varchar( 3 )not null
      , MonthNameLong varchar( 9 )not null
      , WeekdayName varchar( 3 )not null
      , WeekdayNameLong varchar( 9 )not null
      , StartOfYearDate date not null
      , EndOfYearDate date not null
      , StartOfQuarterDate date not null
      , EndOf_QuarterDate date not null
      , StartOfMonthDate date not null
      , EndOfMonthDate date not null
      , StartOfWeekStartingsunDate date not null
      , EndOfWeekStartingsunDate date not null
      , StartOfWeekStartingmonDate date not null
      , EndOfWeekStartingmonDate date not null
      , StartOfWeekStartingtueDate date not null
      , EndOfWeekStartingtueDate date not null
      , StartOfWeekStartingweDDate date not null
      , EndOfWeekStartingweDDate date not null
      , StartOfWeekStartingthuDate date not null
      , EndOfWeekStartingthuDate date not null
      , StartOfWeekStartingfriDate date not null
      , EndOfWeekStartingfriDate date not null
      , StartOfWeekStartingsatDate date not null
      , EndOfWeekStartingsatDate date not null
      , QuarterOffset int not null
      , MonthOffset int not null
      , WeekStartsunOffset int not null
      , WeekStartmonOffset int not null
      , WeekStarttueOffset int not null
      , WeekStartwedOffset int not null
      , WeekStartthuOffset int not null
      , WeekStartfriOffset int not null
      , WeekStartsatOffset int not null
      , JulianDate int not null
      , ModifiedJulianDate int not null
      , IsoDate varchar( 10 )not null
      , IsoYearWeekNumber int not null
      , IsoWeekNumber smallint not null
      , IsoDayOfWeek tinyint not null
      , IsYearWeekName varchar( 8 )not null
      , IsoYearWeekdayOfWeekName varchar( 10 )not null
      , DateFormatYYYYMMDD varchar( 10 )not null
      , DateFormatYYYYMD varchar( 10 )not null
      , DateFormatMMDDYYYY varchar( 10 )not null
      , DateFormatMDYYYY varchar( 10 )not null
      , DateFormatMMmDYYYY varchar( 12 )not null
      , DateFormatMMMMMMMMmDYYYY varchar( 18 )not null
      , DateFormatMMDDYY varchar( 8 )not null
      , DateFormatMDYY varchar( 8 )not null );

    declare
        @ErrorMessage varchar( 400 )
      , @StartDate date
      , @EndDate date
      , @LowDate date
      , @StartNumber int
      , @EndNumber int;

    begin try
        -- Verify @_FirstDate is not before 1754-01-01
        if @_FirstDate < '17540101'
            begin
                raiserror( 'The @_FirstDate must be greater that 1754-01-01' , 16 , 1 );
            end;

        -- Verify @_LastDate is not after 9997-12-31
        if @_LastDate > '99971231'
            begin
                raiserror( '@_LastDate cannot be after 9997-12-31' , 16 , 1 );
            end;

        -- Verify @_FirstDate is not after @_LastDate
        if @_FirstDate > @_LastDate
            begin
                raiserror( '@_FirstDate cannot be after @_LastDate' , 16 , 1 );
            end;

        -- Set @StartDate = @_FirstDate at midnight
        select
            @StartDate = dateadd( DD , datediff( DD , 0 , @_FirstDate ) , 0 )
          , @EndDate = dateadd( DD , datediff( DD , 0 , @_LastDate ) , 0 )
          , @LowDate = convert( date , '17530101' );

        -- Find the Number of day from 1753-01-01 to @StartDate and @EndDate
        select
            @StartNumber = datediff( DD , @LowDate , @StartDate )
          , @EndNumber = datediff( DD , @LowDate , @EndDate );

        -- Declare Number tables
        declare
            @Numbers table(
            Number int not null
                       primary key clustered );


        insert into @Numbers
        select
            Number
        from dbo.Numbers n
        where n.Number between 1 and datediff( day , @_FirstDate , @_LastDate );

        -- Declare table of Iso Week ranges
        declare
            @IsoWeek table(
            IsoWeekYear int not null
                            primary key clustered
          , IsoWeekYearStartDate date not null
          , IsoWeekYearEndDate date not null );

        declare
             @IsoStartYear int
            ,@IsoEndYear int;

        select
              @IsoStartYear = datepart( Year , dateadd( Year , -1 , @StartDate ))
            , @IsoEndYear = datepart( Year , dateadd( Year , 1 , @EndDate ));

        -- Load table with start and end Dates for Iso week Years
        insert into @IsoWeek(
            IsoWeekYear
          , IsoWeekYearStartDate
          , IsoWeekYearEndDate )
        select
            IsoWeekYear = a.Number
          , IsoWeekYearStartDate = dateadd( DD , datediff( DD , @LowDate , dateadd( day , 3 , dateadd( Year , a.Number - 1900 , 0 ))) / 7 * 7 , @LowDate )
          , IsoWeekYearEndDate = dateadd( DD , -1 , dateadd( DD , datediff( DD , @LowDate , dateadd( day , 3 , dateadd( Year , a.Number + 1 - 1900 , 0 ))) / 7 * 7 , @LowDate ))
        from( 
            select
                Number = Number + @IsoStartYear
            from @Numbers
            where Number + @IsoStartYear <= @IsoEndYear )a
        order by
            a.Number;

        -- Load Date table
        insert into @Date
        select
            DateId = a.DateId
          , [Date] = a.date
          , NextDate = dateadd( day , 1 , a.date )
          , [Year] = datepart( Year , a.date )
          , YearQuarter = 10 * datepart( Year , a.date ) + datepart( Quarter , a.date )
          , YearMonth = 100 * datepart( Year , a.date ) + datepart( Month , a.date )
          , YearDayOfYear = 1000 * datepart( Year , a.date ) + datediff( DD , dateadd( YY , datediff( YY , 0 , a.date ) , 0 ) , a.date ) + 1
          , Quarter = datepart( Quarter , a.date )
          , [Month] = datepart( Month , a.date )
          , DayOfYear = datediff( DD , dateadd( YY , datediff( YY , 0 , a.date ) , 0 ) , a.date ) + 1
          , DayOfMonth = datepart( day , a.date )
            -- Sunday = 1, Monday = 2, ,,,Saturday = 7
          , DayOfWeek = datediff( DD , '17530107' , a.date ) % 7 + 1
          , DayOfWeekOrdinal = case
                                   when datepart( day , a.date ) >= 1 and datepart( day , a.date ) <= 7 then 1
                                   when datepart( day , a.date ) >= 8 and datepart( day , a.date ) <= 14 then 2
                                   when datepart( day , a.date ) >= 15 and datepart( day , a.date ) <= 21 then 3
                                   when datepart( day , a.date ) >= 22 and datepart( day , a.date ) <= 28 then 4
                                   else 5
                               end
          , YearName = datename( Year , a.date )
          , YearQuarterName = datename( Year , a.date ) + ' Q' + datename( Quarter , a.date )
          , YearMonthName = datename( Year , a.date ) + ' ' + left( datename( Month , a.date ) , 3 )
          , YearMonthNameLong = datename( Year , a.date ) + ' ' + datename( Month , a.date )
          , QuarterName = 'Q' + datename( Quarter , a.date )
          , MonthName = left( datename( Month , a.date ) , 3 )
          , MonthNameLong = datename( Month , a.date )
          , WeekdayName = left( datename( Weekday , a.date ) , 3 )
          , WeekdayNameLong = datename( Weekday , a.date )
          , StartOfYearDate = dateadd( Year , datediff( Year , 0 , a.date ) , 0 )
          , EndOfYearDate = dateadd( day , -1 , dateadd( Year , datediff( Year , 0 , a.date ) + 1 , 0 ))
          , StartOfQuarterDate = dateadd( Quarter , datediff( Quarter , 0 , a.date ) , 0 )
          , EndOf_QuarterDate = dateadd( day , -1 , dateadd( Quarter , datediff( Quarter , 0 , a.date ) + 1 , 0 ))
          , StartOfMonthDate = dateadd( Month , datediff( Month , 0 , a.date ) , 0 )
          , EndOfMonthDate = dateadd( day , -1 , dateadd( Month , datediff( Month , 0 , a.date ) + 1 , 0 ))
          , StartOfWeekStartingSUNDate = dateadd( DD , datediff( DD , '17530107' , a.date ) / 7 * 7 , '17530107' )
          , EndOfWeekStartingSUNDate = dateadd( DD , datediff( DD , '17530107' , a.date ) / 7 * 7 + 6 , '17530107' )
          , StartOfWeekStartingMONDate = dateadd( DD , datediff( DD , '17530101' , a.date ) / 7 * 7 , '17530101' )
          , EndOfWeekStartingMONDate = dateadd( DD , datediff( DD , '17530101' , a.date ) / 7 * 7 + 6 , '17530101' )
          , StartOfWeekStartingTUEDate = dateadd( DD , datediff( DD , '17530102' , a.date ) / 7 * 7 , '17530102' )
          , EndOfWeekStartingTUEDate = dateadd( DD , datediff( DD , '17530102' , a.date ) / 7 * 7 + 6 , '17530102' )
          , StartOfWeekStartingWEDDate = dateadd( DD , datediff( DD , '17530103' , a.date ) / 7 * 7 , '17530103' )
          , EndOfWeekStartingWEDDate = dateadd( DD , datediff( DD , '17530103' , a.date ) / 7 * 7 + 6 , '17530103' )
          , StartOfWeekStartingTHUDate = dateadd( DD , datediff( DD , '17530104' , a.date ) / 7 * 7 , '17530104' )
          , EndOfWeekStartingTHUDate = dateadd( DD , datediff( DD , '17530104' , a.date ) / 7 * 7 + 6 , '17530104' )
          , StartOfWeekStartingFRIDate = dateadd( DD , datediff( DD , '17530105' , a.date ) / 7 * 7 , '17530105' )
          , EndOfWeekStartingFRIDate = dateadd( DD , datediff( DD , '17530105' , a.date ) / 7 * 7 + 6 , '17530105' )
          , StartOfWeekStartingSATDate = dateadd( DD , datediff( DD , '17530106' , a.date ) / 7 * 7 , '17530106' )
          , EndOfWeekStartingSATDate = dateadd( DD , datediff( DD , '17530106' , a.date ) / 7 * 7 + 6 , '17530106' )
          , QuarterOffset = datediff( Quarter , @LowDate , a.date )
          , MonthOffset = datediff( Month , @LowDate , a.date )
          , WeekStartSUNOffset = datediff( day , '17530107' , a.date ) / 7
          , WeekStartMONOffset = datediff( day , '17530101' , a.date ) / 7
          , WeekStartTUEOffset = datediff( day , '17530102' , a.date ) / 7
          , WeekStartWEDOffset = datediff( day , '17530103' , a.date ) / 7
          , WeekStartTHUOffset = datediff( day , '17530104' , a.date ) / 7
          , WeekStartFRIOffset = datediff( day , '17530105' , a.date ) / 7
          , WeekStartSATOffset = datediff( day , '17530106' , a.date ) / 7
          , JulianDate = datediff( day , @LowDate , a.date ) + 2361331
          , ModifiedJulianDate = datediff( day , '18581117' , a.date )
          , IsoDate = replace( convert( char( 10 ) , a.date , 111 ) , '/' , '-' )
          , IsoYearWeekNumber = 100 * b.IsoWeekYear + datediff( DD , b.IsoWeekYearStartDate , a.date ) / 7 + 1
          , IsoWeekNumber = datediff( DD , b.IsoWeekYearStartDate , a.date ) / 7 + 1
            -- Sunday = 1, Monday = 2, ,,,Saturday = 7
          , IsoDayOfWeek = datediff( DD , @LowDate , a.date ) % 7 + 1
          , IsYearWeekName = convert( varchar( 4 ) , b.IsoWeekYear ) + '-W' + right( '00' + convert( varchar( 2 ) , datediff( DD , b.IsoWeekYearStartDate , a.date ) / 7 + 1 ) , 2 )
          , IsoYearWeekdayOfWeekName = convert( varchar( 4 ) , b.IsoWeekYear ) + '-W' + right( '00' + convert( varchar( 2 ) , datediff( DD , b.IsoWeekYearStartDate , a.date ) / 7 + 1 ) , 2 ) + '-' + convert( varchar( 1 ) , datediff( DD , @LowDate , a.date ) % 7 + 1 )
          , DateFormatYYYYMMDD = convert( char( 10 ) , a.date , 111 )
          , DateFormatYYYYMD = convert( varchar( 10 ) , convert( varchar( 4 ) , year( a.date )) + '/' + convert( varchar( 2 ) , month( a.date )) + '/' + convert( varchar( 2 ) , day( a.date )))
          , DateFormatMMDDYYYY = convert( char( 10 ) , a.date , 101 )
          , DateFormatMDYYYY = convert( varchar( 10 ) , convert( varchar( 2 ) , month( a.date )) + '/' + convert( varchar( 2 ) , day( a.date )) + '/' + convert( varchar( 4 ) , year( a.date )))
          , DateFormatMMMDYYYY = convert( varchar( 12 ) , left( datename( Month , a.date ) , 3 ) + ' ' + convert( varchar( 2 ) , day( a.date )) + ', ' + convert( varchar( 4 ) , year( a.date )))
          , DateFormatMMMMMMMMMDYYYY = convert( varchar( 18 ) , datename( Month , a.date ) + ' ' + convert( varchar( 2 ) , day( a.date )) + ', ' + convert( varchar( 4 ) , year( a.date )))
          , DateFormatMMDDYY = convert( char( 8 ) , a.date , 1 )
          , DateFormatMDYY = convert( varchar( 8 ) , convert( varchar( 2 ) , month( a.date )) + '/' + convert( varchar( 2 ) , day( a.date )) + '/' + right( convert( varchar( 4 ) , year( a.date )) , 2 ))
        from
             (
             -- Derived table is all Dates needed for Date range
            select top 100 percent
                 DateId = aa.Number
               , date = dateadd( DD , aa.Number , @LowDate )
            from( 
            select
                Number = Number + @StartNumber
            from @Numbers
            where Number + @StartNumber <= @EndNumber )aa
            order by
                 aa.Number )a
             inner join -- Match each Date to the proper Iso week Year
             @IsoWeek b
                 on a.date between b.IsoWeekYearStartDate and b.IsoWeekYearEndDate
        order by
            a.DateId;

        select
            *
        from @Date;
    end try
    begin catch
        set @ErrorMessage = error_message( );
        raiserror( 'Error: %s' , 16 , 1 , @ErrorMessage );
    end catch;
end;
go


if object_id( 'dbo.DayNameOrdinal' )is not null
    begin
        drop function
            dbo.DayNameOrdinal;
    end;
go

create function dbo.DayNameOrdinal(
    @_OrdinalDay tinyint )
returns varchar( 10 )
as
begin
    return datename( Weekday , cast( '1899-12-30' as datetime ) + @_OrdinalDay );
end; 
go

if object_id( 'dbo.MonthNameOrdinal' )is not null
    begin
        drop function
            dbo.MonthNameOrdinal;
    end;
go

create function dbo.MonthNameOrdinal(
    @_OrdinalMonth tinyint )
returns varchar( 10 )
as
begin
    return datename( Month , dateadd( month , @_OrdinalMonth , cast( '1899-12-30' as datetime )));
end; 
go

-- Seed Dates table
insert into Dates
exec dbo.GenerateDates '19000101' , '21001231';

select
    *
from Dates
where date = '2001-09-11';
