<?php
session_start();
include 'Conexion.php';
error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

  // Decodificando formato Json
  $body = json_decode(file_get_contents("php://input"), true);

  $cn = new Conexion();
  $con = $cn->Conectar();

  $sw_Nombre = $body['Nombre'];
  $sw_ApellidoP = $body['ApellidoP'];
  $sw_ApellidoM = $body['ApellidoM'];
  $sw_Telefono = $body['Telefono'];
  $sw_Correo = $body['Correo'];
  $sw_Usuario = $body['UsuCorreo'];
  $sw_Contrasena = $body['Contrasena'];

try {
  $sw_Nombre = utf8_encode($sw_Nombre);
  $sw_ApellidoP = utf8_encode($sw_ApellidoP);
  $sw_ApellidoM = utf8_encode($sw_ApellidoM);
  $sw_Telefono = utf8_encode($sw_Telefono);
  $sw_Correo = utf8_encode($sw_Correo);
  $sw_Usuario = utf8_encode($sw_Usuario);
  $sw_Contrasena = utf8_encode($sw_Contrasena);
// SELECT * FROM Personas INNER JOIN Usuarios ON Personas.id_persona = Usuarios.fk_id_persona WHERE cor_persona='' OR usu_usuario='';

  $stmt = $con->prepare("SELECT Counted=COUNT(*) FROM Personas INNER JOIN Usuarios ON Personas.id_persona = Usuarios.fk_id_persona WHERE cor_persona = :cor_persona OR usu_usuario= :usuario;");
  $stmt->execute(array(':cor_persona'=>$sw_Correo, ':usuario'=>$sw_Usuario));
  $rows= $stmt->fetch();
  if ($rows[0]>0) {
    echo '{"Response":"Existe"}';
  }else{

    $stmt = $con->prepare("INSERT INTO Personas VALUES(:nom_persona,:apm_persona,:app_persona,:tel_persona,:cor_persona);");
    $rows = $stmt->execute(array(
      ':nom_persona'=>$sw_Nombre,
      ':apm_persona'=>$sw_ApellidoM,
      ':app_persona'=>$sw_ApellidoP,
      ':tel_persona'=>$sw_Telefono,
      ':cor_persona'=>$sw_Correo));
    if ($rows == 1) {
      $stmt1 = $con->prepare('SELECT Personas.id_persona FROM Personas WHERE Personas.cor_persona= :cor_persona ;');
      $stmt1->execute(array(':cor_persona' => $sw_Correo));
      $rows2 = $stmt1->fetch();
      if ($rows2[0]<>"") {
        $stmt2 = $con->prepare('INSERT INTO Usuarios VALUES(:usu_usuario,:con_usuario,:token,:fkidpersona,1,0);');
        $stmt2->execute(array(
          ':usu_usuario' => $sw_Usuario,
          ':con_usuario' => $sw_Contrasena, 
          ':token'=>token(), 
          ':fkidpersona'=> $rows2[0])); 
        if ($stmt2) {
          echo '{"Response":"Success"}';
        }else{
          echo '{"Response":"ErrorUsario"}';
        }
      }else{
        echo '{"Response":"ErrorIdRecovery"}';
      }                 
    }else{
      echo '{"Response":"ErrorPersona"}';
    }
  }
  
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  //echo 'Error: ' . $e->getMessage();
  error(1,'Error: ' . $e->getMessage());
}


}
function token(){
  $UserID = "D89654";
  $token = md5(uniqid(microtime(), true));
  $token_time = time();
  $_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time);
  return $token;
}
function error($numero,$texto){
$ddf = fopen('Error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}
   

