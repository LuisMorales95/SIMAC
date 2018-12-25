<?php
include 'conn.php';

error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

  // Decodificando formato Json
  $body = json_decode(file_get_contents("php://input"), true);

  $cn = new Conexion();
  $con = $cn->Conectar();

  $idSolicitud = $body['idSolicitud'];


  try {
      $cn = new Conexion();
      $con = $cn->Conectar();

      $stmt = $con->prepare("exec [dbo].[proc_GetConsultarByIdSolicitudMobil] :idsolicitudtemp");
      $stmt->execute(array(':idsolicitudtemp' =>  $idSolicitud));
      echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

      $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    error(1,'Error: ' . $e->getMessage());
    echo 'Error: ' . $e->getMessage();
  }

}



function error($numero,$texto){
$ddf = fopen('Error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}

?>
