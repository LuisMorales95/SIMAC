<?php
include 'conn.php';

  if(isset($_REQUEST["idseccionusr"])){
      $idseccionusr = $_REQUEST["idseccionusr"];
  }
  


try {
	
	$idseccionusr = utf8_encode($idseccionusr);
  
  	$cn = new Conexion();
  	$con = $cn->Conectar();

  	$stmt = $con->prepare("DELETE FROM SECCION_USUARIOS WHERE idseccionusr = :idseccionusr");

  	$stmt->execute(array(':idseccionusr' => $idseccionusr));

  	$cn->Desconectar($con, $stmt);
  	echo '[{"EXITO":"SI"}]';

	} catch(PDOException $e) {
	  echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}
?>