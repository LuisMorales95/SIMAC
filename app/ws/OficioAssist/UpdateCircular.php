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
  $sw_Id_Oficio = $body['Id_Oficio'];
  $sw_Clave_Oficio = $body['Clave_Oficio'];
  $sw_Nombre_Oficio = $body['Nombre_Oficio'];
  $sw_Asunto_Oficio = $body['Asunto_Oficio'];
  $sw_Ubica_Oficio = $body['Ubica_Oficio'];
  $sw_Notas_Oficio = $body['Notas_Oficio'];
  $sw_idDep_Oficio = $body['idDep_Oficio'];
  $sw_idEstado_Oficio = $body['idEstado_Oficio'];
  $sw_idPersona_Oficio = $body['idPersona_Oficio'];
  $sw_DepEnviada_Oficio = $body['DepEnviada_Oficio'];


  //Oficio
  if ($body['OficioP']<>'') {
  	$RutaOficioP64 = "CircularYRecibos/".$body['OficioP'];
  	if ($body['OficioP64']<>'') {
  		$imsrc0 = str_replace(' ','+',$body['OficioP64']);
  		$imsrc0 = base64_decode($imsrc0);
  		$fp0 = fopen($RutaOficioP64, 'w');
  		fwrite($fp0, $imsrc0);
  	}
  }else{
  	$RutaOficioP64 = $body['OficioP'];
  }
  //Recibo
  if ($body['OficioR']<>'') {
  	$RutaOficioR64 = "CircularYRecibos/".$body['OficioR'];
  	if ($body['OficioR64']<>'') {
  		$imsrc1 = str_replace(' ','+',$body['OficioR64']);
  		$imsrc1 = base64_decode($imsrc1);
  		$fp1 = fopen($RutaOficioR64, 'w');
  		fwrite($fp1, $imsrc1);
  	}
  }else{
  	$RutaOficioR64 = $body['OficioR'];
  }


	try {
	  $sw_Id_Oficio = utf8_encode($sw_Id_Oficio);
	  $sw_Clave_Oficio = utf8_encode($sw_Clave_Oficio);
	  $sw_Nombre_Oficio = utf8_encode($sw_Nombre_Oficio);
	  $sw_Asunto_Oficio = utf8_encode($sw_Asunto_Oficio);
	  $sw_Ubica_Oficio = utf8_encode($sw_Ubica_Oficio);
	  $sw_Notas_Oficio = utf8_encode($sw_Notas_Oficio);
	  $sw_idDep_Oficio = utf8_encode($sw_idDep_Oficio);
	  $sw_idEstado_Oficio = utf8_encode($sw_idEstado_Oficio);
	  $sw_idPersona_Oficio = utf8_encode($sw_idPersona_Oficio);
	  $sw_DepEnviada_Oficio = utf8_decode($sw_DepEnviada_Oficio);
	  
	  $stmt = $con->prepare("UPDATE Circular SET cla_circular=:cla_Oficio , nom_circular=:nom_Oficio , asu_circular=:asu_oficio , ubi_circular=:ubi_oficio , notas=:notas , fk_id_departamento=:fkid_departamento , fk_id_estado=:fkid_estado , fk_id_persona=:fkid_persona, DepEnviada=:DepEnvi_Oficio, RutaCircularP = :RutaOficioP, RutaCircularR = :RutaOficioR WHERE Circular.id_circular = :id_oficio ;");
	  $stmt->execute(array(
	  	':cla_Oficio'=>$sw_Clave_Oficio, 
	  	':nom_Oficio'=>$sw_Nombre_Oficio, 
	  	':asu_oficio'=>$sw_Asunto_Oficio, 
	  	':ubi_oficio'=>$sw_Ubica_Oficio, 
	  	':notas'=>$sw_Notas_Oficio, 
	  	':fkid_departamento'=>$sw_idDep_Oficio, 
	  	':fkid_estado'=>$sw_idEstado_Oficio, 
	  	':fkid_persona'=>$sw_idPersona_Oficio,
	  	':DepEnvi_Oficio'=>$sw_DepEnviada_Oficio,
	  	':RutaOficioP'=> $RutaOficioP64,
	  	':RutaOficioR'=> $RutaOficioR64,
	  	':id_oficio'=>$sw_Id_Oficio));

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