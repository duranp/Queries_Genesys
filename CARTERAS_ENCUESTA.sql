

select DISTINCT R.* from e_asistentecta a 
	right join #c c on a.asistente collate database_default= c.tx_asistente and a.cd_cliente = c.cd_party
	INNER JOIN #R R ON C.NAME = R.NAME
where a.asistente is null

SELECT * INTO e_asistentecta_BKP2 FROM e_asistentecta 
INSERT INTO e_asistentecta (CD_CLIENTE,ASISTENTE, MAIL)
SELECT CD_PARTY, TX_ASISTENTE, MAIL FROM [10.249.28.80].TEMPDB.dbo.CARTERAS_TOP_20120706

SELECT * FROM v_pi

select cd_party, sum(1) from #c group by cd_party having sum(1) =1

select * into #r from [10.249.28.80].genesys.dbo.roster_cm

S SP_SAVE_ENCUESTA

ALTER PROCEDURE SP_SAVE_ENCUESTA3 (@ip varchar(80), @HASH VARCHAR(36),@P1 BIGINT,@P2 BIGINT,@P3 BIGINT,@P4 BIGINT,@P5 BIGINT,@P6 BIGINT,@P7 BIGINT,@P8 BIGINT,@P9 BIGINT,@P10 BIGINT,@P11 BIGINT,@TX_OBS VARCHAR(8000))    
AS    
SET NOCOUNT ON    
if (not exists(select tx_hash from e_encuestas e inner join e_enviados en on e.id_enviado = en.id_enviado where tx_hash = @hash))    
begin    
 DECLARE @ID_ENVIADO BIGINT, @id_encuesta bigint, @TX_MAIL VARCHAR(200), @CD_PARTY BIGINT, @TX_PARTY VARCHAR(300), @TX_MAIL_CLIENTE VARCHAR(200), @TX_BODY VARCHAR(8000)
 SELECT @ID_ENVIADO=ID_ENVIADO, @TX_MAIL = MAIL, @TX_MAIL_CLIENTE = TX_MAIL, @CD_PARTY = E.CD_PARTY--, @TX_PARTY = P.TX_PARTY  
 FROM E_ENVIADOS E 
 	LEFT JOIN E_ASISTENTECTA A ON E.CD_PARTY = A.CD_CLIENTE 
 WHERE TX_HASH = @HASH    
		
 INSERT INTO E_ENCUESTAS (    
  ip, ID_ENVIADO,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11, TX_OBS    
  ) VALUES (@ip, @ID_ENVIADO,@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11,@TX_OBS)    

 IF @P11 = 0  
	set @TX_BODY = 'El cliente ' + CAST(isnull(@cd_party,'') AS VARCHAR(20)) +  ' con mail: <b><a href="mailto:'+ @tx_mail_cliente + '">'+ @tx_mail_cliente +'</a></b> a marcado que no conoce a su asistente de cuenta en la encuesta postllamado. <br>Por favor tenga a bien gestionarlo.<br> Gracias'
	INSERT INTO E_ENVIO_GENERICO (TX_MAIL,TX_TITULO,TX_BODY) VALUES(@TX_MAIL, 'Asistente desconocido',@tx_body)
end 

select * from e_enviados e LEFT JOIN E_ASISTENTECTA A ON E.CD_PARTY = A.CD_CLIENTE where timestamp < '10/01/2012' and asistente like '%valenzu%'
and id_enviado not in (select id_enviado from e_encuestas)
SELECT * FROM E_ENVIADOS WHERE CD_PARTY = 999999999

DELETE FROM E_ENCUESTAS WHERE ID_ENVIADO = 627201

SP_SAVE_ENCUESTA3 NULL,'AE9CBB31-960F-401A-87F7-028A445EBE14',0,0,0,0,0,0,0,0,0,0,0,'PRUEBA CARTERIZACION'

SELECT * FROM E_ENVIO_GENERICO WHERE FC_ENVIADO IS NULL ORDER BY ID_ENVIO DESC
SELECT * FROM SYSOBJECTS WHERE NAME LIKE '%GENER%'

UPDATE E
SET ERROR = NULL 
FROM
E_ENVIO_GENERICO E WHERE ID_ENVIO > (
SELECT MIN(ID_ENVIO) FROM E_ENVIO_GENERICO WHERE DBO.DMY(FC_ENVIADO) = DBO.DMY(GETDATE()))
AND ERROR = 1
S SP_GET_ENV_GENERICO


insert into e_asistentecta values (999999999,'PRUEBA MANGO','MANGUICHO@GMAIL.COM')

insert into e_enviados 
(CD_PARTY, ANI, TIMESTAMP, TX_USUARIO, CD_CASO, TX_HASH, TX_MAIL, TX_CELULAR, TS_ENVIO) 
	values
(999999999,1199999999,getdate(),'coso',9999999,'AE9CBB31-960F-401A-87F7-028A445EBE14', 'sebastian.mangisch@telefonica.com',null,null)

select * from e_enviados where cd_party = 999999999
select * from e_enviados



select newid()

 DECLARE @ID_ENVIADO BIGINT
SELECT @ID_ENVIADO=ID_ENVIADO,@TX_MAIL = MAIL   FROM E_ENVIADOS E LEFT JOIN E_ASISTENTECTA A ON E.CD_PARTY = A.CD_CLIENTE WHERE ID_ENVIADO = 108
PRINT @TX_MAIL
select * from e_asistentecta a inner join [10.249.28.80].dw.dbo.party p on a.cd_cliente = p.cd_party

use cate
select * from E_ENCUESTAS WHERE TIMESTAMP >= '01/06/2012' AND P11 IS NOT NULL