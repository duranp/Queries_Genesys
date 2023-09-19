CREATE PROCEDURE SP_MARCO_QUEJAS
AS
update [Vantive].[dbo].[InCasos] set clasificacion = 'queja encuesta' where id = 14505
INSERT INTO [Vantive].[dbo].[InCasos] 
([tipo_gest]
           ,[Nombre]           ,[Apellido]
           ,[email]           ,[Estado]
           ,[tipo_cont]           ,[tipo_in]
           ,[valor_in]           ,[nro_caso]
           ,[ANI]           ,[fprod]
           ,[Motivo]           ,[Submotivo]
           ,[Clasificacion]           
           ,[Observaciones]           ,[user_origen]
           ,[id_legacy_origen]           ,[legacy_origen]
           ,[dispach])
SELECT  'CASO','MACRO','quejas',e.TX_MAIL, 'Abierto','call center', 'Cliente',e.cd_party,null, c.ccttelefonoreclamo, C.PRODUCTO, 
'QUEJAS',q.tx_clasificacion,'Encuesta Queja', '[caso orig: ' + CAST(e.cd_caso AS VARCHAR(12))+'],[fecha queja: ]'+ cast(q.timestamp as varchar(20)) + '] [obs:]' + Q.TX_DESCRIPCION,
e.tx_usuario, q.ID_QUEJA,'QUEJAS','DEV_BO_NC'
FROM CATE..E_QUEJAS q 
	inner join cate..e_enviados e on q.hash = e.tx_hash 
	inner join [10.249.28.80].vtv.dbo.VW_casos c on e.cd_caso = c.swcaseid
WHERE Q.bl_macro IS NULL


UPDATE q
SET BL_MACRO = 1
FROM CATE..E_QUEJAS Q 
	INNER JOIN [Vantive].[dbo].[InCasos] I ON Q.ID_QUEJA = I.ID_LEGACY_ORIGEN AND apellido = 'quejas'
	where bl_macro is null
	
	
 
 
 
 