<?php 
include 'conn.php';

if (isset($_POST['id_usuario'])) {
    $id_usuario = $_POST['id_usuario'];
}

if (isset($_POST['id_noticia'])) {
    $id_noticia = $_POST['id_noticia'];
}

if (isset($_POST['id_reaccion'])) {
    $id_reaccion = $_POST['id_reaccion'];
}

if (isset($_POST['opcion'])) {
    $opcion = $_POST['opcion'];
}

if ($opcion=="1") {
	try {
	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("DELETE FROM dbo.MovilTiene_reaccion WHERE fk_id_ciudadano=:ciudadano AND fk_id_alerta = :noticia;");
    $stmt->execute(array(':ciudadano' => $id_usuario,':noticia' => $id_noticia));
    $count = $stmt->rowCount();
	
	    if ($count > 0) {
	    	echo '[{"EXITO":"SI BORRO"}]';
	    }else{
			echo '[{"EXITO":"NO BORRO"}]';
	    }
	
	} catch (PDOException $e) {
	    echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}

}elseif ($opcion == "0") {
	try {
	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("INSERT INTO dbo.MovilTiene_reaccion VALUES (:ciudadano, :noticia, :reaccion);");
    $stmt->execute(array(':ciudadano'=>$id_usuario, ':noticia'=>$id_noticia, ':reaccion'=>$id_reaccion));
    $count = $stmt->rowCount();
	
	    if ($count > 0) {
	    	echo '[{"EXITO":"SI CREEO"}]';
	    }else{
			echo '[{"EXITO":"NO CREEO"}]';
	    }
	
	} catch (PDOException $e) {
	    echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}
	# code...
}

?>