<?php 
include 'conn.php';

if (isset($_POST['id_comentario'])) {
    $id_comentario = $_POST['id_comentario'];
}

try {
	$cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("DELETE FROM dbo.MovilComentario WHERE dbo.MovilComentario.id_comentario= :id_comment;");
    $stmt->execute(array(':id_comment' => $id_comentario));
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