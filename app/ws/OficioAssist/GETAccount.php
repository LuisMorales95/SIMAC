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

    $stmt = $con->prepare("SELECT id_persona, nom_persona, apm_persona, app_persona, tel_persona, cor_persona, usu_usuario, con_usuario from Personas inner join Usuarios on Personas.id_persona = Usuarios.fk_id_persona WHERE id_persona = :id_persona");
    $stmt->execute(array(':id_persona' => $sw_id_persona));
    if ($stmt) {
      $rows=$stmt->fetch();
      echo '{
        "id_persona":"'.$rows[0].'",
        "nom_persona":"'.$rows[1].'",
        "app_persona":"'.$rows[2].'",
        "apm_persona":"'.$rows[3].'",
        "tel_persona":"'.$rows[4].'",
        "cor_persona":"'.$rows[5].'",
        "usu_usuario":"'.$rows[6].'",
        "con_usuario":"'.$rows[7].'"}';
    }else{
      echo '{
        "id_persona":"",
        "nom_persona":"",
        "app_persona":"",
        "apm_persona":"",
        "tel_persona":"",
        "cor_persona":"",
        "usu_usuario":"",
        "con_usuario":""}';
    }

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