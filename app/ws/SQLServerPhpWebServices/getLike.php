<?php 
include 'conn.php';

if (isset($_POST['id_usuario'])) {
    $id_usuario = $_POST['id_usuario'];
}

if (isset($_POST['id_noticia'])) {
    $id_noticia = $_POST['id_noticia'];
}

try {

	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("SELECT * FROM dbo.MovilTiene_reaccion WHERE fk_id_ciudadano = :ciudadano AND fk_id_alerta = :noticia");
    
    $stmt->execute(array(':ciudadano' => $id_usuario,':noticia' => $id_noticia));
    // echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
    $row = $stmt->fetch();
    // echo $row[3];
    if ($row[3]=="1") {
		echo '[{"EXITO":"SI"}]';
    	# code...
    }else{
		echo '[{"EXITO":"NO"}]';

    }
    

} catch (PDOException $e) {
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
}



 ?>