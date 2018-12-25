<?php
session_start();
include 'Conexion.php';

$tk = '';
//967acc4d22c2087303fca97c44a0910f

if($_SERVER['REQUEST_METHOD'] == 'POST') {

// Decodificando formato Json
$body = json_decode(file_get_contents("php://input"), true);

if(isset($body['token'])){
  $cn = new Conexion();
  $con = $cn->Conectar();
  
  $stmt0 = $con->prepare('SELECT TOKEN FROM seguridad.USUARIO WHERE TOKEN=:tk');
  $stmt0->execute(array(':tk' => $body['token'] ));
  
  $row = $stmt0->fetch();
 
  if($row[0] != $body['token']){ return;}

   $idlc = $body['idlc'];
   $idpre = $body['idprd'];
   $cr = $body['idec'];
   $ft = $body['idtic'];
   $lt = $body['idtec'];
   $lng = $body['ar'];
   $alt = $body['an'];
   $idup = $body['vc'];
   $otro = $body['lt'];

//  $stm = $con->prepare('SELECT IDLEVANTAMIENTOCAMPO FROM catastro.LEVANTAMIENTOCAMPO WHERE IDTAREACAMPO=:tzc');
//  $stm->execute(array(':tzc' => trim($body['idtc'])));
//  
//  $rw = $stm->fetch();
//  $idl = $rw[0];

try {
  
 $stmt = $con->prepare("INSERT INTO catastro.LEVANTAMIENTOCONSTRUCCION(
       IDPREDIO
      ,IDESTADOCONSTRUCCION
      ,IDTIPOCONSTRUCCION
      ,IDTERMINOCONSTRUCCION
      ,AREA
      ,ANTIGUEDAD
      ,VALOR_CONSTRUCCION
      ,LETRA
      ,IDLEVANTAMIENTOCAMPO) VALUES (:idprd, :idec, :idtic, :idtec, :ar, :an, :vc, :lt, :idlc)");
  $rows = $stmt->execute(array(':idprd' => $idpre, 
                               ':idec' => $cr, 
                               ':idtic' => $ft,
                               ':idtec' => $lt,
                               ':ar' => $lng,
                               ':an' => $alt,
                               ':vc' => $idup,
                               ':lt' => $otro,
                               ':idlc' => $idlc));
 // }

  if( $rows == 1 ){
  echo '{"resp":"Success-'.$idlc.'"}';
  }
  
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

}

}

