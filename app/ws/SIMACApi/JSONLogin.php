<?php
include 'conn.php';

 //$correo = "karla_nassar04@hotmail.com";
//$correo = 'Luis@hotmail.com';
  if(isset($_POST['Correo'])){
      $correo = $_POST['Correo'];
   }

  try {
    $cn = new Conexion();
    $con = $cn->Conectar();
    $stmt = $con->prepare('SELECT dbo.MovilCiudadano.id, dbo.MovilCiudadano.Contraseña, dbo.MovilCiudadano.Token, dbo.MovilCiudadano.ImgUrl, dbo.MovilCiudadano.Nombre, dbo.MovilCiudadano.CorreoE, dbo.MovilCiudadano.fk_id_rol FROM dbo.MovilCiudadano WHERE CorreoE = :correo;');
    $stmt->execute(array(':correo' => $correo ));
    $row = $stmt->fetch();
    //echo $row[2];
    //echo "<br>";
    if ($row[2] != ""||$row[2] != "null") {
      //echo "TOKEN VACIO";
      //echo "<br>";
      $tk = token();
      //echo "CREANDO TOKEN";
      //echo "<br>";
      $stmt = $con->prepare('UPDATE dbo.MovilCiudadano SET Token = :token WHERE id = :id');
      $idusu = $row[0];
      $stmt->execute(array(':token' => $tk, ":id" => $idusu));
      //echo "EJECUTANDO UPDATE";
      //echo "<br>";
      $stmt = $con->prepare('SELECT dbo.MovilCiudadano.id, dbo.MovilCiudadano.Contraseña, dbo.MovilCiudadano.Token, dbo.MovilCiudadano.ImgUrl, dbo.MovilCiudadano.Nombre, dbo.MovilCiudadano.ApellidoP, dbo.MovilCiudadano.CorreoE, dbo.MovilCiudadano.fk_id_rol FROM dbo.MovilCiudadano WHERE CorreoE = :correo;');
      $stmt->execute(array(':correo' => $correo ));
      //echo "EJECUTANDO SELECT";
      //echo "<br>";
      echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
      //echo "<br>";
      //echo "RETORNO DE VALORES";
      //echo "<br>";
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


//$stmt0 = $con->prepare('UPDATE usuario SET Token=:tk WHERE Id=:idu');
//$rows = $stmt0->execute( array( ':idu'   => $_SESSION['idu'] , ':tk' => $tk));

//echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
?>
