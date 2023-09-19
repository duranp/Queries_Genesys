declare @date as char(8), @mod as int, @sql as varchar(max)
set @mod = 0
set @date = cast(year(DATEADD(MONTH,@MOD,getdate())) as char(4))+ right('0'+cast(month(DATEADD(MONTH,@MOD,getdate())) as varchar(2)),2)
PRINT @DATE

delete from agent_out where inicio between dbo.pd(DATEADD(MONTH,@MOD,getdate())) and dbo.ud(DATEADD(MONTH,@MOD,getdate()))+1
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

--interavalos
--update ah set answered = answered +isnull(o.out,0)
select answered , answered +isnull(o.out,0), *
from agent_his h inner join 
			(select dbo.i(inicio)fecha, login, sum(1) out
            from agent_out
            group by dbo.i(inicio), login)o
on h.login = o.login and h.fecha = o.fecha

--por dia
--update d set answered = answered +isnull(o.out,0)
select answered , answered +isnull(o.out,0), *
from agent_day d inner join 
			(select dbo.dmy(inicio)fecha, login, sum(1) out
            from agent_out
            group by dbo.dmy(inicio), login)o
on d.login = o.login and d.fecha = o.fecha


--UPDATE AGENT FREEZE
UPDATE AF
SET ANSWERED = INOUT
FROM AGENT_FREEZE AF
INNER JOIN 
(
	select d.fecha, 
	case when grouping(d.site)=1 then 'aaaTotal' else d.site end site, 
	case when grouping(d.supervisor)=1 then 'aaaTotal' else d.supervisor end supervisor, 
	case when grouping(d.asistente)=1 then 'aaaTotal' else d.asistente end asistente, 
	sum(out) out, sum(answered) [IN], sum(answered +isnull(o.out,0)) INout
	from agent_freeze d
	left join 
				(select dbo.dmy(inicio)fecha, login, sum(1) out
				from agent_out
				group by dbo.dmy(inicio), login)o
	on dbo.usr(asistente) = o.login and d.fecha = o.fecha
	where  d.fecha between '01/10/2012' and '31/10/2012'
	and answered > 0 and pcrc is not null
	and asistente <> 'aaatotal' 
	and asistente in (select agent from agent_out)
	group by d.fecha, d.site, d.supervisor, d.asistente with rollup)OO
on af.fecha = oo.fecha and af.site = oo.site and af.supervisor = oo.supervisor and af.asistente = oo.asistente and oo.[in] = af.answered




--control
select sum(answered) from agent_freeze where fecha between '01/10/2012' and '31/10/2012' and supervisor = 'SUP_DIEHL_CLAUDIA' and asistente = 'aaatotal'
select * from agent_freeze where fecha between '01/10/2012' and '31/10/2012' and asistente in (select agent from agent_out) and pcrc is null
and answered = 0 and outbound = 0

