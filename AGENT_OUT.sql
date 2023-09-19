--campos auxiliares
UPDATE GENESYS..AGENT_day SET LOGIN = substring(agent, charindex('(', agent)+1,len(agent)-charindex('(', agent)-1), fecha = dbo.f(date_time)
where login is null
go




declare @date as char(8), @mod as int, @sql as varchar(max)
set @mod = 0
set @date = cast(year(DATEADD(MONTH,@MOD,getdate())) as char(4))+ right('0'+cast(month(DATEADD(MONTH,@MOD,getdate())) as varchar(2)),2)
PRINT @DATE

--ACTUAL
truncate table agent_out
set @sql = '
insert into agent_out 
select * from openquery(ge2,''
		select To_date(fecha_inicio,''''yyyymmddhh24miss'''')inicio, To_date(fecha_FIN,''''yyyymmddhh24miss'''')fin, nombre_recurso agent, contact.usr(nombre_recurso) login, tipo_interaction, ultimo_rp 
		FROM CONTACT.INTERAC_RESOURCE_' + @date + '
        WHERE ultimo_rp in (''''10008136'''',''''10008185'''')
        and tipo_interaction = ''''Outbound''''
        and resultado_tecnico_ampliado not in (''''AbandonedWhileQueued'''',''''AbandonedWhileRinging'''')
        and resultado_tecnico not in (''''Redirected'''',''''Abandoned'''')'')'
exec(@sql)


set @mod = -1
set @date = cast(year(DATEADD(MONTH,@MOD,getdate())) as char(4))+ right('0'+cast(month(DATEADD(MONTH,@MOD,getdate())) as varchar(2)),2)
PRINT @DATE

--ANTERIOR
set @sql = '
insert into agent_out 
select * from openquery(ge2,''
		select To_date(fecha_inicio,''''yyyymmddhh24miss'''')inicio, To_date(fecha_FIN,''''yyyymmddhh24miss'''')fin, nombre_recurso agent, contact.usr(nombre_recurso) login, tipo_interaction, ultimo_rp 
		FROM CONTACT.INTERAC_RESOURCE_' + @date + '
        WHERE ultimo_rp in (''''10008136'''',''''10008185'''')
        and tipo_interaction = ''''Outbound''''
        and resultado_tecnico_ampliado not in (''''AbandonedWhileQueued'''',''''AbandonedWhileRinging'''')
        and resultado_tecnico not in (''''Redirected'''',''''Abandoned'''')'')'
exec(@sql)



--por dia
update d set answered = answered +isnull(o.out,0)
--select answered , answered +isnull(o.out,0), *
from agent_day d inner join 
			(select dbo.dmy(inicio)fecha, login, sum(1) out
            from agent_out
            group by dbo.dmy(inicio), login)o
on d.login = o.login and d.fecha = o.fecha