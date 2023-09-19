use genesys

delete estadistica_fm
where fecha between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
 


declare @combo as varchar(100) 

set @combo='comercial'


insert into genesys..estadistica_fm 
select f.fecha,isnull(desbordes,0),isnull(transferidas,0) as transferidas,isnull(directo_ivr,0) as directo_ivr,[grupo fijo movil],resto,@combo as  sector
from (
select dbo.dmy(dbo.f(fecha_inicio)) as fecha,count (*) as transferidas
from genesys..interaction_res_fm as d
inner join (select interaction_id, interaction_resource_id
from genesys..interaction_res_fm
where pseudoskill like (case @combo when 'tecnico' then 'fm_tecnico' else 'fm_comercialm2'end) +'%' and dbo.F(fecha_inicio) between dbo.pd(dateadd(month,0,getdate())) and  getdate()  
and tipo_recurso <>'routingpoint') as g on d.interaction_id=g.interaction_id
where d.INTERACTION_RESOURCE_ID=g.interaction_resource_id-1 
and pseudoskill is not null 
group by dbo.dmy(dbo.f(fecha_inicio))) as f
inner join (

select dbo.dmy(dbo.f(fecha_inicio)) as fecha,count (*) as directo_ivr
from genesys..interaction_res_fm as d
inner join (select interaction_id, interaction_resource_id
from genesys..interaction_res_fm
where pseudoskill like (case @combo when 'tecnico' then 'fm_tecnico' else 'fm_comercialm2'end)  +'%' and dbo.F(fecha_inicio) between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
and tipo_recurso <>'routingpoint') as g on d.interaction_id=g.interaction_id
where d.INTERACTION_RESOURCE_ID=g.interaction_resource_id-1 
and pseudoskill is  null 
group by dbo.dmy(dbo.f(fecha_inicio))) as g on g.fecha=f.fecha
LEFT join (select dbo.dmy(dbo.f(fecha_inicio)) as fecha,isnull(sum( case when @combo='comercial' and  nombre_recurso  in ('Carballo, Carlos Javier (DNS172)','Carrizo, Matias Federico (DNS283)','Fernandez Huespe, Maria Eugenia (DNS379)','Quiroga Quiquinto, Maria Macarena (DNS304)') then 1 when @combo='tecnico' and nombre_recurso in ('PEREZ, DIEGO SEBASTIAN (ZCEM134)','REMENTERIA, MAURO (ZCEM142)','MORENO, GUSTAVO DANIEL (ZCEM132)','GOMEZ, CRISTIAN MIGUEL (ZCEM127)') then 1 END),0) as [grupo fijo movil],
isnull(SUM(case when @combo='comercial' and nombre_recurso not in ('Carballo, Carlos Javier (DNS172)','Carrizo, Matias Federico (DNS283)','Fernandez Huespe, Maria Eugenia (DNS379)','Quiroga Quiquinto, Maria Macarena (DNS304)') then 1  when @combo='tecnico' and nombre_recurso not in('PEREZ, DIEGO SEBASTIAN (ZCEM134)','REMENTERIA, MAURO (ZCEM142)','MORENO, GUSTAVO DANIEL (ZCEM132)','GOMEZ, CRISTIAN MIGUEL (ZCEM127)')then 1 else 0 END),0) as resto
 
from genesys..interaction_res_fm as d
inner join (select interaction_id, interaction_resource_id
from genesys..interaction_res_fm
where pseudoskill like (case @combo when 'tecnico' then 'fm_tecnico' else 'fm_comercialm2'end)  +'%' and dbo.F(fecha_inicio) between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
and tipo_recurso <>'routingpoint') as g on d.interaction_id=g.interaction_id
where d.INTERACTION_RESOURCE_ID=g.interaction_resource_id
group by dbo.dmy(dbo.f(fecha_inicio))) as k on k.fecha=f.fecha
left join (
select dbo.dmy(dbo.f(fecha_inicio)) as fecha, sum(case when pseudoskill not  like  ('%fm_comercialm2%') or pseudoskill not like ('%fm_tecnico%') then 1 end) as desbordes
from interaction_det
where nombre_recurso in 
(select lastname+','+' '+firstname+' ('+NAME+')'
from roster_cm
where sk  like case when @combo='comercial' then '%vag_comercial_fm%' when @combo='tecnico' then '%vag_tecnico_fm%' end)
and pseudoskill not like (case @combo when 'tecnico' then 'fm_tecnico'  else 'fm_comercialm2'end)  +'%'
and dbo.dmy(dbo.f(fecha_inicio)) between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
group by dbo.dmy(dbo.f(fecha_inicio))

) as j on j.fecha=f.fecha 





