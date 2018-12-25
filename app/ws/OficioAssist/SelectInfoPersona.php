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

  try {

    $stmt = $con->prepare("SELECT Usuarios.id_usuario, nom_persona=(nom_persona+' '+app_persona+' '+apm_persona), Usuarios.usu_usuario,Usuarios.fk_id_rol, Usuarios.activo  FROM  Personas inner join Usuarios ON Usuarios.fk_id_persona = Personas.id_persona;");
    $stmt->execute();
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

    $cn->Desconectar($con, $stmt);
    
  } catch(PDOException $e) {
    //echo 'Error: ' . $e->getMessage();
    error(1,'Error: ' . $e->getMessage());
  }


}
function error($numero,$texto){
  $ddf = fopen('Error.log','a');
  fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
  fclose($ddf);
}
?>