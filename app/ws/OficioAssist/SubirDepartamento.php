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

  $sw_Nombre_departamento = $body['Nombre_departamento'];
  $sw_Clave_departamento = $body['Clave_departamento'];
  $sw_Ncla_departamento = $body['Ncla_departamento'];


	try {
	  $sw_Nombre_departamento = utf8_encode($sw_Nombre_departamento);
	  $sw_Clave_departamento = utf8_encode($sw_Clave_departamento);

	  $stmt = $con->prepare("SELECT Counted=COUNT(*) from Departamento WHERE nom_departamento= :nomdepa OR cla_departamento= :cladepa ;");
	  $stmt->execute(array(
	  	':nomdepa'=>$sw_Nombre_departamento, 
	  	':cladepa'=>$sw_Clave_departamento));
	  $rows = $stmt->fetch();
	  if ($rows[0]>0) {
	  	echo '{"Response":"Existe"}';
	  }else{
	  	$stmt = $con->prepare("INSERT INTO Departamento VALUES ( :nom_dep , :cla_dep, :ncla_dep );");
	  	$stmt->execute(array(
	  		':nom_dep'=>$sw_Nombre_departamento, 
	  		':cla_dep'=>$sw_Clave_departamento,
	  		':ncla_dep'=>$sw_Ncla_departamento));

	  	if ($stmt) {
	  		echo '{"Response":"Success"}';
	  	}else{
	  		echo '{"Response":"Error"}';
	  	}
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