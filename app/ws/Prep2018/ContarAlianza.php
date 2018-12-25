<?php
include 'conn.php';

	if(isset($_POST["tipoe"])){
      $tipoe = $_POST["tipoe"];
  	}

try {
	
	$cn = new Conexion();
	$con = $cn->Conectar();

	$stmt = $con->prepare("SELECT * FROM CONTEO_RAPIDO WHERE idtipoeleccion = :tipoe");
	$stmt->execute(array(':tipoe' => $tipoe));

	echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

	$cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  	echo 'Error: ' . $e->getMessage();
}
?>