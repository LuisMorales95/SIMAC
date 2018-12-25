<?php
include 'Factura_conn.php';

error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

  $body = json_decode(file_get_contents("php://input"), true);

  $cn = new Conexion();
  $con = $cn->Conectar();

  $folio = $body['FacturaFolio'];
  $fecha = $body['FacturaFecha'];

  try {
      $cn = new Conexion();
      $con = $cn->Conectar();

      $stmt = $con->prepare("exec [ingreso].[PROC_RECIBOSGET] :facturafolio , :facturafecha ");
      $stmt->execute(array(':facturafolio' =>  $folio,':facturafecha' => $fecha));
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
