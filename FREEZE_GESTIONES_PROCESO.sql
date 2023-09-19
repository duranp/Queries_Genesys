

SELECT x.*,motivo,submotivo,clasificacion into #temp2 FROM (
SELECT     DISTINCT SWOBJECTID, SWDATERECEIVED, SWRECEIVER, SWFORWARDER, SWACTIONTAKEN, SWDATEACTIONTAKEN, SWACTIONTAKENBY, SWDISPLAY, 
                      SWMESSAGETYPE, SWNOTE, SWMASTERVER, SWCREATEDBY
FROM         inbox as i where year(SWDATEACTIONTAKEN) = year(getdate())) X
inner join vw_casos as v on v.SWCASEID =x.SWOBJECTID
ORDER BY SWOBJECTID, SWDATERECEIVED



--PRIMERA TEMP (casos)
DELETE FROM Gxp_TCASOS WHERE ANIO = YEAR(GETDATE())

INSERT into Gxp_TCASOS select YEAR(GETDATE()) ANIO,* 
FROM (SELECT proceso,motivo,submotivo,clasificacion,[1] AS Enero,[2]as Febrero,[3] as Marzo,[4] as Abril,[5] as Mayo
,[6] as Junio,[7] as Julio,[8] as Agosto,[9] as Septiembre,[10] as Octubre,[11] as Noviembre
,[12] as Diciembre
FROM(
select distinct DATEPART(MM,SWDATEACTIONTAKEN) AS MES ,r.proceso,r.motivo,r.submotivo,r.clasificacion ,COUNT(*)AS CASOS--,sum((case when datediff(hour,swdatereceived,isnull(cctfechamodif,swdateactiontaken))<=48 then 1 else 0 end)) AS ANTES48
from #temp2 as t
INNER JOIN VTV..obj_pend_x_proc AS R ON R.motivo=T.motivo and ISNULL(r.submotivo,t.submotivo)=t.submotivo 
                and isnull(r.clasificacion,t.clasificacion)=t.clasificacion
WHERE DATEPART(YEAR,SWDATEACTIONTAKEN)=year(getdate()) 
GROUP BY DATEPART(MM,SWDATEACTIONTAKEN), r.proceso,r.motivo,r.submotivo,r.clasificacion WITH ROLLUP)AS PVT
PIVOT (SUM([CASOS])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE

) AS T


select T.swobjectid,t.swdatereceived,t.swreceiver,t.swactiontaken,t.swdateactiontaken,t.swactiontakenby,t.swcreatedby,r.proceso,r.motivo,r.submotivo,r.Clasificacion, R.OBJETIVO 
into #temp3  from #temp2 t
INNER JOIN VTV..obj_pend_x_proc AS R ON R.motivo=T.motivo and ISNULL(r.submotivo,t.submotivo)=t.submotivo 
                and isnull(r.clasificacion,t.clasificacion)=t.clasificacion
    


--SEGUNDA TEMP(%cumpl)
DELETE FROM gxp_tantesobj WHERE ANIO = YEAR(GETDATE())

INSERT into gxp_tantesobj select YEAR(GETDATE()) ANIO,* 
FROM (SELECT proceso,motivo,submotivo,clasificacion,[1] AS Enero,[2]as Febrero,[3] as Marzo,[4] as Abril,[5] as Mayo
,[6] as Junio,[7] as Julio,[8] as Agosto,[9] as Septiembre,[10] as Octubre,[11] as Noviembre
,[12] as Diciembre
FROM(

SELECT distinct DATEPART(MM,SWDATEACTIONTAKEN) AS MES ,proceso,motivo,submotivo,clasificacion,100*cast((sum((case when datediff(hour,swdatereceived,isnull(cctfechamodif,swdateactiontaken))<=(OBJETIVO*24) then 1 else 0 end)))/cast(count(*) as decimal(10,2))as decimal(10,2)) AS [%cumpl]
FROM #TEMP3 T
left join vtv..diferido as d on d.cctobjectid=t.swobjectid and cctfechamodif between swdatereceived and swdateactiontaken
                and swactiontaken='diferido'
WHERE DATEPART(YEAR,SWDATEACTIONTAKEN)=year(getdate())
GROUP BY DATEPART(MM,SWDATEACTIONTAKEN),proceso,motivo,submotivo,clasificacion WITH ROLLUP)AS PVT
PIVOT (SUM([%cumpl])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE
) AS T

--Tercera Temp (casos distintos)
DELETE FROM Gxp_TDISTINTOS WHERE ANIO = YEAR(GETDATE())


INSERT into Gxp_TDISTINTOS select YEAR(GETDATE()) ANIO,* 
FROM (SELECT proceso,motivo,submotivo,clasificacion,[1] AS Enero,[2]as Febrero,[3] as Marzo,[4] as Abril,[5] as Mayo
,[6] as Junio,[7] as Julio,[8] as Agosto,[9] as Septiembre,[10] as Octubre,[11] as Noviembre
,[12] as Diciembre
FROM(
select  distinct MES ,proceso,motivo,submotivo,clasificacion, sum(distintos)as distintos
from (select distinct DATEPART(MM,SWDATEACTIONTAKEN)AS MES,r.proceso,r.motivo,r.submotivo,r.clasificacion,COUNT(distinct swobjectid)AS distintos
      from #temp2 as t
      INNER JOIN VTV..obj_pend_x_proc AS R ON R.motivo=T.motivo and ISNULL(r.submotivo,t.submotivo)=t.submotivo 
                and isnull(r.clasificacion,t.clasificacion)=t.clasificacion
      WHERE DATEPART(YEAR,SWDATEACTIONTAKEN)=year(getdate()) 
      group by DATEPART(MM,SWDATEACTIONTAKEN),r.proceso,r.motivo,r.submotivo,r.clasificacion) as w
GROUP BY mes,proceso,motivo,submotivo,clasificacion WITH ROLLUP)AS PVT
PIVOT (SUM([distintos])
FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS PIVOTABLE

) AS T



drop table #temp2
drop table #temp3
