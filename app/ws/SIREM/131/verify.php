<?php
session_start();
include 'Conexion.php';

$us = '';
$pass = '';

if($_SERVER['REQUEST_METHOD'] == 'POST') {

// Decodificando formato Json
$body = json_decode(file_get_contents("php://input"), true);

if(isset($body['user'])){
   $us = $body['user'];
   $pass = $body['pass'];  

try {
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT PASSWORD, USUARIO,[seguridad].[USUARIO].IDPERSONA,TOKEN,catastro.BRIGADISTA.IDBRIGADISTA
FROM [seguridad].[USUARIO] INNER JOIN [catastro].[BRIGADISTA] 
ON seguridad.USUARIO.IDBRIGADISTA = catastro.BRIGADISTA.IDBRIGADISTA WHERE USUARIO=:us');
  $stmt->execute(array(':us' => $us ));
  
  $row = $stmt->fetch();
 
  $tok = GenToken();
  
  if($row[0] == $pass){
      
        $stmt0 = $con->prepare('UPDATE seguridad.USUARIO SET TOKEN=:tk WHERE USUARIO=:us');
        $rows0 = $stmt0->execute(array(':tk' => $tok,':us' => $us));       
  
      echo '{"idp":"'.$row[2].'","user":"'.$row[1].'","token":"'.$tok.'","idbrig":"'.$row[4].'"}'; 
  }else{
      echo '{"idp":"0"}';
  }
   
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

}else{
    echo '{"idp":"0"}'; 
}
}

function GenToken(){
  $UserID = "D89654";
  $token = md5(uniqid(microtime(), true));
  $token_time = time();
  $_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time); 
  return $token;
}