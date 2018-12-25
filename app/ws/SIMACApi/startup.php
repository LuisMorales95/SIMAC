<?php
session_start();
include 'conn.php';
error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

  $body = json_decode(file_get_contents("php://input"), true);
  $ID_USER = $body['ID'];
  $Token = $body['Token'];

  try {
    $tokenvalue="";
    $cn = new Conexion();
    $con = $cn->Conectar();
    $stmt = $con->prepare("select id, Nombre, ApellidoP, CorreoE, Telefono, Token, ImgURL, fk_id_rol, Verificacion_Usuario, message=''
    	from dbo.MovilCiudadano WHERE id =  :id_user");
    $stmt->execute(array(':id_user' => $ID_USER ));
    $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($row as $key => $value) {
      $tokenvalue = $value["Token"];
    }

    if ($tokenvalue!=$Token) {
    
      $message = array('message' => 'Unvalid session' );
      echo json_encode($message);
    
    }else{
    
      echo json_encode($row[0]);
    
    }

    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    echo 'Error: ' . $e->getMessage();
  }
}

  function token(){
    $UserID = "D89654";
    $token = md5(uniqid(microtime(), true));
    $token_time = time();
    $_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time);
    return $token;
  }
 ?>
