<?php 

    include 'conn.php';

 	if(isset($_POST["telefono"])){
        $telefono = $_POST["telefono"];
    }
    if(isset($_POST["extencion"])){
        $extencion = $_POST["extencion"];
    }
    if(isset($_POST["NombreEme"])){
        $NombreEme = $_POST["NombreEme"];
    }
   


	if(isset($_POST["urlimagen"])){
            $urlimagen = $_POST["urlimagen"];
    }
    if(isset($_POST["image"])){
            $image = $_POST["image"];
    }

    $dir = "imgemergencia/".$urlimagen.".jpg";


try {

	$telefono = utf8_encode($telefono);   
    $extencion = utf8_encode($extencion);   
    $NombreEme = utf8_encode($NombreEme);   

	$cn = new Conexion();
	$con = $cn->Conectar();

	$stmt = $con->prepare("INSERT INTO dbo.MovilEmergencia VALUES (:telefono, :extencion, :imgurl, :Nombre)");
	$stmt->execute(array(
		':telefono' => $telefono,
		':extencion' => $extencion,
		':imgurl' => $dir,
		':Nombre' => $NombreEme
	 ));

	$decodedimage = base64_decode($image);
    file_put_contents($dir, $decodedimage);

    echo '[{"EXITO":"SI"}]';
	// echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

	$cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo '[{"EXITO":"'.$e->getMessage().'"}]';
}
?>