
<?php

error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

	$body = json_decode(file_get_contents("php://input"), true);
	error(1,json_encode($body));

	$trace = true;
	$exceptions = false;

	$Password = $body['Password'];
	$File_64 = $body['File64'];
	$File_Name = $body['file_name'];
	try {

		// TODO: Create file txt that will be sent to server
		$file = 'TESTING/'.$File_Name."txt";
		$handle = fopen($file, 'w') or die('Cannot open file:  '.$my_file);
		$data = base64_decode($File_64);
		fwrite($handle, $data);

		// TODO: Get content of the file
		$archivo = (file_get_contents($file,true));

		// TODO: Create SOAP client
		$client = new SoapClient('https://www.csfacturacion.com/webservices/csplug/timbrarcfdi.php?wsdl');

		// TODO: Set parameters that SOAP WSDL requires
		$result  = $client->__SoapCall("Uploadarchivo", array('Password' => $Password, 'Archivo' => $archivo));
		print_r($result);

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


?>
