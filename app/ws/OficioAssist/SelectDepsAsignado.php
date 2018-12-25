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

  $sw_id_persona = $body['id_persona'];

  try {

    $sw_id_persona = utf8_encode($sw_id_persona);

    $stmt = $con->prepare("SELECT Departamento.* FROM Usuarios INNER JOIN TieneDepartamento ON Usuarios.id_usuario =TieneDepartamento.fk_id_usuario INNER JOIN Departamento ON Departamento.id_departamento = TieneDepartamento.fk_id_departamento where Usuarios.id_usuario = :idpersona ;");
    $stmt->execute(array(':idpersona' => $sw_id_persona ));
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