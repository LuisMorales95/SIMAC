<?php 
include 'conn.php';

if (isset($_POST['id_noticia'])) {
    $id_noticia = $_POST['id_noticia'];
}
if (isset($_POST['id_usuario'])) {
    $id_usuario = $_POST['id_usuario'];
}
if (isset($_POST['comentario'])) {
    $comentario = $_POST['comentario'];
}
if (isset($_POST['fecha'])) {
    $fecha = $_POST['fecha'];
}

try {
	
	$comentario = utf8_encode($comentario);

	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("INSERT INTO dbo.MovilComentario VALUES (:comentario,:fecha,:id_alerta,:id_usuario);");

    $stmt->execute(array(':comentario' => $comentario,':fecha' => $fecha,':id_alerta' => $id_noticia,':id_usuario' => $id_usuario));

	echo '[{"EXITO":"SI"}]';

	} catch (PDOException $e) {
	    echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}
 ?>