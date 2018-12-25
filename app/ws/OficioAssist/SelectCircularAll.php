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


    $stmt = $con->prepare("SELECT id_circular, cla_circular, nom_circular, asu_circular, ubi_circular, notas, fk_id_departamento, fk_id_estado, fk_id_persona, DepEnviada, RutaCircularP, RutaCircularR, nom_persona=(nom_persona+' '+app_persona+' '+apm_persona)FROM Circular inner join Personas on fk_id_persona = id_persona ORDER BY id_circular DESC;");
    $stmt->execute();
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

    $cn->Desconectar($con, $stmt);
    
  } catch(PDOException $e) {
    error(1,'Error: ' . $e->getMessage());
  }


}
function error($numero,$texto){
  $ddf = fopen('Error.log','a');
  fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
  fclose($ddf);
}
   
 ?>