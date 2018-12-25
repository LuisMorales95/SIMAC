<?php
include 'conn.php';

  if(isset($_REQUEST["eleccion"])){
      $eleccion = $_REQUEST["eleccion"];
  }
  if(isset($_REQUEST["seccion"])){
      $seccion = $_REQUEST["seccion"];
  }
  if(isset($_REQUEST["tipo"])){
      $tipo = $_REQUEST["tipo"];
  }
  if(isset($_REQUEST["campo"])){
      $campo = $_REQUEST["campo"];
  }
  if(isset($_REQUEST["valor"])){
      $valor = $_REQUEST["valor"];
  }
  

try {
	
	$eleccion = utf8_encode($eleccion);
  	$seccion = utf8_encode($seccion);
  	$tipo = utf8_encode($tipo);
  	$campo = utf8_encode($campo);
  	$valor = utf8_encode($valor);

	$cn = new Conexion();
	$con = $cn->Conectar();

	$stmt = $con->prepare('UPDATE CONTEO_RAPIDO SET '.$campo.' = :valor where CONTEO_RAPIDO.idtipoeleccion  = :eleccion and CONTEO_RAPIDO.idseccion = :seccion and CONTEO_RAPIDO.idtipo = :tipo');
	$stmt->execute(array(':valor' => $valor,':eleccion' => $eleccion,':seccion' => $seccion,':tipo' => $tipo));


	$cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

;
?>