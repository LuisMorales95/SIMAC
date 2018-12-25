
<?php
include 'Factura_conn.php';
libxml_use_internal_errors(true);
error_reporting(0);
ini_set('display_errors', 0);
ini_set("soap.wsdl_cache_enabled", "0");

if($_SERVER['REQUEST_METHOD'] == 'POST') {

	$body = json_decode(file_get_contents("php://input"), true);

	$trace = true;
	$exceptions = false;
	// TODO: Parameters needed
	$mBill = $body['mBill'];
 	$Password = $body['Password'];
 	$File_64 = $body['File64'];
 	$File_Name = $body['file_name'];

	try {

		$cn = new Conexion();
	  $con = $cn->Conectar();

		$TXTFactura = 'C:/inetpub/wwwroot/aguadulce.gob.mx/Factura/pathFE/in/'.$File_Name.".txt";
		$handle = fopen($TXTFactura, 'w') or die('Cannot open file:  '.$TXTFactura);
		$data = base64_decode($File_64);
		fwrite($handle, $data);
		$archivo = (file_get_contents($TXTFactura,true));
		$exploded = multiexplode(array("|","\n"),$archivo);
		// print_r($exploded);

		// TODO: Create SOAP client
		// TODO: Set parameters that SOAP WSDL requires
		$client = new SoapClient('https://www.csfacturacion.com/webservices/csplug/timbrarcfdi.php?wsdl');
		$result  = $client->__SoapCall("Uploadarchivo", array('Password' => 'MunAgua17', 'Archivo' => $archivo));

		// TODO: Generate PDF file
		// TODO: Generate XML file
		// TODO: Generate TXT file
		$PDFfile = 'C:/inetpub/wwwroot/aguadulce.gob.mx/Factura/pathFE/out/'.$File_Name.".pdf";
	  $handle = fopen($PDFfile, 'w') or die('Cannot open file:  '.$PDFfile);
	  $data = base64_decode($result->PDF64);
	  fwrite($handle, $data);
		$XMLfile = 'C:/inetpub/wwwroot/aguadulce.gob.mx/Factura/pathFE/out/'.$File_Name.".xml";
	  $handle = fopen($XMLfile, 'w') or die('Cannot open file:  '.$XMLfile);
	  $data = base64_decode($result->XML64);
	  fwrite($handle, $data);
		$TXTfile = 'C:/inetpub/wwwroot/aguadulce.gob.mx/Factura/pathFE/out/'.$File_Name.".txt";
		$handle = fopen($TXTfile, 'w') or die('Cannot open file:  '.$TXTfile);
		fwrite($handle, $result->RESUMEN);
if (strpos($string, 'Factura timbrada correctamente') !== false) {
		// $xml = simplexml_load_string($result->XML) or die("Error: Cannot create object");
		$archivotxt = (file_get_contents($TXTfile,true));
		$explodedtxt = multiexplode(array("|","\n"),$archivotxt);

		$mVersionCfdi = "3.3";
		$mIvaSet = (float)"0.00";
		$mLugar = "AGUA DULCE, VERACRUZ";
		$null = "null";
		$mConstant = "1";
		$mSerie = $exploded[4];
		$mTipoComprobante = "INGRESO";
		$mRfcEmisor = $exploded[34];
		$mRfcReceptor = $exploded[43];
		$mSubtotal = (float)$exploded[14];
		$mDescuento = (float)$exploded[16];
		$mTotal = (float)$exploded[22];
		$mReferencia = $exploded[6];
		$stmt = $con->prepare("DECLARE @idCfdi bigint; exec [GSIREM007].factura.proc_addCfdi_Factura @idCfdi output, :mSerie, '', '', :mVersionCfdi, :mTipoComprobante, :mSubtotal, :mDescuento, :mTotal,
		:mRfcEmisor, :mRfcReceptor, :mIvaRet, :mReferencia, :mPathXml, :mPathPdf, :mLugar, :mMotivoDesc, :mEstatus; select 'IdCfdi' = @idCfdi;");
		$stmt->bindParam(':mSerie',$mSerie);
		$stmt->bindParam(':mVersionCfdi',$mVersionCfdi);
		$stmt->bindParam(':mTipoComprobante',$mTipoComprobante);
		$stmt->bindParam(':mSubtotal',$mSubtotal);
		$stmt->bindParam(':mDescuento',$mDescuento);
		$stmt->bindParam(':mTotal',$mTotal);
		$stmt->bindParam(':mRfcEmisor',$mRfcEmisor);
		$stmt->bindParam(':mRfcReceptor',$mRfcReceptor);
		$stmt->bindParam(':mIvaRet',$mIvaSet);
		$stmt->bindParam(':mReferencia',$mReferencia);
		$stmt->bindParam(':mPathXml',$XMLfile);
		$stmt->bindParam(':mPathPdf',$PDFfile);
		$stmt->bindParam(':mLugar',$mLugar);
		$stmt->bindParam(':mMotivoDesc',$null);
		$stmt->bindParam(':mEstatus',$mConstant);
		$stmt->execute();
		$addCfdiResult = $stmt->fetchAll();
		$idcfdi = $addCfdiResult[0]['IdCfdi'];
		// print_r($idcfdi);

		$stmt = $con->prepare('exec [GSIREM007].[factura].[proc_editCfdi_Factura] :idCfdi,NULL,NULL,NULL,NULL,
		NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
		:sellocfd,
		:sellosat,
		:fechatimbre,
		:uddi,
		:noCertSat,
		NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL');
		$stmt->bindParam(':idCfdi',$idcfdi);
		$stmt->bindParam(':sellocfd',$explodedtxt[19]);
		$stmt->bindParam(':sellosat',$explodedtxt[28]);
		$stmt->bindParam(':fechatimbre',$explodedtxt[16]);
		$stmt->bindParam(':uddi',$explodedtxt[7]);
		$stmt->bindParam(':noCertSat',$explodedtxt[25]);
		$stmt->execute();

		$cn->Desconectar($con, $stmt);
}
		// TODO: Generate Json string
		$Json = array("MSJ"=>$result->Msj, "XML64"=>$result->XML64, "PDF64"=>$result->PDF64, "RESUMEN"=>$result->RESUMEN, "QR"=>$result->QR, "NAMEFILE"=>$result->NAMEFILE);

		echo json_encode($Json);


	} catch (SoapFault $e) {
		error(1,'Error: ' . $e->getMessage());
		$Json = array("MSJ"=>"Ups!! hubo un problema y no pudimos recuperar los datos.<br/>$e<hr/>", "XML64"=>"", "PDF64"=>"", "RESUMEN"=>"", "QR"=>"", "NAMEFILE"=>"");
		echo json_encode($Json);
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
