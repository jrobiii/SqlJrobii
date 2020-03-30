/** Create Date Dimension Table **/
/* Create First numbers table for key generation */
if object_id('tempdb..#NumbersSmall') is not null drop table #NumbersSmall
create table #NumbersSmall (Number INT);

INSERT INTO #NumbersSmall
VALUES (0)
	,(1)
	,(2)
	,(3)
	,(4)
	,(5)
	,(6)
	,(7)
	,(8)
	,(9);

/* Create Second numbers table for key generation */
CREATE TABLE Numbers (
    Number BIGINT
    ,constraint PK_Numbers primary key clustered (Number)
);

INSERT INTO Numbers (Number)
SELECT (tenthousands.number * 10000 + thousands.number * 1000 + hundreds.number * 100 + tens.number * 10 + ones.number) AS Number
FROM #NumbersSmall tenthousands
	,#NumbersSmall thousands
	,#NumbersSmall hundreds
	,#NumbersSmall tens
	,#NumbersSmall ones
GO


/*
drop table #NumbersSmall
drop table Numbers

*/