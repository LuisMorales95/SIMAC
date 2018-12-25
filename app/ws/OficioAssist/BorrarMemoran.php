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
  $sw_Id_Memoran = $body['Id_memoran'];


	try {
	  $sw_Id_Oficio = utf8_encode($sw_Id_Oficio);
	  $stmt = $con->prepare("DELETE FROM Memoran WHERE id_memoran = :id_memoran;");
	  $stmt->execute(array(':id_memoran'=>$sw_Id_Memoran));

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