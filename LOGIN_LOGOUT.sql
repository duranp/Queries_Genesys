
declare @date as char(8)
declare @mod as int
declare @sql as varchar(max)
set @mod = 0
set @date = cast(year(DATEADD(MONTH,@MOD,getdate())) as char(4))+ right('0'+cast(month(DATEADD(MONTH,@MOD,getdate())) as varchar(2)),2)


DELETE FROM AGENT_LILO WHERE DIA BETWEEN DBO.PD(RTRIM(@DATE)+'01') AND DBO.uD(RTRIM(@DATE)+'01')
EXEC('INSERT into agent_lilo SELECT *from openquery(ge2,''
select to_date(substr(start_time,1,8),''''RRRRMMDD'''')dia, AGENT, to_date(MIN(START_TIME),''''yyyymmddhh24miss'''')login, to_date(MAX(END_TIME),''''yyyymmddhh24miss'''')logout
from contact.agent_state_'+ @DATE +'
where customer = ''''AG_RPT_UNPRE''''
GROUP BY to_date(substr(start_time,1,8),''''RRRRMMDD''''), AGENT
'')')