declare @combo2 as varchar(100) 


set @combo2='tecnico'

insert into estadistica_fm
select  f.fecha,desbordes,isnull(transferidas,0) as transferidas,isnull(directo_ivr,0) as directo_ivr,[grupo fijo movil],resto,@combo2
from (
select dbo.dmy(dbo.f(fecha_inicio)) as fecha,count (*) as transferidas
from genesys..interaction_res_fm as d
inner join (select interaction_id, interaction_resource_id
from genesys..interaction_res_fm
where pseudoskill like (case @combo2 when 'tecnico' then 'fm_tecnico' else 'fm_comercialm2'end) +'%' and dbo.F(fecha_inicio) between dbo.pd(dateadd(month,0,getdate())) and  getdate()    
and tipo_recurso <>'routingpoint') as g on d.interaction_id=g.interaction_id
where d.INTERACTION_RESOURCE_ID=g.interaction_resource_id-1 
and pseudoskill is not null 
group by dbo.dmy(dbo.f(fecha_inicio))) as f
left join (

select dbo.dmy(dbo.f(fecha_inicio)) as fecha,count (*) as directo_ivr
from genesys..interaction_res_fm as d
inner join (select interaction_id, interaction_resource_id
from genesys..interaction_res_fm
where pseudoskill like (case @combo2 when 'tecnico' then 'fm_tecnico' else 'fm_comercialm2'end)  +'%' and dbo.F(fecha_inicio) between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
and tipo_recurso <>'routingpoint') as g on d.interaction_id=g.interaction_id
where d.INTERACTION_RESOURCE_ID=g.interaction_resource_id-1 
and pseudoskill is  null 
group by dbo.dmy(dbo.f(fecha_inicio))) as g on g.fecha=f.fecha
LEFT join (select dbo.dmy(dbo.f(fecha_inicio)) as fecha,isnull(sum( case when @combo2='comercial' and  nombre_recurso  in ('Carballo, Carlos Javier (DNS172)','Carrizo, Matias Federico (DNS283)','Fernandez Huespe, Maria Eugenia (DNS379)','Quiroga Quiquinto, Maria Macarena (DNS304)') then 1 when @combo2='tecnico' and nombre_recurso in ('PEREZ, DIEGO SEBASTIAN (ZCEM134)','REMENTERIA, MAURO (ZCEM142)','MORENO, GUSTAVO DANIEL (ZCEM132)','GOMEZ, CRISTIAN MIGUEL (ZCEM127)') then 1 END),0) as [grupo fijo movil],
isnull(SUM(case when @combo2='comercial' and nombre_recurso not in ('Carballo, Carlos Javier (DNS172)','Carrizo, Matias Federico (DNS283)','Fernandez Huespe, Maria Eugenia (DNS379)','Quiroga Quiquinto, Maria Macarena (DNS304)') then 1  when @combo2='tecnico' and nombre_recurso not in('PEREZ, DIEGO SEBASTIAN (ZCEM134)','REMENTERIA, MAURO (ZCEM142)','MORENO, GUSTAVO DANIEL (ZCEM132)','GOMEZ, CRISTIAN MIGUEL (ZCEM127)')then 1 else 0 END),0) as resto
 
from genesys..interaction_res_fm as d
inner join (select interaction_id, interaction_resource_id
from genesys..interaction_res_fm
where pseudoskill like (case @combo2 when 'tecnico' then 'fm_tecnico' else 'fm_comercialm2'end)  +'%' and dbo.F(fecha_inicio) between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
and tipo_recurso <>'routingpoint') as g on d.interaction_id=g.interaction_id
where d.INTERACTION_RESOURCE_ID=g.interaction_resource_id
group by dbo.dmy(dbo.f(fecha_inicio))) as k on k.fecha=f.fecha
left join (
select dbo.dmy(dbo.f(fecha_inicio)) as fecha, sum(case when pseudoskill not  like  ('%fm_comercialm2%') or pseudoskill not like ('%fm_tecnico%') then 1 end) as desbordes
from interaction_det
where nombre_recurso in 
(select lastname+','+' '+firstname+' ('+NAME+')'
from roster_cm
where sk  like case when @combo2='comercial' then '%vag_comercial_fm%' when @combo2='tecnico' then '%vag_tecnico_fm%' end)
and pseudoskill not like (case @combo2 when 'tecnico' then 'fm_tecnico'  else 'fm_comercialm2'end)  +'%'
and dbo.dmy(dbo.f(fecha_inicio)) between dbo.pd(dateadd(month,0,getdate())) and  getdate() 
group by dbo.dmy(dbo.f(fecha_inicio))

) as j on j.fecha=f.fecha 

