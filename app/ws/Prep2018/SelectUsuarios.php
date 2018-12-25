<?php
include 'conn.php';

try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT * FROM USUARIOS_WEB ORDER BY iAppID desc");
  $stmt->execute();

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>