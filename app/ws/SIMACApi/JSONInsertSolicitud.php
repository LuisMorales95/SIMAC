<?php 

    include 'conn.php';

 	if(isset($_POST["fk_id_ciudadano"])){
        $id_ciudadano = $_POST["fk_id_ciudadano"];
    }
    if(isset($_POST["fk_id_colonia"])){
        $id_colonia = $_POST["fk_id_colonia"];
    }
    if(isset($_POST["problema"])){
      $problema = $_POST["problema"];
    }
    if(isset($_POST["direccion"])){
        $direccion = $_POST["direccion"];
    }
    if(isset($_POST["referencia1"])){
        $referencia1 = $_POST["referencia1"];
    }
    if(isset($_POST["referencia2"])){
        $referencia2 = $_POST["referencia2"];
    }
	if(isset($_POST["fecha"])){
            $fecha = $_POST["fecha"];
    }


	if(isset($_POST["urlimagen"])){
            $urlimagen = $_POST["urlimagen"];
    }
    if(isset($_POST["image"])){
            $image = $_POST["image"];
    }

    $codigounico=getRandomCode();

    $dir = "imgSolicitudes/".$urlimagen.$codigounico.".jpg";


    // $dir = "imgSolicitudes/".$urlimagen.".jpg";

    if(isset($_POST["longitud"])){
            $longitud = $_POST["longitud"];
    }
    if(isset($_POST["latitud"])){
            $latitud = $_POST["latitud"];
    }

try {

	$problema = utf8_encode($problema);   
    $direccion = utf8_encode($direccion);   
    $referencia1 = utf8_encode($referencia1);   
    $referencia2 = utf8_encode($referencia2);
    $fecha = utf8_encode($fecha);

	$cn = new Conexion();
	$con = $cn->Conectar();

	$stmt = $con->prepare("INSERT INTO dbo.MovilSolicitud_Temp OUTPUT Inserted.ID VALUES (:idCiudadano, :idColonia, :problema, :direccion, :referencia1, :referencia2, :fechahora, :imgurl, 1,:longitud,:latitud);");
	$stmt->execute(array(
		':idCiudadano' => $id_ciudadano,
		':idColonia' => $id_colonia,
		':problema' => $problema,
		':direccion' => $direccion,
		':referencia1' => $referencia1,
		':referencia2' => $referencia2,
		':fechahora' => $fecha,
		':imgurl' => $dir,
        ':longitud' => $longitud,
        ':latitud' => $latitud
	 ));
	$ReturnedValues = $stmt->fetch();
	$idReturned = $ReturnedValues[0];

	$stmt = $con->prepare("SELECT Nombre_completo=Nombre+' '+ApellidoP,CorreoE, Telefono from MovilCiudadano where id= :idpersona ");
	$stmt->execute(array(':idpersona' => $id_ciudadano));
	$row = $stmt->fetch();
	$nombre_com = $row[0];
	$correo_com = $row[1];
	$telefono_com = $row[2];
	$stmt = $con->prepare("INSERT into SolicitudTempMovil (idtmp, nombrecompleto, idcolonia, direccion, telefono, correoe, problema, idcoloniap, ref01, ref02, eliminado, img_solicitud, logintud, latitud) values (:idtemporal, :nomcom , 1 , :direccion , :telefono , :correo , :problema , 1 , :ref1 , :ref2, 0 , :dirimagen , :longitud , :latitud );");
	$stmt->execute(array(
		':idtemporal' => $idReturned,
		':nomcom' => $nombre_com,
		':direccion' => $direccion,
		':telefono' => $telefono_com,
		':correo' => $correo_com,
		':problema' => $problema,
		':ref1' => $referencia1,
		':ref2' => $referencia2,
		':dirimagen' => $dir,
		':longitud' => $longitud,
		':latitud' => $latitud,
	
	));


	$decodedimage = base64_decode($image);
    file_put_contents($dir, $decodedimage);

    echo '[{"EXITO":"SI"}]';
	// echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

	$cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo '[{"EXITO":"'.$e->getMessage().'"}]';
}


function getRandomCode(){
    $an = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $su = strlen($an) - 1;
    return substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1);
}



?>