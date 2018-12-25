<?php 
include 'conn.php';

	if(isset($_REQUEST["id_ciudadano"])){
	    $id_ciudadano = $_REQUEST["id_ciudadano"];
	}

try {
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT * FROM dbo.MovilSolicitud_Temp WHERE fk_id_ciudadano = :idfkciudadano order by id desc;');
  $stmt->execute(array('idfkciudadano' => $id_ciudadano ));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
 ?>