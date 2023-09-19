SELECT DISTINCT c.swcaseid, dbo.dmy(c.swdatecreated) f_creado, dbo.dmy(c.swdateresolved) f_cerrado,
c.swstatus, C.motivo, c.submotivo, c.clasificacion, c.producto, c.obs, c.clasificacion, c.solucion
FROM INBOX I INNER JOIN ROSTER_BO R ON I.SWRECEIVER = R.INBOX 
INNER JOIN VW_CASOS_obs C ON C.SWCASEID = I.SWOBJECTID
WHERE SWDATERECEIVED between '01/07/2011' AND '01/08/2011' 
and SUP = 'DSOC'
and 
cctsolucionid in (
select cctclasificacionid from clasificacion where cctdescripcion in ('Cerrado Mal Derivado','Mal Ingresado Devueltos','Mal Ingresado Trabajado'))

