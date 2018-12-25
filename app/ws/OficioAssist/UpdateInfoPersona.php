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
  $Id_Usuario = $body['Id_Usuario'];
  $Campo_Usuario = $body['Campo_Usuario'];
  $valor_Usuario = $body['valor_Usuario'];

  try {
    $Id_Usuario = utf8_encode($Id_Usuario);
    $Campo_Usuario = utf8_encode($Campo_Usuario);
    $valor_Usuario = utf8_encode($valor_Usuario);
    
    $stmt = $con->prepare("UPDATE Usuarios SET ".$Campo_Usuario." = :value WHERE Usuarios.id_usuario = :id ;");
    $stmt->execute(array(
      ':value'=>$valor_Usuario, 
      ':id'=>$Id_Usuario));

    if ($stmt) {
      echo '{"Response":"Success"}';
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