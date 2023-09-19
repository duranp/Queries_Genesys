
DROP TABLE #APPL
select * into #appl from openquery(ge2,'select date_time_key, agent, sum(talktime)talktime, sum(answered)answered, sum(holdtime) holdtime from contact.agent_appl_day group by date_time_key, agent')
select * from #appl where agent not in (select agent from agent_day)

select ap.answered, ap.talktime,* 
FROM 
	AGENT_DAY AG 
		INNER JOIN #APPL ap 
			on ag.agent = ap.agent and ag.date_time = ap.date_time_key 
and ag.answered <> ap.answered
and ag.outbound = 0
and date_time >= '20120701000000'



select top 10 * from interaction_det where nombre_recurso = 'ARIAS, EMILSE DEL VALLE (ATT806a)' and fecha_inicio between '20120706000000' and '20120707000000'

UPDATE AG
SET TALKTIME_IN = AP.TALKTIME 
FROM 
	AGENT_DAY AG 
		INNER JOIN #APPL ap 
			on ag.agent = ap.agent and ag.date_time = ap.date_time_key

S sp_pendientes @NOT_ACTION= 'GESTIONADO'

use vtv

SELECT R.PCRC, talktime, talktime_in,talktime- talktime_in, A.* 
	FROM AGENT_DAY A INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME
WHERE TALKTIME_IN <TALKTIME AND OUTBOUND = 0 AND TALKTIME >0 AND ANSWERED >0
AND DATE_TIME >= '20120601000000'
order by 

select * from interaction_his where login = 'une385' and dbo.dmy(fecha) = '20120611'
select * from agent_day where nrr4 > 0 and fecha = '26/06/2012'
select * 
	from #appl 
where agent = 'Isaia, Maria Fernanda (DDC827)' and date_time_key = '20120606000000'  


select * 
	from agent_day
where agent = 'Isaia, Maria Fernanda (DDC827)' and date_time = '20120606000000' and 

select a.mes, a.pcrc, floor(a.tmo), floor(b.tmo), floor(a.tmo-b.tmo), floor(c.tmo)
from (
SELECT month(fecha)mes, PCRC, 
CASE WHEN (SUM(ANSWERED)-SUM(SHORTCALLS))=0 THEN 0 ELSE (sum(talktime)+sum(nrr5))/(sum(answered)-sum(SHORTCALLS)) END tmo
FROM AGENT_DAY A INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME AND DATE_TIME >= '20120101000000'
GROUP BY month(fecha), PCRC)a
inner join (
SELECT month(fecha)mes, PCRC, 
CASE WHEN (SUM(ANSWERED)-SUM(SHORTCALLS))=0 THEN 0 ELSE (sum(talktime_in)+sum(nrr5))/(sum(answered)-sum(SHORTCALLS)) END tmo
FROM AGENT_DAY A INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME AND DATE_TIME >= '20120101000000'
GROUP BY month(fecha), PCRC)b
on a.pcrc = b.pcrc and a.mes = b.mes
left join (
SELECT month(fecha)mes, PCRC, 
CASE WHEN (SUM(outbound))=0 THEN 0 ELSE (SUM(talktime-isnull(TALKTIME_in,0))+sum(nrr5))/(SUM(outbound)) END tmo
FROM AGENT_DAY A INNER JOIN ROSTER_CM R ON A.LOGIN = R.NAME AND DATE_TIME >= '20120101000000'
GROUP BY month(fecha), PCRC)c 
on a.pcrc = c.pcrc and a.mes = c.mes
where a.pcrc <> ''

select * from facturacion..bcp_ajustados
select * from openquery(ge,'
select nombre_recurso agent, substr(fecha_inicio,1,8)+''000000'' date_time, sum(tiempo_recurso) t
        from contact_unpre.interac_resource_201206
where tipo_interaction = ''Inbound''
and tipo_recurso = ''Agent''
and resultado_tecnico = ''Redirected''
group by nombre_recurso , substr(fecha_inicio,1,8)+''000000''
') order by cast(t as int) desc

select  top 1000 talktime+notreadytime+readytime, logintime, * 
from agent_his 
where outbound > 1 and answered > 1 and logintime = 900 and talktime+notreadytime+readytime+acw <>logintime




select * from stats_online where tx_stat = 'Total_Cleared' and tx_vq = 'vq_retencion' order by timestamp desc
SELECT * FROM #APPL WHERE AGENT = 'RUIZ, GERMAN EDUARDO (ATN037)' AND DATE_TIME_KEY='20120627000000'

truncate table agent_state

select a.TT, TALKTIME, * 
FROM (
	SELECT AGENT, DATE_tIME, SUM(TALKTIME)TT FROM AGENT_SK_DAY GROUP BY AGENT, DATE_tIME
	)A
	INNER JOIN AGENT_DAY D
		ON A.AGENT = D.AGENT AND A.DATE_TIME = D.DATE_tIME AND D.OUTBOUND = 0 AND A.TT <> D.TALKTIME

