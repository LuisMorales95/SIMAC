<?php
include 'conn.php';

  if(isset($_REQUEST["iSeccion"])){
      $iSeccion = $_REQUEST["iSeccion"];
  }


try {
	
	$iSeccion = utf8_encode($iSeccion);
  
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT
  TIPO_SECCION.idtipo,
  TIPO_SECCION.tipo,
  TIPO_SECCION.ubicacion,
  COLONIA.COLONIA,
  LOCALIDAD.LOCALIDAD
  FROM SECCION 
  INNER JOIN TIPO_SECCION ON TIPO_SECCION.idseccion = SECCION.idseccion
  INNER JOIN COLONIA ON COLONIA.IDCOLONIA = TIPO_SECCION.idcolonia
  INNER JOIN LOCALIDAD ON COLONIA.IDLOCALIDAD = LOCALIDAD.IDLOCALIDAD
  WHERE SECCION.idseccion = :idseccion  order by idtipo asc');

  $stmt->execute(array(':idseccion' => $iSeccion));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>