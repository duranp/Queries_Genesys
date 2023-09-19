/*
ALTER procedure sp_get_av     
as    
select top 20 * from av_mails where fc_enviado is null 
*/

select * into #c from [10.249.28.80].vtv.dbo.clientes 
drop table av_mails_tot

--contactos vantive
select * into av_mails_tot 
from (SELECT DISTINCT 
                      a.party, a.decirle, a.tx_asistente, a.tx_mail_asistente, a.tx_nombre_asistente, a.tx_razon_social, a.fc_enviado, 
                      co.SWEMAILADDRESS AS tx_mail
FROM         av_mails AS a INNER JOIN
                      [#c] AS cl ON a.party = cl.tasa_clie_codigo INNER JOIN
                      contacto AS co ON cl.swcustomerid = co.SWCUSTOMERID AND co.SWTYPE IN ('Responsable de Comunicaciones', 'Call Center', 
                      'Responsable de Sistemas', 'directivo')
WHERE     (co.SWEMAILADDRESS NOT IN
                          (SELECT     tx_mail
                            FROM          e_mails)))a

--select * from av_mails_tot
--base IC
insert into av_mails_tot select * from 
	(SELECT DISTINCT 
						  a.party, a.decirle, a.tx_asistente, a.tx_mail_asistente, a.tx_nombre_asistente, a.tx_razon_social, a.fc_enviado, i.tx_mail
	FROM         av_mails AS a INNER JOIN
						  e_baseic i on a.party = i.cliente
	WHERE     (i.tx_mail NOT IN
							  (SELECT     tx_mail
								FROM          e_mails))
	AND party not in (select party from av_MAILS_TOT))xx


--select * from av_mails_bkp
truncate table av_mails_bkp

insert into av_mails_bkp select * from av_mails
truncate table av_mails
insert into av_mails select * from av_mails_tot where party not in (select party from av_mails_bkp)

select  SUM(1) from av_mails WHERE FC_ENVIADO IS NOT NULL

select  SUM(1) from av_mails WHERE FC_ENVIADO IS NOT NULL
AND TX_MAIL IN (SELECT TX_MAIL FROM E_MAILS)

select * from visualizador..bcp_parque_tb_sp

sp_get_agentes





