<?php 
include 'conn.php';

if(isset($_POST['id'])){
    $id = $_POST['id'];
}
if(isset($_POST['rol'])){
    $rol = $_POST['rol'];
}

  try {
    $id = utf8_encode($id);
    $rol = utf8_encode($rol);

    $cn = new Conexion();

    $con = $cn->Conectar();

    $stmt = $con->prepare("UPDATE dbo.MovilCiudadano set fk_id_rol = :rol where id = :id;");

    $stmt->execute(array(':id' => $id,':rol' => $rol));

    echo '[{"EXITO":"SI"}]';

    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
  }

 ?>