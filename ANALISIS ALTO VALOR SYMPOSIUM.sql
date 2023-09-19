select ani into #t from llamadas where aplicacion1 in (select aplicacion from campaña_apli where grupo = 'alto valor') and fecha between '04/04/2011' and '05/04/2011'
and isnumeric(ani) = 1
select sum(1), tx_tipo_cliente from #t t inner join posventa..parque_basica p on t.ani = p.ani inner join posventa..# tc on p.cd_Tipo_cliente = tc.cd_Tipo_cliente
group by tx_tipo_cliente
select min(timestamp) from callbycall_bkp

select * from sysobjects where xtype = 'u'

select * from interaction_his where gvp_ani_postdiscado


