<?php
include 'conn.php';

if(isset($_POST["imagen"])){
    $imagen = $_POST["imagen"];
}
if(isset($_REQUEST["eleccion"])){
  $eleccion = $_REQUEST["eleccion"];
}
if(isset($_REQUEST["seccion"])){
  $seccion = $_REQUEST["seccion"];
}
if(isset($_REQUEST["tipo"])){
  $tipo = $_REQUEST["tipo"];
}

$token = token();
$dir = "Evidencia/".$token.".png"; 


try {
	$dir = utf8_encode($dir);

	$cn = new Conexion();
	$con = $cn->Conectar();

	$stmt = $con->prepare("UPDATE CONTEO_RAPIDO SET sabana = '".$dir."' WHERE idtipoeleccion = :elec and idseccion = :secc and idtipo = :tipo");
	$stmt->execute(array(':elec' => $eleccion,':secc' => $seccion,':tipo' => $tipo));

	$decodedimage = base64_decode($imagen);
	file_put_contents($dir, $decodedimage);
    echo '[{"EXITO":"SI"}]';

	$cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
	echo '[{"EXITO":"'.$e->getMessage().'"}]';
}




function token(){
	$UserID = "D89654";
	$token = md5(uniqid(microtime(), true));
	$token_time = time();
	$_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time);
	return $token;
}
?>