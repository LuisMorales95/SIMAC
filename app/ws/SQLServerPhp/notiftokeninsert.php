<?php
include 'conn.php';

if(isset($_POST['id'])){
    $id = $_POST['id'];
}
if(isset($_POST['token'])){
    $token = $_POST['token'];
}

  try {
    $id = utf8_encode($id);
    $token = utf8_encode($token);

    $cn = new Conexion();

    $con = $cn->Conectar();

    $stmt = $con->prepare("UPDATE dbo.MovilCiudadano set tokennotif = :token where id = :id;");

    $stmt->execute(array(':id' => $id,':token' => $token));

    echo '[{"EXITO":"SI"}]';

    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
  }



 ?>
