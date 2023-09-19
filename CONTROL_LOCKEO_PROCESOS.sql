

SELECT SO.NAME, S.*,V.*,U.*,X.*
from  
  master.dbo.spt_values v,  
  master.dbo.spt_values x,  
  master.dbo.spt_values u,  
master.dbo.syslockinfo S
INNER JOIN SYSOBJECTS SO ON S.RSC_OBJID = SO.ID
WHERE SO.NAME = 'ROSTER_CM'

 AND S.rsc_type = v.number  
   and v.type = 'LR'  
   and S.req_status = x.number  
   and x.type = 'LS'  
   and S.req_mode + 1 = u.number  
   and u.type = 'L'  

t roster_cm
SP_WHO2
sp_lock 
dbcc inputbuffer(72)
select * from sysobjects where id = 629577281

exec GENESYS..sp_get_pend_mail_agentes


select * from roster_cm where pcrc like '%posv%'
