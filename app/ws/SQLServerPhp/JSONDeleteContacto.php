<?php 
include 'conn.php';

if (isset($_POST['emer'])) {
    $id_emergencia = $_POST['emer'];
}

try {
	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("DELETE FROM dbo.MovilEmergencia WHERE dbo.MovilEmergencia.id_emergencia= :id_e;");
    $stmt->execute(array(':id_e' => $id_emergencia));
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