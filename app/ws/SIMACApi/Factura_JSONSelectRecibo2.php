<?php
include 'Factura_conn.php';

error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {

  $body = json_decode(file_get_contents("php://input"), true);

  $folio = $body['FacturaFolio'];
  $fecha = $body['FacturaFecha'];

  try {
      $cn = new Conexion();
      $con = $cn->Conectar();

      $stmt = $con->prepare("exec [ingreso].[PROC_RECIBOSGET] :folio , :date ");
      $stmt->execute(array(':folio' =>  $folio,':date' => $fecha));
      $Ticket = $stmt->fetchAll();
      if (!Empty($Ticket)) {
        $stmt = $con->prepare("exec [factura].[proc_getCfdi_FacturaCount] null , :folio ");
        $stmt->execute(array(':folio' => $folio));
        $CFDIRegistered = $stmt->fetchAll();
        if ($CFDIRegistered[0][0]=="" && $CFDIRegistered[0][1]=="") {
          echo json_encode($Ticket);
        }else{
          echo '[{"":"Cashed"}]';
        }
      }else{
        echo '[{"":"not-found"}]';
      }
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
