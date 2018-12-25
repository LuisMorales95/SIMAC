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

try {
	
  $eleccion = utf8_encode($eleccion);
  $seccion = utf8_encode($seccion);
  $tipo = utf8_encode($tipo);
  
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT * From CONTEO_RAPIDO where CONTEO_RAPIDO.idtipoeleccion  = :eleccion and CONTEO_RAPIDO.idseccion = :seccion and CONTEO_RAPIDO.idtipo = :tipo');

  $stmt->execute(array(':eleccion' => $eleccion,':seccion' => $seccion,':tipo' => $tipo));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>