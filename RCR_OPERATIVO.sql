
--fcr operativo

select 
distinct year(i1.fecha) anio, month(i1.fecha) mes, i1.ani, i1.pseudoskill, 
case when i2.fcr2 is null then 1 else 0 end fcr2, 
case when i7.fcr7 is null then 1 else 0 end fcr7 
into #t
from interaction_his i1 
	left join interaction_his i2 on i1.ani = i2.ani and i1.pseudoskill = i2.pseudoskill and i1.fcr2 <> i2.fcr2 and month(i1.fecha) = month(i2.fecha) 
	left join interaction_his i7 on i1.ani = i7.ani and i1.pseudoskill = i7.pseudoskill and i1.fcr7 <> i7.fcr7 and month(i1.fecha) = month(i7.fecha) 
go


--freezo tabla
truncate table fcr_operativo
go

insert into fcr_operativo
select ll.anio, ll.mes, ll.atencion, ll.segmento, ll.fcr2_ll, ll.fcr2_q_LL, ll.fcr7_ll, ll.fcr7_q_ll, ani.fcr2_ani, ani.fcr2_q_ani, ani.fcr7_ani, ani.fcr7_q_ani 
--into fcr_operativo
from (
	select case when grouping(year(fecha)) = 1 then 'zzTotal' else cast(year(fecha) as varchar(7)) end anio, case when grouping(month(fecha)) = 1 then 'zzTotal' else cast(month(fecha) as varchar(7)) end mes, case when grouping(atencion) = 1 then 'zzTotal' else atencion end atencion, case when grouping(segmento) = 1 then 'zzTotal' else segmento end segmento, 
	sum(case when fcr2 is not null then 1 else 0 end) fcr2_q_LL, 
	cast(sum(cast(fcr2 as tinyint))*1.0/sum(case when fcr2 is not null then 1 else 0 end)*1.0 as decimal(6,4)) [fcr2_LL],
	sum(case when fcr7 is not null then 1 else 0 end) fcr7_q_LL, 
	cast(sum(cast(fcr7 as tinyint))*1.0/sum(case when fcr7 is not null then 1 else 0 end)*1.0 as decimal(6,4)) [fcr7_LL]
	from interaction_his i 
		inner join pseudoskill p 
			on REPLACE(dbo.splitindex(i.pseudoskill,'|',0),'_apy','') = p.pseudoskill and atencion not in ( 'opc1','verif')
	group by year(fecha), month(fecha), atencion, segmento with rollup
)ll left join (
	select case when grouping(anio) = 1 then 'zzTotal' else cast(anio as varchar(7)) end anio, case when grouping(mes) = 1 then 'zzTotal' else cast(mes as varchar(7)) end mes, case when grouping(atencion) = 1 then 'zzTotal' else atencion end atencion, case when grouping(segmento) = 1 then 'zzTotal' else segmento end segmento, 
	sum(case when fcr2 is not null then 1 else 0 end) fcr2_q_ani, 
	cast(sum(cast(fcr2 as tinyint))*1.0/sum(case when fcr2 is not null then 1 else 0 end)*1.0 as decimal(6,4)) [fcr2_ani],
	sum(case when fcr7 is not null then 1 else 0 end) fcr7_q_ani, 
	cast(sum(cast(fcr7 as tinyint))*1.0/sum(case when fcr7 is not null then 1 else 0 end)*1.0 as decimal(6,4)) [fcr7_ani]
	from #t i 
		inner join pseudoskill p 
			on REPLACE(dbo.splitindex(i.pseudoskill,'|',0),'_apy','') = p.pseudoskill and atencion not in ('opc1','verif')    
	group by anio, mes, atencion, segmento with rollup
	)
ani on ll.anio = ani.anio and ll.mes = ani.mes and ll.segmento = ani.segmento and ll.atencion = ani.atencion
order by ll.anio, ll.mes, ll.atencion, ll.segmento
go

drop table #t



/*
alter PROCEDURE SP_GET_FCR_OPERATIVO (@ANIO as smallint, @mes as tinyint, @atencion as varchar(5))
AS
select * from fcr_operativo where mes = @mes and atencion = @atencion and anio = @anio
order by segmento

GRANT EXEC ON SP_GET_FCR_OPERATIVO TO WEB*/