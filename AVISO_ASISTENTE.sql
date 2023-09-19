sp_helptext sp_get_av           
  
CREATE procedure sp_get_av           
as          
select top 200 * from av_mails where fc_enviado is null 


select * from #av where tx_asistente like '%valenz%'
select * from av_mails where tx_asistente like '%valen%'
--TRAIGO TEMPORAL CON EL EXCEL 
select * into #av from  [10.249.28.80].tempdb.dbo.mails_av
select * from av_mails where tx_mail not in (select swemailaddress from 

insert into av_mails
--VTV
select party, decirle, tx_asistente, m.tx_mail tx_mail_asistente, tx_nombre_asistente, tx_razon_social, CAST(null AS SMALLDATETIME),  swemailaddress tx_mail
 from #av m 
	inner join cate..contacto c on m.party = tasa_clie_codigo
where swemailaddress not in (select tx_mail from e_mails)
--IC
union all
select party, decirle, tx_asistente, m.tx_mail tx_mail_asistente, tx_nombre_asistente, tx_razon_social, CAST(null AS SMALLDATETIME),  b.tx_mail tx_mail
 from #av m 
	inner join cate..e_baseic b on m.party = b.cliente
and b.tx_mail not in (select tx_mail from e_mails)


select * from dt_tipo_cliente where cd_tipo_cliente in('0R', '0I')
select * from av_mails

select * from [10.249.28.80].tempdb.dbo.asistcta

select sum(1) from av_mails where fc_enviado is not null


select 57264 - 17635 no 39629 si

select 39.6/57.2

select distinct party from #av where party not in (select party from cate..av_mails)
select distinct party from cate..av_mails where tx_mail not in (select tx_mail from cate..e_mails)





