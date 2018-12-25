<?php 

include 'conn.php';

if (isset($_POST['email'])) {
	$email = $_POST['email'];
}

try {

	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("SELECT * FROM MovilCiudadano where CorreoE = :email ;");
    $stmt->execute(array(':email' => $email ));
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