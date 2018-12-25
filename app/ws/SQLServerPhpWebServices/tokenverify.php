<?php
session_start();
include 'conn.php';

  //$Token = "34fc80d7d138dba94cb487e4dffb8840";
  if(isset($_REQUEST['Token'])){
     $Token = $_REQUEST['Token'];
  }

  try {
    $cn = new Conexion();
    $con = $cn->Conectar();
    $stmt = $con->prepare('SELECT dbo.MovilCiudadano.id, dbo.MovilCiudadano.Nombre, dbo.MovilCiudadano.Contraseña, dbo.MovilCiudadano.Token FROM dbo.MovilCiudadano WHERE Token = :token;');
    $stmt->execute(array(':token' => $Token ));
    //echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row=="") {
      //echo "VACIO";
      //echo "<br>";
      echo '[{"id":"","Nombre":"","Contrase\u00f1a":"","Token":""}]';
    }else {

      //echo "NO VACIO";
      //echo "<br>";
      echo "[".json_encode($row)."]";
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
//echo $row[2];
//echo "<br>";
/**if ($row[2] != "") {
  //echo "TOKEN VACIO";
  //echo "<br>";
  $tk = token();
  //echo "CREANDO TOKEN";
  //echo "<br>";
  $stmt = $con->prepare('UPDATE dbo.Ciudadano SET Token = :token WHERE id = :id');
  $idusu = $row[0];
  $stmt->execute(array(':token' => $tk, ":id" => $idusu));
  //echo "EJECUTANDO UPDATE";
  //echo "<br>";
  $stmt = $con->prepare('SELECT dbo.Ciudadano.id, dbo.Ciudadano.Contraseña, dbo.Ciudadano.Token FROM dbo.Ciudadano WHERE CorreoE = :correo;');
  $stmt->execute(array(':correo' => $correo ));
  //echo "EJECUTANDO SELECT";
  //echo "<br>";
  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
  //echo "<br>";
  //echo "RETORNO DE VALORES";
  //echo "<br>";**/

?>
