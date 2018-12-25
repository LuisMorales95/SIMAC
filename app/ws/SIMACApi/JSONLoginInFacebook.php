<?php 
include 'conn.php';

  if(isset($_POST["email"])){
      $email = $_POST["email"];
   }

  try {


    $cn = new Conexion();
    $con = $cn->Conectar();
    $stmt = $con->prepare('SELECT dbo.MovilCiudadano.Id, dbo.MovilCiudadano.Contrasena, dbo.MovilCiudadano.Token, dbo.MovilCiudadano.ImgUrl, dbo.MovilCiudadano.Nombre, dbo.MovilCiudadano.CorreoE, dbo.MovilCiudadano.fk_id_rol, dbo.MovilCiudadano.Verificacion_Usuario FROM dbo.MovilCiudadano WHERE CorreoE = :email ;');
    $stmt->execute(array(':email' => $email ));
    $row = $stmt->fetch();
    if ($row[2] != ""||$row[2] != "null") {
      $tk = token();
      $stmt = $con->prepare('UPDATE dbo.MovilCiudadano SET Token = :token WHERE id = :id');
      $idusu = $row[0];
      $stmt->execute(array(':token' => $tk, ":id" => $idusu));
      $stmt = $con->prepare('SELECT dbo.MovilCiudadano.Id, dbo.MovilCiudadano.Contrasena, dbo.MovilCiudadano.Token, dbo.MovilCiudadano.ImgUrl, dbo.MovilCiudadano.Nombre, dbo.MovilCiudadano.ApellidoP, dbo.MovilCiudadano.CorreoE, dbo.MovilCiudadano.fk_id_rol, dbo.MovilCiudadano.Verificacion_Usuario FROM dbo.MovilCiudadano WHERE CorreoE = :email ;');
      $stmt->execute(array(':email' => $email ));
      echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
    }

    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    echo 'Error: ' . $e->getMessage();
  }

  function token(){
    $UserID = "D89654";
    $token = md5(uniqid(microtime(), true));
    $token_time = time();
    $_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time);
    return $token;
  }


?>