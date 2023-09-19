
select * from tempdb..cuits_moviles where ANI > cast (0 as bigint) and CUIT > cast (0 as bigint)

SELECT * FROM 

select * into cuit from openquery(dw,'select cd_party - 20000000000 cd_party, nu_documento from tasa.documento_party p where cd_tipo_documento in (''08'')')

SELECT DISTINCT CUIT, ANI 
FROM tempdb..cuits_moviles M 
	INNER JOIN CUIT F ON M.CUIT = F.NU_DOCUMENTO
    INNER JOIN DW..PARTY P ON F.CD_PARTY = P.CD_PARTY AND P.CD_TIPO_CLIENTE IN ('06','0G','0I','0J','0R')
	INNER JOIN VTV..CLIENTES CL ON P.CD_PARTY = CL.TASA_CLIE_CODIGO
	INNER JOIN VTV..CASOS CA ON CL.SWCUSTOMERID = CA.SWCUSTOMERID AND CCTPRODUCTOID = 65819 AND CCTMOTIVOID = 7 
WHERE ANI > cast (0 as bigint) and CUIT > cast (0 as bigint)    

    SELECT TOP 10 * FROM DW..PARTY
SELECT * FROM VTV..CASOS CA INNER JOIN VTV..CLIENTES CU ON CA.SWCUSTOMERID = CU.SWCUSTOMERID AND CCTPRODUCTOID = 65819 AND CCTMOTIVOID = 7


SELECT TOP 10 * FROM VTV..CLIENTES WHERE CCTDESCRIPCION = 'VENTAS'




SELECT TOP 10 * FROM CUIT