<?php
include 'conn.php';

try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT SECCION.idseccion, SECCION.seccion, MUNICIPIO.municipio FROM SECCION 
						 inner join CONTEO_RAPIDO on CONTEO_RAPIDO.idseccion = SECCION.idseccion 
						 inner join MUNICIPIO on MUNICIPIO.idmunicipio = SECCION.idmunicipio
						 ORDER BY SECCION.seccion");
  $stmt->execute();

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>