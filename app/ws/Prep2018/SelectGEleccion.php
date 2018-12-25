<?php
include 'conn.php';

if(isset($_POST["idseccion"])){
    $idseccion = $_POST["idseccion"];
}

try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT TIPO_ELECCION.* FROM CONTEO_RAPIDO
INNER JOIN TIPO_ELECCION on TIPO_ELECCION.idtipoeleccion = CONTEO_RAPIDO.idtipoeleccion
WHERE idseccion = :selected ORDER BY CONTEO_RAPIDO.idtipoeleccion asc");
  $stmt->execute(array(':selected' => $idseccion));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>