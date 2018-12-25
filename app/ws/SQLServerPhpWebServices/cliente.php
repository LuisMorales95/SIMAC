<?PHP
function microtime_float()
{
    list($useg, $seg) = explode(" ", microtime());
    return ((float) $useg + (float) $seg);
}

//deshabilitar cache
ini_set("soap.wsdl_cache_enabled", "0");

if ((!empty($_FILES['filFile'])) && ($_FILES['filFile']['error'] == 0)) {
    $tiempo_inicio = microtime_float();
    try {
        //iniciar cliente soap
        //escribir la dirección donde se encuentra el serviciO
        //$client = new SoapClient("https://www.csfacturacion.com/webservices/csplug/?wsdl");
        $client = new SoapClient("https://www.csfacturacion.com/webservices/csplug/timbrarcfdi.php?wsdl");

        //llamar a la función para consultar usuarios y guardar el resultado
        //$archivo = (base64_encode(file_get_contents($_FILES['filFile']['tmp_name'])));
        $archivo = (file_get_contents($_FILES['filFile']['tmp_name']));
        $result  = $client->__SoapCall("Uploadarchivo", array('Password' => 'SysConroe2015', 'Archivo' => $archivo));
        //$result = $client -> __SoapCall("Uploadarchivo", array('Password' => 'Despegar.1', 'Archivo' => $archivo));
        //$result = $client -> __SoapCall("Cancelarfactura", array('Archivo' => $archivo));

        //print_r($result);
        //VARIABLES QUE RETORNA EL WEBSERVICES
        //$result -> Msj   MENSAJE DE LA TRANSACCIÓN
        //$result -> XML   ARCHIVO XML EN BASE64
        //$result -> PDF64 ARCHIVO PDF EN BASE64

        //echo "PDF64: ".$result -> PDF."<br/><br/>";
        // echo "QR: " . $result->Msj . "<br/><br/>";
        // echo "XML devuelto: " . $result->XML . "<br/><br/>";

        echo "RESUMEN: " . $result-> RESUMEN . "<br/><br/>";
        echo "resumen ____________________________________________________";
        //echo "QR: " . $result-> QR . "<br/><br/>";
        //echo "Mensaje: ".$result -> Msj."<br/><br/>";
        //echo "PDF64: ".$result -> PDF64."<br/><br/>";
        echo "intermedio ____________________________________________________";
        //echo "PDF: ".$result -> PDF."<br/><br/>";
        // echo "codigo qr: ".$result -> QR."<br/><br/>";

        //

    } catch (SoapFault $e) {
        echo "Ups!! hubo un problema y no pudimos recuperar los datos.<br/>
               $e<hr/>";
    }

    $tiempo_fin = microtime_float();
    $tiempo     = $tiempo_fin - $tiempo_inicio;

    echo "Tiempo empleado: " . ($tiempo_fin - $tiempo_inicio);
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
<script type="text/javascript">
            function descargar(cExt, cCadena){
                document.getElementById('hidExt').value = cExt;
                document.getElementById('hidCadena').value = cCadena;
                document.getElementById('frmPrincipal').action = "descargar.php";
                document.getElementById('frmPrincipal').submit();

            }

        </script>
</head>

<body>
    <form name="frmPrincipal" id="frmPrincipal" method="post" action="<?PHP $PHP_SELF?>" enctype="multipart/form-data">
        <input type="hidden" name="hidMovimiento" id="hidMovimiento" value="1"  />
        <input type="hidden" name="hidCadena" id="hidCadena" />
        <input type="hidden" name="hidNamefile" id="hidNamefile" value="ejemplo"/>
        <input type="hidden" name="hidExt" id="hidExt" >

        <input type="file" name="filFile" id="filFile" tabindex="9" style="width:95%" />

        <input type="submit" value="GUARDAR" tabindex="8" />
          <?php
                            $cadena_de_texto       = $result->Msj;
                            $cadena_buscada        = "Factura timbrada correctamente";
                            $posicion_coincidencia = strpos($cadena_de_texto, $cadena_buscada);

                            $cadena_buscada2        = "Previsualizacion correcta";
                            $posicion_coincidencia2 = strpos($cadena_de_texto, $cadena_buscada2);

                            //se puede hacer la comparacion con 'false' o 'true' y los comparadores '===' o '!=='

                            if ($posicion_coincidencia === false) {?>

                                No se pudo facturar favor de intentarlo nuevamente <?PHP echo $result->Msj ?><br />

                                <?php } else {?>

                                <?php echo $result->Msj ?> para la razón social

                                Se proceso correctamente<br />

                                <a onClick="descargar('xml', '<?PHP echo $result->XML64 ?>')"><img src="img/1406587535_z_File__XML.png" /></a>

                                <a onClick="descargar('pdf', '<?PHP echo $result->PDF64 ?>')"><img src="img/1406587786_pdf.png" /></a>

                                <br />

                                <p>
                                    <a href="clienteCFDI33.php.php" class="btn btn-large btn-success">Salir</a>
                                </p>

                           <?php
                            }

                           if ($posicion_coincidencia2 === false) {?>

                                No se pudo facturar favor de intentarlo nuevamente <?PHP echo $result->Msj ?><br />
                           <?PHP } else {?>
                          <?PHP echo $result->Msj ?> para la razón social
                            Se proceso correctamente<br />
                                <a onClick="descargar('xml', '<?PHP echo $result->XML64 ?>')"><img src="img/1406587535_z_File__XML.png" /></a>
                                <a onClick="descargar('pdf', '<?PHP echo $result->PDF64 ?>')"><img src="img/1406587786_pdf.png" /></a>
                                <br />
                                <p><a href="clienteCFDI33.php.php" class="btn btn-large btn-success">Salir</a></p>

                           <?PHP }

?>

    </form>
</body>
</html>