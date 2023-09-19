
select sum(1), tx_tipo_cliente, count(distinct cd_party) 
from #c c 
	inner join dw..party p on c.tasa_clie_codigo = p.cd_party 
	inner join dt_tipo_cliente t on p.cd_tipo_cliente = t.cd_tipo_cliente
where swemailaddress not in (select tx_mail collate database_default from [10.105.8.249].cate.dbo.e_mails)
and swdatecreated < '01/04/2011'
group by tx_tipo_cliente

select sum(1), tx_tipo_cliente   from contacto c
	inner join dw..party p on c.tasa_clie_codigo = p.cd_party 
	inner join dt_tipo_cliente t on p.cd_tipo_cliente = t.cd_tipo_cliente
group by tx_tipo_cliente


drop table #c
select * into #c from contacto
where swdatecreated >= '01/04/2011'

group by year(swdatecreated), month(swdatecreated)
order by year(swdatecreated), month(swdatecreated)

select * from contacto

drop table #t

select * 
into #t
from (
	SELECT cd_party, sum(1)q, [VALOR_IN], abierto, case when (TX_TIPO_CLIENTE  LIKE 'ALTO%' or TX_tipo_cliente like 'top%') then 1 else 0 end altos
	FROM [10.105.8.249].vantive.dbo.incasoshist i 
	inner join dw..PARTY p on i.[VALOR_IN] = p.cd_party
	INNER JOIN DT_TIPO_CLIENTE T ON P.CD_TIPO_CLIENTE = T.CD_TIPO_CLIENTE
	where apellido = 'insatisfechos' 
	and month(abierto) = 6
	group by cd_party, [VALOR_IN], abierto, case when (TX_TIPO_CLIENTE  LIKE 'ALTO%' or TX_tipo_cliente like 'top%') then 1 else 0 end 
	) x

select *, (select sum(1) from genesys..interaction_his ll 
			inner join pseudoskill p on REPLACE(dbo.splitindex(ll.pseudoskill,'|',0),'_apy','') = p.pseudoskill       and atencion = 'com'
			inner join dw..parque p2 on ll.gvp_postdiscado = p2.ani where tipo_interaction = 'inbound' and cd_party_titular= x.cd_party and fecha between x.abierto and dateadd(month,1,x.abierto)) llamadas 
from #t x
	

select cd_party_titular, fecha from genesys..interaction_his i inner join dw..parque p on i.gvp_postdiscado = p.ani 
where tipo_interaction = 'inbound'
and cd_party_titular = 11198872 and fecha between '01/06/2011 15:03:14.153' and '01/07/2011 15:03:14.153'

