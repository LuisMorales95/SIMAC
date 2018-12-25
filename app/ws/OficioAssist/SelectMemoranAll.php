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


    $stmt = $con->prepare("SELECT id_memoran, cla_memoran, nom_memoran, asu_memoran, ubi_memoran, notas, fk_id_departamento, fk_id_estado, fk_id_persona, DepEnviada, RutaMemoranP, RutaMemoranR, nom_persona=(nom_persona+' '+app_persona+' '+apm_persona)FROM Memoran inner join Personas on fk_id_persona = id_persona ORDER BY id_memoran DESC;");
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