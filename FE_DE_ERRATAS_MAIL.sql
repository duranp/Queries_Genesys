

insert into e_envio_generico (tx_body, tx_mail, tx_titulo)  
select distinct '<img src=http://www.satisfaccion.speedy.com.ar/img/telefonia_negocios.png />'+
            '<div style=''font-family:calibri,arial,verdana;font-size:11pt;color:darkblue;line-height:25px; text-indent:20''>Estimado Sr ' + tx_razon_social + ',<br/>'+
             'Por un error de tipeo se ha incluido en el mail de presentación de su Asistente de Cuenta, una dirección de correo electrónico inválida. El mail correcto de Lourdes es <b>lourdes.martinez@telefonica.com</b>. Nuevamente, lo invitamos a contactarse con nosotros y le pedimos disculpas por las molestias ocasionadas.<br/><br/>'+
             '<p>En Telefónica Negocios buscamos mejorar día a día la Atención y Satisfacción de nuestros clientes. En esta oportunidad nos acercamos para recordarle que al ser seleccionado entre nuestros clientes más importantes, en el  <b>Centro de Atención a Clientes de Telefónica Negocios (0-800-333-9000)</b> hemos puesto a su disposición un <b>Asistente de Cuentas</b>, quien le prestará de manera <b>personalizada</b> todo el asesoramiento que usted necesita.</p>'+
             '<p>Su Asistente de Cuentas es <b>Lourdes Martinez Gauna </b> , cuyo horario laboral es de lunes a viernes de 9 a 16 hs. Lo podrá contactar vía e-mail a su casilla personal <b>lourdes.martinez@telefonica.com</b>, telefónicamente en forma gratuita al 0800-333-9000 (opción 2), y a partir de Mayo del corriente año desde su Movistar (sin cargo) al *9000.</p>'+
             '<p>Si lo necesita, puede contactarnos aún fuera de ese horario hasta las 19 hs los días hábiles. Será atendido por nuestros asesores exclusivos de Empresas y Pymes, quienes darán respuesta a su necesidad.</p>'+
             '<p><b>Lourdes</b> se encuentra a su disposición para responder a sus inquietudes y necesidades, como así también para canalizar consultas sobre sus facturas y trámites comerciales.</p>'+
		     '<p>En breve le estaremos comunicando quién es su referente por inconvenientes técnicos</p>'+
             '<p>Sin más, lo invitamos a contactarse con nosotros y lo saludamos cordialmente.</p>'+
             '<b><span style=''font-size:15pt''>Centro de Atención al Cliente<br/>Telefonia Negocios<br/>'+
             '0800-333-9000</b><br/></span><div>',tx_mail, 'Fe de Erratas - Una Atención diferente'  
from av_mails 
where tx_asistente like '%Lourdes Martinez%'
and tx_mail not in (select tx_mail from e_mails)

update e_asistentecta 
set mail = 'lourdes.martinez@telefonica.com'
where mail like '%lurd%'

update  e_asistentecta 
set mail = ' vanesa.testti@telefonica.com'
where mail like '%test%'


sp_get_vags
