<?php
include 'conn.php';

  if(isset($_REQUEST["idusuario"])){
      $idusuario = $_REQUEST["idusuario"];
  }
  if(isset($_REQUEST["idseccion"])){
      $idseccion = $_REQUEST["idseccion"];
  }


try {
	
	$idusuario = utf8_encode($idusuario);
	$idseccion = utf8_encode($idseccion);
  
  	$cn = new Conexion();
  	$con = $cn->Conectar();

  	$stmt = $con->prepare("INSERT INTO SECCION_USUARIOS VALUES (:iappid, :idseccion)");

  	$stmt->execute(array(':iappid' => $idusuario,':idseccion' => $idseccion));

  	$cn->Desconectar($con, $stmt);
  	echo '[{"EXITO":"SI"}]';

	} catch(PDOException $e) {
	  echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}
?>