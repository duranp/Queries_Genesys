


select sum(logintime)/3600 from agent_day where login = 'DNS425' and dbo.dmy(fecha) = '20120920'


SELECT DATEDIFF(SECOND,'20120907 09:00','20120907 16:00')*1.0/3600*1.0

DROP TABLE #T
SELECT * INTO #T FROM OPENQUERY(GE2,'select To_date(start_time,''yyyymmddhh24miss'')AS INICIO,To_date(end_time,''yyyymmddhh24miss'')AS FIN, a.* from contact.agent_state_201209 a
where contact.usr(agent) IN ( ''DNS377'',''DNS425'',''DNS378'') AND SUBSTR(START_TIME,1,8) = ''20120907''
order by start_time,end_time')

SELECT DATEDIFF(SECOND,INICIO,FIN),TOTAL_DURATION,* FROM #T2 ORDER BY agent,INICIO

SELECT * FROM #T ORDER BY agent,INICIO

SELECT FECHA,A.* FROM AGENT_HIS A
WHERE LOGIN = 'DNS425' AND DBO.DMY(FECHA) ='20120907' ORDER BY A.FECHA

select * from pseudoskill where pseudoskill like '%ivr%'

insert into pseudoskill values ('IVR_Error_Pago_TC','IVR','COM',40,0,1,'VAG_PCRC_COMERCIAL_MASIVOS',1,NULL)

IVR_Error_Consulta_Deuda_TB
IVR_Error_Consulta_Deuda_Speedy
IVR_Error_Pago_TC




SELECT * FROM bcp_STATS_ONLINE ORDER BY TIMESTAMP DESC

SELECT * FROM VITACORA WHERE APP = 'STASTS_ONLINE' ORDER BY TIMESTAMP DESC