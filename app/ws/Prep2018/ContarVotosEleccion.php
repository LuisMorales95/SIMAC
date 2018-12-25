<?php
include 'conn.php';

if(isset($_REQUEST["idmunicipio"])){
    $idmunicipio = $_REQUEST["idmunicipio"];
}
if(isset($_REQUEST["idtipoEle"])){
    $idtipoEle = $_REQUEST["idtipoEle"];
}
try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT CONTEO_RAPIDO.* FROM SECCION 
INNER JOIN CONTEO_RAPIDO on CONTEO_RAPIDO.idseccion = SECCION.idseccion
WHERE idmunicipio = :idmunicipio and idtipoeleccion = :idtipoEle ");
  
  $stmt->execute(array(':idmunicipio'=>$idmunicipio, ':idtipoEle'=>$idtipoEle));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>