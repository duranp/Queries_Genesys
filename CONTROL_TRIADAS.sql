
--PARQUE TRIADA
DROP TABLE #p
SELECT ANI, CD_TRIADA, NAME INTO #P FROM CARTERA C INNER JOIN DW..BCP_PARQUE P ON C.CD_PARTY = P.CD_PARTY_TITULAR

--INTERVALIZO
create table #int (int datetime)
declare @fi datetime
set @fi = '01/08/2011'
while @fi < getdate()
begin
	insert into #int values(@fi)
	set @fi = dateadd(minute,15,@fi)
end

--DROP TABLE #INT_HIS 

SELECT I.*,C.CD_TRIADA, [NAME], [INT] 
INTO #INT_HIS 
FROM INTERACTION_HIS I INNER JOIN #P C ON I.GVP_POSTDISCADO = C.ANI
INNER JOIN #INT ON I.FECHA BETWEEN DATEADD(SECOND,1,DATEADD(MINUTE,-15,[INT])) AND [INT]
and fecha >= '01/08/2011'


SELECT * FROM (
	select fecha, 
	SUM(CASE WHEN CD_TRIADA = 11 THEN 1 ELSE 0 END) [11], 
	SUM(CASE WHEN CD_TRIADA = 12 THEN 1 ELSE 0 END) [12], 
	sum(case when login = 'une346' then 1 else 0 end)une346,
	sum(case when login = 'une416' then 1 else 0 end)une416,
	sum(case when login = 'une440' then 1 else 0 end)une440,
	sum(case when login = 'une119' then 1 else 0 end)une119,
	sum(case when login = 'une365' then 1 else 0 end)une365,
	sum(case when login = 'ZCME34' then 1 else 0 end)ZCME34
	from agent_his a LEFT JOIN (SELECT DISTINCT CD_TRIADA, NAME FROM CARTERA) C ON A.LOGIN = C.NAME
	where login in (select [name] from cartera) and fecha >= '01/08/2011'
	group  by fecha)B
LEFT JOIN (
	SELECT [INT], 
	SUM(CASE WHEN CD_TRIADA = 11 THEN 1 ELSE 0 END) [11], 
	SUM(CASE WHEN CD_TRIADA = 12 THEN 1 ELSE 0 END) [12], 
	sum(case when login = 'une346' then 1 else 0 end)une346,
	sum(case when login = 'une416' then 1 else 0 end)une416,
	sum(case when login = 'une440' then 1 else 0 end)une440,
	sum(case when login = 'une119' then 1 else 0 end)une119,
	sum(case when login = 'une365' then 1 else 0 end)une365,
	sum(case when login = 'ZCME34' then 1 else 0 end)ZCME34
	FROM #INT_HIS 
	GROUP BY [INT])A
ON A.INT = B.FECHA