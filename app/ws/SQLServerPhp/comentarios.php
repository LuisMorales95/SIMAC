<?php 
include 'conn.php';

if (isset($_POST['id_noticia'])) {
    $id_noticia = $_POST['id_noticia'];
}

try {
	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("SELECT dbo.MovilComentario.id_comentario, dbo.MovilCiudadano.id, dbo.MovilCiudadano.ImgURL, dbo.MovilCiudadano.Nombre,dbo.MovilCiudadano.ApellidoP,dbo.MovilComentario.comentario,dbo.MovilComentario.fecha FROM dbo.MovilComentario INNER JOIN dbo.MovilCiudadano on dbo.MovilComentario.fk_id_ciudadano=dbo.MovilCiudadano.Id WHERE fk_id_alerta = :id_noticia ORDER BY dbo.MovilComentario.id_comentario desc");

    $stmt->execute(array(':id_noticia' => $id_noticia));

    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

	} catch (PDOException $e) {
	    echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}
 ?>