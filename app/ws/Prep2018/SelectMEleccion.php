<?php
include 'conn.php';

if(isset($_POST["idMunicipio"])){
    $idMunicipio = $_POST["idMunicipio"];
}

try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT TIPO_ELECCION.* FROM CONTEO_RAPIDO
INNER JOIN TIPO_ELECCION on TIPO_ELECCION.idtipoeleccion = CONTEO_RAPIDO.idtipoeleccion
INNER JOIN SECCION on SECCION.idseccion = CONTEO_RAPIDO.idseccion
WHERE SECCION.idmunicipio = :selectedM ORDER BY CONTEO_RAPIDO.idtipoeleccion asc");

  $stmt->execute(array(':selectedM' => $idMunicipio));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>