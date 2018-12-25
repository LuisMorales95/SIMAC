<?php
session_start();
include 'Conexion.php';

$tk = '';
//967acc4d22c2087303fca97c44a0910f

if($_SERVER['REQUEST_METHOD'] == 'POST') {

//Decodificando formato Json
$body = json_decode(file_get_contents("php://input"), true);

if(isset($body['token'])){
  $cn = new Conexion();
  $con = $cn->Conectar();
  
  $stmt0 = $con->prepare('SELECT TOKEN FROM seguridad.USUARIO WHERE TOKEN=:tk');
  $stmt0->execute(array(':tk' => $body['token'] ));
  
  $row = $stmt0->fetch();
 
  if($row[0] != $body['token']){ return;}
  
   $cc = $body['cc'];
   $tp = $body['tp'];
   $idb = $body['idb'];
   $lt = $body['lt'];
   $lng = $body['lng'];
   $fc = $body['fc'];
   $hr = $body['hr'];
   $obs = $body['obs'];
   $idnot1 = $body['not1'];
   $idnot2 = $body['not2'];


//IMAGEN DE CAMARA
$ftx = "103/fotos/".$body['ImageFoto'];
$ft = "C:/inetpub/wwwroot/Portalsirem/perote/131/fotos/".$body['ImageFoto'];

$imsrc1 = str_replace(' ','+',$body['base641']);
$imsrc1 = base64_decode($imsrc1);
$fp1 = fopen($ft, 'w');
fwrite($fp1, $imsrc1);


try {
 

      $stmt = $con->prepare("INSERT INTO catastro.REZAGOTMP(ID,
	CLAVECATASTRAL,
	TIPOPREDIO,
	IDBRIGADISTA,
	HORA,
	FECHA,
	LAT,
	LNG,
	FOTO,
	COMENTARIO,
	IDNOT1,
	IDNOT2) VALUES ((SELECT count(*)+1 AS T FROM catastro.REZAGOTMP),:cc, :tp, :idb, :hr, :fc, :lt, :lng, :ft, :obs, :not1, :not2)");
        $rows = $stmt->execute(array(':cc' => $cc, 
                                     ':tp' => $tp, 
                                     ':idb' => $idb,
									 ':hr' => $hr,
									 ':fc' => $fc,
                                     ':lt' => $lt,
                                     ':lng' => $lng,
                                     ':ft' => $ftx,
                                     ':obs' => $obs,
									 ':not1' => $idnot1,
									 ':not2' => $idnot2));

  
  if( $rows == 1 ){
      echo '{"resp":"1"}';
  }
  
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

}

}

