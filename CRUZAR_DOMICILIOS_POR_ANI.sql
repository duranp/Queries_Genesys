
 select * into #t from OPENQUERY(dw,'
select distinct
 trim(cd_interurbano)||trim(cd_urbano)||cd_linea ani,d.*
from
 tasa.producto_instancia pi
inner join
 tasa.service_number sn
 on pi.cd_producto_instancia = sn.cd_producto_instancia
inner join
 tasa.producto p
 on pi.cd_producto = p.cd_producto
inner join
 tasa.domicilio d
 on pi.cd_localizacion = d.cd_localizacion
left join
 tasa.party pa
 on pi.cd_party_titular = pa.cd_party and pa.fc_baja is null
where
 pi.cd_producto_instancia like ''021%''
 and pi.cd_estado_instancia <> ''BA''
 and p.cd_tipo_telefonia = ''1''
 and sn.fc_final is null
 and pi.fc_baja is null')

select * into #loc from OPENQUERY(dw,'select cd_geografia, tx_geografia from tasa.geografia where cd_tipo_geografia = ''LO''')

select * from tempdb..negocios n left join #t t on n.ani = t.ani left join #loc l on l.cd_geografia = t.cd_localidad
