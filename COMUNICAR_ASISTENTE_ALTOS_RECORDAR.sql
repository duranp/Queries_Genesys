--select * from borrar_comunicados

--INSERTA LOS CLIENTES CANDIDATOS A ENVIARSE truncate table borrar_comunicados 
INSERT INTO borrar_comunicados 
--select name,sum(1) from (
	select top 100 percent  CD_PARTY, TX_ASISTENTE, CD_TRIADA, NAME, cast(null as datetime)fecha  from cartera 
	WHERE CD_PARTY NOT IN (SELECT CD_PARTY FROM borrar_comunicados)	and  
	name  in (
'UNE369',
'UNE342',
'UNE425',
'UNE414',
'UNE376',
'UNE119',
'UNE435',
'UNE413',
'UNE969') order by newid()
--)x group by name


--GENERA LOS MAILS A LOS CLIENTES CANDIDATOS
insert into [10.105.8.249].cate.dbo.e_envio_generico (tx_mail, tx_body, tx_titulo)
	select distinct SWEMAILADDRESS,
	'<div style="font-family:calibri;font-size:11pt;color:darkblue;line-height:25px; text-indent:20">Estimado '+ tx_party + ',<br/>' +
	'<p>En Telef�nica Negocios buscamos mejorar d�a a d�a la Atenci�n y Satisfacci�n de nuestros clientes. En esta oportunidad nos acercamos para recordarle que al ser seleccionado entre nuestros clientes m�s importantes, en el <b>Centro de Atenci�n a Clientes</b> hemos puesto a su disposici�n un <b>Asistente de Cuentas</b>, quien le prestar� de manera <b>personalizada</b> todo el asesoramiento que usted necesita.</p>'+
	'<p>Su Asistente de Cuentas es ' + upper(firstname + ' ' +lastname) + ', quien se encuentra a su disposici�n para responder inquietudes y necesidades, como as� tambi�n para canalizar consultas sobre sus facturas y tr�mites comerciales.</p>'+
	'<p>Adicionalmente, le informamos que para mejorar el seguimiento de los contactos v�a email, hemos migrado a una nueva herramienta que nos permitir� agilizar las respuestas y brindarle una gesti�n integral a sus solicitudes. Por lo expuesto, a partir de hoy, podr� contactar a su Asistente Personal ' + upper(firstname + ' ' +lastname)+ ', a su nueva casilla e-mail <a href="mailto:'+ tx_mail +'">'+ tx_mail +'</a></p>'+
	'<p>Aprovechamos para recordarle que Ud. cuenta tambi�n con un Equipo T�cnico especializado, a quien podr� contactar ante un eventual inconveniente en sus servicios, a trav�s de la casilla <A HREF="AtenciontecnicaTNegocios.ar@telefonica.com">AtenciontecnicaTNegocios.ar@telefonica.com</A> </p>'+
	'<p>Sin mas, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</p><br/>'+

	'<span style="font-size:15pt"><b>Centro de Atenci�n al Cliente<br/>Telefonica Negocios</b><br/></span><div>',
	'Una Atenci�n diferente'
	from  cartera u inner join dw..party p on u.cd_party = p.cd_party inner join roster_cm r on r.name = u.name
	INNER JOIN VTV..CONTACTO C ON P.CD_PARTY = C.TASA_CLIE_CODIGO
	WHERE P.CD_PARTY IN (
		SELECT CD_PARTY FROM borrar_comunicados WHERE FECHA IS NULL)

--MARCA LOS CANDIDATOS COMO ENVIADOS PARA NO VOLVER A ENVIAR
UPDATE borrar_comunicados SET FECHA = GETDATE() WHERE FECHA IS NULL



--	select sum(1)  from cartera 
--	WHERE CD_PARTY NOT IN (SELECT CD_PARTY FROM borrar_comunicados)	and  
--	name  in (
--'UNE369',
--'UNE342',
--'UNE425',
--'UNE414',
--'UNE376',
--'UNE119',
--'UNE435',
--'UNE413',
--'UNE969') group by name
