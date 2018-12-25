<?php
include 'conn.php';

if(isset($_REQUEST["secid"])){
    $secid = $_REQUEST["secid"];
}
if(isset($_REQUEST["idtipo"])){
    $idtipo = $_REQUEST["idtipo"];
}
try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT * FROM CONTEO_RAPIDO where idseccion = :idsec AND idtipoeleccion = :idtipo ");
  $stmt->execute(array(':idsec'=>$secid, ':idtipo'=>$idtipo));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>