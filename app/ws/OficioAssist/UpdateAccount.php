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

  $Id_persona = $body['Id_persona'];
  $Nombre = $body['Nombre'];
  $ApellidoP = $body['ApellidoP'];
  $ApellidoM = $body['ApellidoM'];
  $Telefono = $body['Telefono'];
  $Correo = $body['Correo'];
  $Usuario = $body['UsuCorreo'];
  $Contrasena = $body['Contrasena'];

  try {
    $Id_persona = utf8_encode($Id_persona);
    $Nombre = utf8_encode($Nombre);
    $ApellidoP = utf8_encode($ApellidoP);
    $ApellidoM = utf8_encode($ApellidoM);
    $Telefono = utf8_encode($Telefono);
    $Correo = utf8_encode($Correo);
    $Usuario = utf8_encode($Usuario);
    $Contrasena = utf8_encode($Contrasena);

    
    $stmt = $con->prepare("UPDATE Personas SET nom_persona=:nomp ,apm_persona=:apmp ,app_persona=:appp ,tel_persona=:telp ,cor_persona=:corp WHERE id_persona= :id_persona ;");
    $stmt->execute(array(':nomp'=>$Nombre, ':apmp'=>$ApellidoM, ':appp'=>$ApellidoP, ':telp'=>$Telefono, ':corp'=>$Correo, ':id_persona'=>$Id_persona));

    if ($stmt) {
        $stmt = $con->prepare("UPDATE Usuarios SET usu_usuario= :usuu , con_usuario= :conu WHERE id_usuario= :id_usuario ;");
        $stmt->execute(array(':usuu'=>$Usuario, ':conu'=>$Contrasena, ':id_usuario'=>$Id_persona));
      if ($stmt) {
        echo '{"Response":"Success"}';
      }else{
          echo '{"Response":"Error"}';
      }
    }else{
      echo '{"Response":"Error"}';
    }
    $cn->Desconectar($con, $stmt);
    
  } catch(PDOException $e) {
    //echo 'Error: ' . $e->getMessage();
    error(1,'Error: ' . $e->getMessage());
    echo '{"Response":"Error"}';

  }
}
function error($numero,$texto){
$ddf = fopen('Error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}
?>