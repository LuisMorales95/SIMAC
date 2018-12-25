<?php 
session_start();
include 'Conexion.php';
error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

  // Decodificando formato Json
  $body = json_decode(file_get_contents("php://input"), true);

  $cn = new Conexion();
  $con = $cn->Conectar();

  $sw_id_persona = $body['id_persona'];
  $sw_id_departamento = $body['id_departamento'];


	try {
	  $sw_id_persona = utf8_encode($sw_id_persona);
	  $sw_id_departamento = utf8_encode($sw_id_departamento);
	  
	  $stmt = $con->prepare("INSERT INTO TieneDepartamento VALUES ( :iddep, :idusu );");
	  $stmt->execute(array(
	  	':iddep'=>$sw_id_departamento, 
	  	':idusu'=>$sw_id_persona));

	  if ($stmt) {
	  	echo '{"Response":"Success"}';
	  }else{
	  	echo '{"Response":"Error"}';
	  }
	  $cn->Desconectar($con, $stmt);
	  
	} catch(PDOException $e) {
	  //echo 'Error: ' . $e->getMessage();
	  error(1,'Error: ' . $e->getMessage());
	  echo '{"Response":"Error"}';

	}
}
function error($numero,$texto){
$ddf = fopen('Error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}
?>