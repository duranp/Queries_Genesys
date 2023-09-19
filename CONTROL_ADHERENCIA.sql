

 select  *
 from agent_his a                         
  --left join roster_cm r on a.login = r.name                  
  --left join vags v  on r.vag = v.tx_vag  AND ISNULL(V.SUP,R.SUP) = R.SUP                 
 where fecha = '08/02/2012 00:15:00.000' and tx_tcs like 'NEG_carterizado'

select * from agent_day a left join roster_cm r on a.login = r.name                  
wher 

select * from vags where tx_tcs = 'neg_carterizado'

select max(fecha) from agent_day

DELETE FROM AGENT_HIS WHERE DATE_TIME IN (SELECT DATE_TIME FROM BCP_AGENT_HIS)

INSERT INTO AGENT_HIS SELECT * FROM bcp_agent_his2

SELECT * FROM tempdb..req_feb3

delete from tempdb..req_feb3 where cd_pcrc is null

delete from trae_erlang where cre_ts is not null and date >= '01/02/2012'


select segmento,date, sum(1) from trae_erlang where date >= '01/02/2012'
group by segmento,date having sum(1) >1

select agent, date_time, sum(1) FROM BCP_AGENT_HIS2 GROUP BY agent, date_time HAVING SUM(1) >2

select * from bcp_

SELECT * FROM AGENT_HIS WHERE DATE_TIME = '20120210141500' AND AGENT = 'CASASOLA, JIMENA SOLEDAD (DNS384)'

SELECT DISTINCT * INTO AGENT_HIS_D FROM AGENT_HIS
TRUNCATE TABLE AGENT_HIS
INSERT INTO AGENT_HIS SELECT * FROM AGENT_HIS_D

delete from agent_his where date_time between (SELECT min(date_time) FROM BCP_AGENT_HIS2) and (SELECT max(date_time) FROM BCP_AGENT_HIS2)

select * from trae_erlang where date = '20120228 13:15' and segmento = 'NEG_Comercial_NoPers_Atento'



DELETE FROM AGENT_HIS WHERE DATE_TIME IN (SELECT DATE_TIME FROM BCP_AGENT_HIS2)

INSERT INTO AGENT_HIS SELECT * FROM bcp_agent_his2

select * from agent_his where fecha >= '01/02/2012'

update agent_his

UPDATE GENESYS..AGENT_HIS SET LOGIN = substring(agent, charindex('(', agent)+1,len(agent)-charindex('(', agent)-1), fecha = dbo.f(date_time)
where login is null
go

delete from agent_his where fecha is null

INSERT INTO AGENT_HIS SELECT * FROM bcp_agent_his2
select max(date_Time) from bcp_agent_his2



DELETE from trae_erlang where date >= '01/02/2012' and datepart(hour,date) >= 19 AND REQ_STF > 0

select LEFT(convert(varchar(20),GETDATE(),108),5)
UPDATE TRAE_ERLANG 
SET HORA = LEFT(convert(varchar(20),DATE,108),5)
WHERE HORA IS NULL

DBCC SHRINKFILE(MyDatabase_log)

BACKUP LOG GENESYS WITH TRUNCATE_ONLY
DBCC SHRINKFILE(GENESEYS_log)

select cast(left(fecha,10) + ' ' + substring(intervalo,12,5) as datetime),* from tempdb..volumen_febrero
insert into wfm_llamadas
select pcrc, [volumen proy cp], [tmo proy cp], cast(left(fecha,10) + ' ' + substring(intervalo,12,5) as datetime) from tempdb..volumen_febrero
select * from wfm_llamadas where datepart(date >= '01/02/2012'

select * into wfm_llamadas_old from wfm_llamadas

truncate table wfm_llamadas
insert into wfm_llamadas select * from wfm_llamadas_old

delete from wfm_llamadas where date >= '01/01/2012'