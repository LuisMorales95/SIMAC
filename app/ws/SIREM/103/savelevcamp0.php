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
  
   $idtareac = $body['idtc'];
   $lt = $body['lt'];
   $lng = $body['lng'];
   $alt = $body['alt'];
   $idup = $body['idup'];
   $otro = $body['otro'];
   $notif = $body['notif'];
   $obs = $body['obs'];

//CROQUIS
$cr = "croquis/".$body['ImageCroq'];

if($body['ImageCroq'] != ""){
$imsrc0 = str_replace(' ','+',$body['base640']);
$imsrc0 = base64_decode($imsrc0);
$fp0 = fopen($cr, 'w');
fwrite($fp0, $imsrc0);
}

//IMAGEN DE CAMARA
$ft = "fotos/".$body['ImageFoto'];

if($body['ImageFoto'] != ""){
$imsrc1 = str_replace(' ','+',$body['base641']);
$imsrc1 = base64_decode($imsrc1);
$fp1 = fopen($ft, 'w');
fwrite($fp1, $imsrc1);
}

try {
 
//  $stmt3 = $con->prepare('SELECT IDTAREACAMPO FROM catastro.LEVANTAMIENTOCAMPO WHERE IDTAREACAMPO=:tc');
//  $stmt3->execute(array(':tc' => $idtareac ));
//  
//  $row3 = $stmt3->fetch();
//  $rows;
//  $stmt;
   
//if($row3[0] == ""){ 
      $stmt = $con->prepare("INSERT INTO catastro.LEVANTAMIENTOCAMPO(IDLEVANTAMIENTOCAMPO
      ,IDTAREACAMPO
      ,CROQUIS
      ,FOTO
      ,LATITUD
      ,LONGITUD
      ,ALTITUD
      ,IDUSOPREDIO
      ,OTROUSO
      ,NOTIFICACION
      ,OBSERVACION) VALUES ((SELECT count(*)+1 AS T FROM catastro.LEVANTAMIENTOCAMPO),:idtc, :cr, :ft, :lt, :lng, :alt, :idup, :otro, :notif, :obs)");
        $rows = $stmt->execute(array(':idtc' => $idtareac, 
                                     ':cr' => $cr, 
                                     ':ft' => $ft,
                                     ':lt' => $lt,
                                     ':lng' => $lng,
                                     ':alt' => $alt,
                                     ':idup' => $idup,
                                     ':otro' => $otro,
                                     ':notif' => $notif,
                                     ':obs' => $obs));
//}else{
//       $stmt = $con->prepare("UPDATE catastro.LEVANTAMIENTOCAMPO SET 
//      ,CROQUIS=:cr 
//      ,FOTO=:ft 
//      ,LATITUD=:lt 
//      ,LONGITUD=:lng 
//      ,ALTITUD=:alt 
//      ,IDUSOPREDIO=:idup 
//      ,OTROUSO=:otro 
//      ,NOTIFICACION=:notif 
//      ,OBSERVACION=:obs WHERE IDTAREACAMPO=:idtc");
//  $rows = $stmt->execute(array(':idtc' => $idtareac, 
//                               ':cr' => $cr, 
//                               ':ft' => $ft,
//                               ':lt' => $lt,
//                               ':lng' => $lng,
//                               ':alt' => $alt,
//                               ':idup' => $idup,
//                               ':otro' => $otro,
//                               ':notif' => $notif,
//                               ':obs' => $obs));
//  }
  
  if( $rows == 1 ){
      $stmt6 = $con->prepare('SELECT IDLEVANTAMIENTOCAMPO FROM catastro.LEVANTAMIENTOCAMPO WHERE IDTAREACAMPO=:tc');
      $stmt6->execute(array(':tc' => $idtareac ));
  
      $row6 = $stmt6->fetch();
      echo '{"resp":"Success","idlc":"'.$row6[0].'"}';
  }
  
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

}

}

