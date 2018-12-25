<?php 
include 'conn.php';

try {
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT COUNT(*) FROM dbo.MovilCiudadano WHERE fk_id_rol = 1");
  $stmt->execute();
  $Ciudadanos = $stmt->fetchColumn();

  $stmt = $con->prepare("SELECT COUNT(*) FROM dbo.MovilCiudadano WHERE fk_id_rol = 2");
  $stmt->execute();
  $Trabajadores = $stmt->fetchColumn();

  $stmt = $con->prepare("SELECT COUNT(*) FROM dbo.MovilCiudadano WHERE fk_id_rol = 3");
  $stmt->execute();
  $Administradores = $stmt->fetchColumn();


  echo '[{"C":"'.$Ciudadanos.'","T":"'.$Trabajadores.'","A":"'.$Administradores.'"}]';



  $cn->Desconectar($con, $stmt);



} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>