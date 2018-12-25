<?php
session_start();
include 'conn.php';


if($_SERVER['REQUEST_METHOD'] == 'POST') {

  $body = json_decode(file_get_contents("php://input"), true);
  $ID_USER = $body['ID'];
  $Token = $body['Token'];

  try {
    $tokenvalue="";
    $cn = new Conexion();
    $con = $cn->Conectar();
    $stmt = $con->prepare('SELECT * FROM dbo.MovilCiudadano WHERE id =  :id_user');
    $stmt->execute(array(':id_user' => $ID_USER ));
    $row = $stmt->fetchAll();
    foreach ($row as $key => $value) {
      $tokenvalue = $value["Token"];
    }
    if ($tokenvalue!=$Token) {
      $stmt = $con->prepare('SELECT * FROM dbo.MovilCiudadano WHERE id = 0');
      $stmt->execute();
      echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
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
