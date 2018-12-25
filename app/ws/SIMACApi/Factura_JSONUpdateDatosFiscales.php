
<?php
include 'Factura_conn.php';
// error_reporting(0);
// ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

	$body = json_decode(file_get_contents("php://input"), true);


	$mRazonSocial = $body['mRazonSocial'];
 	$mRfc = $body['mRfc'];
 	$mDireccion = $body['mDireccion'];
 	$mCorreo = $body['mCorreo'];

	try {

		$cn = new Conexion();
	  $con = $cn->Conectar();

		$stmt = $con->prepare("DECLARE @exito bit;
exec [factura].[proc_add_updDirectorioFiscal]

		@exito output,
		@razonSocial = :mRazonSocial,
		@rfc = :mRfc,
		@calle = '',
		@noExterior = '',
		@noInterio = null,
		@colonia = '',
		@localidad = null,
		@referencia = :mReferencia,
		@municipio = '',
		@estado = '',
		@pais = '',
		@cp = '',
		@correo = :mCorreo,
		@idUsuario = null
	; select 'Exito' = @exito;");
		$stmt->bindParam(':mRazonSocial',$mRazonSocial);
		$stmt->bindParam(':mRfc',$mRfc);
		$stmt->bindParam(':mReferencia',$mDireccion);
		$stmt->bindParam(':mCorreo',$mCorreo);
		$stmt->execute();
		$addCfdiResult = $stmt->fetchAll();
		$exito = $addCfdiResult[0]['Exito'];

		if ($exito>0) {
			echo '{"exito":"1"}';
		}else {
			echo '{"exito":"0"}';
		}


		$cn->Desconectar($con, $stmt);



	} catch (PDOException $e) {
		error(1,'Error: ' . $e->getMessage());
		echo '{"exito":"2"}';
    }
}


function error($numero,$texto){
$ddf = fopen('Error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}

function multiexplode ($delimiters,$string) {
    $ready = str_replace($delimiters, $delimiters[0], $string);
    $launch = explode($delimiters[0], $ready);
    return  $launch;
}

?>
