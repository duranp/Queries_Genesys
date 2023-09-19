
select '"upn","alias","displayname"'
union all
select  '"' + dbo.splitindex(firstname,' ',0)+ ISNULL(left(dbo.splitindex(firstname,' ',1),1),'') + '.' + replace(lastname,' ','')+'@telefonicanegocios.com.ar",' + '"' + dbo.splitindex(lastname,' ',0)+ left(firstname,1)+'",'  +
'"' + lastname + ' ' + firstname + '"' 
from genesys..roster_cm where vag = 'vag_cc_lezicatop'


--COMPOSICION
	--UPN			NOMBRE + 1RA LETRA SEGUNDO NOMBRE + "." + apellido + "@TELEFONICANEGOCIOS.COM.AR"
	--ALIAS			APELLIDO + 1RA LETRA DEL PRIMER NOMBRE
	--DISPLAYNAME	APELLIDOS + " " + NOMBRES

--AMBIGUEDADES:
	--UPN: NOMBRE + 1RA LETRA SEGUNDO NOMBRE + 2DA LETRA DEL SEGUNDO NOMBRE (+3RA SI FUERA NECESARIO)+ "." + apellido + "@TELEFONICANEGOCIOS.COM.AR"
	--ALIAS			APELLIDO + 1RA LETRA DEL PRIMER NOMBRE + 2DA LETRA DEL PRIMER NOMBRE (+3RA SI FUERA NECESARIO)
	--DISPLAYNAME: VER.
	



select  
dbo.splitindex(firstname,' ',0)+ ISNULL(left(dbo.splitindex(firstname,' ',1),1),'') + '.' + replace(lastname,' ','')+'@telefonicanegocios.com.ar' UPN,
dbo.splitindex(lastname,' ',0)+ left(firstname,1) Alias,
lastname + ' ' + firstname displayname, name
from genesys..roster_cm where vag = 'vag_cc_lezicatop' and fc_baja is null
order by name



delete from  [10.105.8.249].cate.dbo.e_asistentecta
insert into [10.105.8.249].cate.dbo.e_asistentecta
SELECT cd_party, tx_asistente, mail FROM genesys..cartera c inner join TEMPDB..ASISTENTES_MAIL a on c.name = a.name

select * INTO ASITENTES_MAIL FROM TEMPDB..ASISTENTES_MAIL  

select  * from TEMPDB..ASISTENTES_MAIL  where name in (
select name from TEMPDB..ASISTENTES_MAIL group by name having sum(1) > 1)
order by name

