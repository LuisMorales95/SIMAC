<?php
include 'conn.php';

if(isset($_POST['id'])){
    $id = $_POST['id'];
}
  try {
    $id = utf8_encode($id);

    $cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("DELETE from dbo.MovilAlertas where id_alerta= :id;");
    $stmt->execute(array(':id' => $id));

    echo '[{"EXITO":"SI"}]';

    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
  }

 ?>
