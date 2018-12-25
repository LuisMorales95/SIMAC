<?php 

include 'conn.php';

if (isset($_POST['telefono'])) {
	$telefono = $_POST['telefono'];
}

try {
    $telefono = utf8_encode($telefono);

	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("UPDATE dbo.MovilCiudadano SET Verificacion_Usuario = 1 WHERE Telefono = :phone ");
    $stmt->execute(array(':phone' => $telefono ));
    $count = $stmt->rowCount();
	
	    if ($count > 0) {
	    	echo '[{"EXITO":"SI"}]';
	    }else{
			echo '[{"EXITO":"NO"}]';
	    }
	
	} catch (PDOException $e) {
	    echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}


?>