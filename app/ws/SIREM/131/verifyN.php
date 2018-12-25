<?php
include 'Conexion.php';

$us = 'brigada03';
$pass = 'brigada03';

  

try {
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare('SELECT 
                         PASSWORD,
                         USUARIO,
                         IDPERSONA,
                         TOKEN
                         FROM seguridad.USUARIO WHERE USUARIO=:us');
  $stmt->execute(array(':us' => $us ));
  
  $row = $stmt->fetch();
 
  $tok = GenToken();
  
  if($row[0] == $pass){
      
        $stmt0 = $con->prepare('UPDATE seguridad.USUARIO SET TOKEN=:tk WHERE USUARIO=:us');
        $rows0 = $stmt0->execute(array(':tk' => $tok,':us' => $us));       
  
      echo '{"idp":"'.$row[2].'","user":"'.$row[1].'","token":"'.$tok.'"}'; 
  }else{
      echo '{"idp":"0"}';
  }
   
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}



function GenToken(){
  $UserID = "D89654";
  $token = md5(uniqid(microtime(), true));
  $token_time = time();
  $_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time); 
  return $token;
}