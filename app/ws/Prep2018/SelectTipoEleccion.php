<?php
include 'conn.php';

  if(isset($_REQUEST["iCasilla"])){
      $iCasilla = $_REQUEST["iCasilla"];
  }


try {
	
	$iCasilla = utf8_encode($iCasilla);
  
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT 
TIPO_ELECCION.*
FROM TIPO_SECCION 
  inner join SECCION on SECCION.idseccion = TIPO_SECCION.idseccion
  inner join REL_SECCION_ELECCION on SECCION.idseccion = REL_SECCION_ELECCION.idseccion
  inner join TIPO_ELECCION on TIPO_ELECCION.idtipoeleccion = REL_SECCION_ELECCION.idtipoeleccion
WHERE idtipo = :idCasilla order by eleccion asc');

  $stmt->execute(array(':idCasilla' => $iCasilla));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>