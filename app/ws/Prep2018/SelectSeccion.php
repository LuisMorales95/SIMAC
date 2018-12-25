<?php
include 'conn.php';

  if(isset($_POST["iAppid"])){
      $iAppid = $_POST["iAppid"];
  }


try {
	
	$iAppid = utf8_encode($iAppid);
  
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT 
  SECCION.idseccion,
  SECCION.seccion,
  MUNICIPIO.municipio
  from USUARIOS_WEB 
  inner join SECCION_USUARIOS on SECCION_USUARIOS.iappid = USUARIOS_WEB.iAppID
  inner join SECCION on SECCION_USUARIOS.idseccion = SECCION.idseccion
  inner join MUNICIPIO on SECCION.idmunicipio = MUNICIPIO.idmunicipio
  where USUARIOS_WEB.iAppID = :iappid order by seccion asc');

  $stmt->execute(array(':iappid' => $iAppid));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>