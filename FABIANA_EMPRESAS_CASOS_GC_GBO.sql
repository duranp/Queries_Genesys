use vtv

select 
SWCASEID, c.SWCREATEDBY, SWDATECREATED, SWDATERESOLVED, SWSTATUS, CCTCERRADOPOR, CCTTELEFONORECLAMO, FCR2, FCR7, FCRI2, FCRI7, 
FCR_BO7, motivo, submotivo, clasificacion, solucion, producto, tx_tipo_cliente, TASA_CLIE_CODIGO, dbo.concatenate(swreceiver) gc_gbo
into #t
from vw_casos c inner join inbox i on c.swcaseid = i.swobjectid
where swreceiver collate modern_spanish_cs_as in (
	select  swdefaultinbox collate modern_spanish_cs_as from sw_user where swdefaultinbox like 'GC_GBO%')
and swdateresolved between '01/06/2012' and '31/12/2012'
group by
SWCASEID, c.SWCREATEDBY, SWDATECREATED, SWDATERESOLVED, SWSTATUS, CCTCERRADOPOR, CCTTELEFONORECLAMO, FCR2, FCR7, FCRI2, FCRI7, 
FCR_BO7, motivo, submotivo, clasificacion, solucion, producto, tx_tipo_cliente, TASA_CLIE_CODIGO


select max(swdatereceived)fecha, swobjectid 
into #f
from inbox 
where 
swreceiver collate modern_spanish_cs_as in (
	select  swdefaultinbox collate modern_spanish_cs_as from sw_user where swdefaultinbox like 'GC_GBO%')
and swdatereceived >= '01/06/2012'
group by swobjectid

drop table #U
select distinct swreceiver, swobjectid, swdatereceived, swdateactiontaken
into #u
from inbox i where
swdateactiontaken= (select max(swdateactiontaken) from inbox where swobjectid = i.swobjectid)
and swdatereceived >= '01/06/2012'
and swreceiver collate modern_spanish_cs_as in (
	select  swdefaultinbox collate modern_spanish_cs_as from sw_user where swdefaultinbox like 'GC_GBO%')

select * from vw_casos c inner join #u u on c.swcaseid = u.swobjectid
and swstatus = 'cerrado'
order by swcaseid
select * from #u

d
select * from inbox where swobjectid = 16977947
