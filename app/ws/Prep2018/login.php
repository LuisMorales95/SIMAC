<?php
include 'conn.php';

        if(isset($_POST["usuario"])){
            $usuario = $_POST["usuario"];
        }
        if(isset($_POST["contra"])){
            $contra = $_POST["contra"];
        }

try {
	
	$usuario = utf8_encode($usuario);
    $contra = utf8_encode($contra);

  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT * FROM dbo.USUARIOS_WEB WHERE iAppLogin = :iUsu and iAppPwd = :iPass');
  $stmt->execute(array(':iUsu' => $usuario, ':iPass' => $contra));

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>