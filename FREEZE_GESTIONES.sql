
SELECT * into #temp FROM (
SELECT     DISTINCT SWOBJECTID, SWDATERECEIVED, SWRECEIVER, SWFORWARDER, SWACTIONTAKEN, SWDATEACTIONTAKEN, SWACTIONTAKENBY, SWDISPLAY, 
                      SWMESSAGETYPE, SWNOTE, SWMASTERVER, SWCREATEDBY
FROM         inbox where year(SWDATEACTIONTAKEN) = year(getdate())) X
ORDER BY SWOBJECTID, SWDATERECEIVED



--PRIMERA TEMP (casos)
DELETE FROM G_TCASOS WHERE ANIO = YEAR(GETDATE())

INSERT into G_TCASOS select YEAR(GETDATE()) ANIO,* 
FROM (SELECT sup,nombres, case when datepart(mm,getdate())>=1 then [1] else null end as Enero,case when datepart(mm,getdate())>=2 then [2] else null end as Febrero,case when datepart(mm,getdate())>=3 then [3] else null end as Marzo,case when datepart(mm,getdate())>=4 then [4] else null end  as Abril,case when datepart(mm,getdate())>=5 then [5] else null end as Mayo
,case when datepart(mm,getdate())>=6 then [6] else null end as Junio,case when datepart(mm,getdate())>=7 then [7] else null end as Julio,case when datepart(mm,getdate())>=8 then [8] else null end as Agosto,case when datepart(mm,getdate())>=9 then [9] else null end as Septiembre,case when datepart(mm,getdate())>=10 then [10] else null end as Octubre,case when datepart(mm,getdate())>=11 then [11] else null end as Noviembre
,case when datepart(mm,getdate())>=12 then [12] else null end as Diciembre
FROM(
select DATEPART(MM,SWDATEACTIONTAKEN) AS MES ,SUP, isnull(nombres,inbox)  as nombres ,COUNT(*)AS CASOS--,sum((case when datediff(hour,swdatereceived,isnull(cctfechamodif,swdateactiontaken))<=48 then 1 else 0 end)) AS ANTES48
from #temp as t
INNER JOIN VTV..ROSTER_BO AS R ON R.INBOX=T.SWRECEIVER
WHERE DATEPART(YEAR,SWDATEACTIONTAKEN)=year(getdate()) 
GROUP BY DATEPART(MM,SWDATEACTIONTAKEN),SUP, isnull(nombres,inbox) WITH ROLLUP)AS PVT
PIVOT (SUM([CASOS])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE
where sup is not null
) AS T

--SEGUNDA TEMP(%cumpl)
DELETE FROM G_TANTES48 WHERE ANIO = YEAR(GETDATE())

INSERT into G_TANTES48 select YEAR(GETDATE()) ANIO,* 
FROM (SELECT sup,nombres,case when datepart(mm,getdate())>=1 then [1] else null end as Enero,case when datepart(mm,getdate())>=2 then [2] else null end as Febrero,case when datepart(mm,getdate())>=3 then [3] else null end as Marzo,case when datepart(mm,getdate())>=4 then [4] else null end  as Abril,case when datepart(mm,getdate())>=5 then [5] else null end as Mayo
,case when datepart(mm,getdate())>=6 then [6] else null end as Junio,case when datepart(mm,getdate())>=7 then [7] else null end as Julio,case when datepart(mm,getdate())>=8 then [8] else null end as Agosto,case when datepart(mm,getdate())>=9 then [9] else null end as Septiembre,case when datepart(mm,getdate())>=10 then [10] else null end as Octubre,case when datepart(mm,getdate())>=11 then [11] else null end as Noviembre
,case when datepart(mm,getdate())>=12 then [12] else null end as Diciembre
FROM(
select DATEPART(MM,SWDATEACTIONTAKEN) AS MES ,SUP,isnull(nombres,inbox) as nombres ,100*cast((sum((case when datediff(hour,swdatereceived,isnull(cctfechamodif,swdateactiontaken))<=48 then 1 else 0 end)))/cast(count(*) as decimal(10,2))as decimal(10,2)) AS [%cumpl]
from #temp as t
INNER JOIN VTV..ROSTER_BO AS R ON R.INBOX=T.SWRECEIVER
left join vtv..diferido as d on d.cctobjectid=t.swobjectid and cctfechamodif between swdatereceived and swdateactiontaken
and swactiontaken='diferido'
WHERE DATEPART(YEAR,SWDATEACTIONTAKEN)=year(getdate())
GROUP BY DATEPART(MM,SWDATEACTIONTAKEN),SUP, isnull(nombres,inbox) WITH ROLLUP)AS PVT
PIVOT (SUM([%cumpl])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE
where sup is not null
) AS T

--Tercera Temp (casos distintos)
DELETE FROM G_TDISTINTOS WHERE ANIO = YEAR(GETDATE())

INSERT into G_TDISTINTOS select YEAR(GETDATE()) ANIO,* 
FROM (SELECT sup,nombres,case when datepart(mm,getdate())>=1 then [1] else null end as Enero,case when datepart(mm,getdate())>=2 then [2] else null end as Febrero,case when datepart(mm,getdate())>=3 then [3] else null end as Marzo,case when datepart(mm,getdate())>=4 then [4] else null end  as Abril,case when datepart(mm,getdate())>=5 then [5] else null end as Mayo
,case when datepart(mm,getdate())>=6 then [6] else null end as Junio,case when datepart(mm,getdate())>=7 then [7] else null end as Julio,case when datepart(mm,getdate())>=8 then [8] else null end as Agosto,case when datepart(mm,getdate())>=9 then [9] else null end as Septiembre,case when datepart(mm,getdate())>=10 then [10] else null end as Octubre,case when datepart(mm,getdate())>=11 then [11] else null end as Noviembre
,case when datepart(mm,getdate())>=12 then [12] else null end as Diciembre
FROM(
select  MES ,SUP, nombres , sum(distintos)as distintos
from (select DATEPART(MM,SWDATEACTIONTAKEN)AS MES,SUP, isnull(NOMBRES,inbox) as nombres ,COUNT(distinct swobjectid)AS distintos
	from #temp as t
	INNER JOIN VTV..ROSTER_BO AS R ON R.INBOX=T.SWRECEIVER 
	WHERE DATEPART(YEAR,SWDATEACTIONTAKEN)=year(getdate()) 
	group by DATEPART(MM,SWDATEACTIONTAKEN),SUP, isnull(NOMBRES,inbox)) as w
GROUP BY mes,SUP, nombres WITH ROLLUP)AS PVT
PIVOT (SUM([distintos])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE
where sup is not null
) AS T

-- CUARTA TEMP(INGRESADAS}
DELETE FROM G_TINGRESADAS WHERE ANIO = YEAR(GETDATE())

INSERT into  G_TINGRESADAS  select YEAR(GETDATE()) ANIO,* 
FROM (SELECT sup,nombres,case when datepart(mm,getdate())>=1 then [1] else null end as Enero,case when datepart(mm,getdate())>=2 then [2] else null end as Febrero,case when datepart(mm,getdate())>=3 then [3] else null end as Marzo,case when datepart(mm,getdate())>=4 then [4] else null end  as Abril,case when datepart(mm,getdate())>=5 then [5] else null end as Mayo
,case when datepart(mm,getdate())>=6 then [6] else null end as Junio,case when datepart(mm,getdate())>=7 then [7] else null end as Julio,case when datepart(mm,getdate())>=8 then [8] else null end as Agosto,case when datepart(mm,getdate())>=9 then [9] else null end as Septiembre,case when datepart(mm,getdate())>=10 then [10] else null end as Octubre,case when datepart(mm,getdate())>=11 then [11] else null end as Noviembre
,case when datepart(mm,getdate())>=12 then [12] else null end as Diciembre
FROM(
select  MES ,SUP, nombres , sum(distintos)as distintos
from (select DATEPART(MM,SWDATERECEIVED)AS MES,SUP, isnull(NOMBRES,inbox) as nombres ,COUNT(distinct swobjectid)AS distintos
	from #temp as t
	INNER JOIN VTV..ROSTER_BO AS R ON R.INBOX=T.SWRECEIVER 
	WHERE DATEPART(YEAR,SWDATERECEIVED)=year(getdate()) 
	group by DATEPART(MM,SWDATERECEIVED),SUP, isnull(NOMBRES,inbox)) as w
GROUP BY mes,SUP, nombres WITH ROLLUP)AS PVT
PIVOT (SUM([distintos])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE
where sup is not null
) AS T



drop table #temp


