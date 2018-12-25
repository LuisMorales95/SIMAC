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

  $sw_Usuario = $body['UsuCorreo'];
  $sw_Contrasena = $body['Contrasena'];

  try {

    $sw_Usuario = utf8_encode($sw_Usuario);
    $sw_Contrasena = utf8_encode($sw_Contrasena);

    $stmt = $con->prepare("UPDATE Usuarios SET token=:token where Usuarios.usu_usuario=:usuario and Usuarios.con_usuario=:contrasena;");
    $stmt->execute(array(':token'=>token(),':usuario'=>$sw_Usuario,':contrasena'=>$sw_Contrasena));

    $stmt2 = $con->prepare("SELECT Personas.id_persona, Personas.nom_persona, Personas.app_persona, Personas.apm_persona, Personas.tel_persona, Personas.cor_persona, Usuarios.token, Usuarios.activo, Usuarios.fk_id_rol from Personas inner join Usuarios on Usuarios.fk_id_persona = Personas.id_persona where Usuarios.usu_usuario= :usuario and Usuarios.con_usuario= :contrasena;");
    $stmt2->execute(array(':usuario'=>$sw_Usuario,':contrasena'=>$sw_Contrasena));
    $rows2 = $stmt2->fetch();
    if ($stmt2) {
      echo '{"id_persona":"'.$rows2[0].'","nom_persona":"'.$rows2[1].'","app_persona":"'.$rows2[2].'","apm_persona":"'.$rows2[3].'","tel_persona":"'.$rows2[4].'","cor_persona":"'.$rows2[5].'","token":"'.$rows2[6].'","activo":"'.$rows2[7].'","rol":"'.$rows2[8].'"}';
    }else{
      echo '{"id_persona":"", "nom_persona":"", "app_persona":"", "apm_persona":"", "tel_persona":"", "cor_persona":"", "token":"", "activo":"", "rol":""}';
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
   

