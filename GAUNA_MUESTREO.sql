SELECT    distinct  'leidos'tipo, cte_cota, ani, razon_social, vto_actual, dbo.dmy(gestionado)
FROM         e_baseenvdeuda_hist
WHERE     (tx_mail IN
                          (SELECT     tx_mail
                            FROM          e_leidos))
and gestionado is not null
and gestionado >= '01/08/2011'
union all
SELECT    distinct 'no leidos' tipo,  cte_cota, ani, razon_social, vto_actual, dbo.dmy(gestionado)
FROM         e_baseenvdeuda_hist
where cte_cota in (
	select cte_cota from e_baseenvdeuda_hist
	WHERE     (tx_mail not IN
							  (SELECT     tx_mail
								FROM          e_leidos))
	and  (tx_mail IN
							  (SELECT     tx_mail
								FROM          e_mails))
	and gestionado is not null
)
and gestionado is not null
and gestionado >= '01/08/2011'
