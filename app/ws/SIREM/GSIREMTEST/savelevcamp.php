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
   $vd = $body['VD'];

//CROQUIS ImageCroq
$nombrecroquis="";
if ($body['ImageCroq']!="") {
 $nombrecroquis=getRandomCode().".jpg";
}
$crb = "croquis/".$nombrecroquis;
$crr = "C:/inetpub/wwwroot/gsirem.com/perote.gsirem.com/131/croquis/".$nombrecroquis;

$imsrc0 = str_replace(' ','+',$body['base640']);
$imsrc0 = base64_decode($imsrc0);
$fp0 = fopen($crr, 'w');
fwrite($fp0, $imsrc0);

//IMAGEN DE CAMARA
$ftb = "fotos/".$body['ImageFoto'];
$ftr = "C:/inetpub/wwwroot/gsirem.com/perote.gsirem.com/131/fotos/".$body['ImageFoto'];

$imsrc1 = str_replace(' ','+',$body['base641']);
$imsrc1 = base64_decode($imsrc1);
$fp1 = fopen($ftr, 'w');
fwrite($fp1, $imsrc1);


try {
 
      $stmt = $con->prepare("INSERT INTO catastro.LEVANTAMIENTOCAMPO(
        IDTAREACAMPO,CROQUIS,FOTO,LATITUD,LONGITUD,ALTITUD,IDUSOPREDIO,OTROUSO,NOTIFICACION,OBSERVACION
      ) VALUES (
      :idtc, :cr, :ft, :lt, :lng, :alt, :idup, :otro, :notif, :obs)");
        $rows = $stmt->execute(array(':idtc' => $idtareac, 
                                     ':cr' => $crb, 
                                     ':ft' => $ftb,
                                     ':lt' => $lt,
                                     ':lng' => $lng,
                                     ':alt' => $alt,
                                     ':idup' => $idup,
                                     ':otro' => $otro,
                                     ':notif' => $notif,
                                     ':obs' => $obs));

	$stmt9 = $con->prepare('UPDATE catastro.TAREACAMPO SET ESTATUS=:v WHERE IDTAREACAMPO=:tc');
  $rows9 = $stmt9->execute(array(':tc' => $idtareac ,':v' => $vd ));								 
  
  if( $rows9 == 1 ){
      $stmt6 = $con->prepare('SELECT IDLEVANTAMIENTOCAMPO FROM catastro.LEVANTAMIENTOCAMPO WHERE IDTAREACAMPO=:tc');
      $stmt6->execute(array(':tc' => $idtareac ));
  
      $row6 = $stmt6->fetch();
      echo '{"resp":"Success","idlc":"'.$row6[0].'"}';
  }
  
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  //echo 'Error: ' . $e->getMessage();
  error(1,'Error: ' . $e->getMessage());
}

}

}

function error($numero,$texto){
$ddf = fopen('error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}
   
function getRandomCode(){
    $an = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $su = strlen($an) - 1;
    return substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1);
}

