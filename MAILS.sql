
select distinct n.cd_party, n.tx_Mail, 'si' enviado,
case when e.id_enviado is null then 'no' else 'si' end contesto, 
case when r.tx_Mail is null then 'no' else 'si' end rebote
into #env
from e_enviados n 
	 left join e_encuestas e on n.id_enviado = e.id_enviado
	 left join e_mails r on n.tx_mail = r.tx_mail
where cd_party is not null

select tasa_clie_codigo, c.swemailaddress tx_mail,
case when n.id_enviado is null then 'no' else 'si' end enviado,
case when e.id_enviado is null then 'no' else 'si' end contesto, 
case when r.tx_Mail is null then 'no' else 'si' end rebote
into #no_env
from [10.249.28.80].vtv.dbo.contacto c
	left join e_enviados n on c.swemailaddress = n.tx_mail collate database_default 
	left join e_encuestas e on n.id_enviado = e.id_enviado
	left join e_mails r on n.tx_mail = r.tx_mail


select * from #no_env where tx_mail not in (select tx_mail collate database_default from #env)

select sum(1), count(distinct tx_mail) from #env
select * from #env union all select * from #no_env

select distinct n.cd_party, n.tx_mail,
case when n.tx_mail in (select tx_mail from #env e1 where e1.tx_mail = n.tx_mail and enviado = 'si') 
	and n.tx_Mail not in (select tx_mail from #env e1 where e1.tx_mail = n.tx_mail and enviado = 'si') 
	then 1 else 0 end env
from e_enviados n 

drop table #mail
select distinct cd_Party, tx_Mail, cast(null as varchar(10)) estado into #mail from e_enviados
insert into #mail select distinct tasa_clie_codigo, swemailaddress, cast(null as varchar(10)) estado  from  [10.249.28.80].vtv.dbo.contacto
select distinct * into #final from #mail


update #final set estado = 'enviado' where tx_mail in (select tx_Mail from e_enviados)
update #final set estado = 'contestado' where tx_mail in (select tx_Mail from e_enviados e1 inner join e_encuestas e2 on e1.id_enviado = e2.id_enviado)
update #final set estado = 'rebotado' where tx_mail in (select tx_mail from e_mails)
select * from #final where estado is null

select sum(1), estado from #final group by estado







select * from e_enviados where timestamp >= '01/04/2011'
and tx_mail in (select tx_MAIL FROM e_mails)

SELECT * FROM BCP_INBOX