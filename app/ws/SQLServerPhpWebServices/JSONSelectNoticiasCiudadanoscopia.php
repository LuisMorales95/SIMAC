<?php
include 'conn.php';
  if(isset($_REQUEST['number'])){
      $number = $_REQUEST['number'];
   }
  if(isset($_REQUEST['id_usuario'])){
      $id_usuario = $_REQUEST['id_usuario'];
  }

 

try {
  $number = intval($number);
  $secondnumber= $number + 5;

  $cn = new Conexion();
  $con = $cn->Conectar();
  $stmt = $con->prepare("SELECT t.id_alerta, t.id, t.titulo, t.descripcion, t.fecha, t.ubicacion, t.alertaimg, t.longitud, t.latitud, t.Nombre, t.ApellidoP, t.ImgURL
FROM
(

SELECT 
dbo.MovilAlertas.id_alerta, 
dbo.MovilCiudadano.id, 
dbo.MovilAlertas.titulo, 
dbo.MovilAlertas.descripcion, 
dbo.MovilAlertas.fecha, 
dbo.MovilAlertas.ubicacion, 
dbo.MovilAlertas.alertaimg, 
dbo.MovilAlertas.longitud, 
dbo.MovilAlertas.latitud, 
dbo.MovilCiudadano.Nombre, 
dbo.MovilCiudadano.ApellidoP, 
dbo.MovilCiudadano.ImgURL,
ROW_NUMBER() OVER (ORDER BY dbo.MovilAlertas.id_alerta DESC ) AS Seq
  from dbo.MovilAlertas inner join dbo.MovilCiudadano on dbo.MovilAlertas.fk_id_Ciudadano = dbo.MovilCiudadano.Id inner join dbo.MovilCategoria
  on dbo.MovilAlertas.fk_id_categoria = dbo.MovilCategoria.id where dbo.MovilCategoria.id = 1 )t
WHERE Seq BETWEEN ".$number." AND ".$secondnumber.";");

  $stmt->execute();
  $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

  $Final = array();
  $like_value = 0;
  $comment_value = 0;
  foreach ($rows as $key => $value) {
    
        try {
            $stmt = $con->prepare("SELECT * FROM dbo.MovilTiene_reaccion WHERE fk_id_ciudadano = :ciudadano AND fk_id_alerta = :alerta");
            $stmt->execute(array(':ciudadano' => $id_usuario,':alerta' => $value["id_alerta"]));
            $rowlike = $stmt->fetch();
                if ($rowlike[3]=="1") {
                  $like_value = 1;
                }else{
                  $like_value = 0;
                }
        } catch (PDOException $e) {
              $like_value = 0;
        }

            $value += array('like' => strval($like_value));

        try {
            $stmt = $con->prepare("SELECT * FROM dbo.MovilComentario where fk_id_ciudadano = :id_usuario AND fk_id_alerta = :id_alerta");
            $stmt->execute(array(':id_usuario' => $id_usuario, ':id_alerta' => $value["id_alerta"]));
            $rowcomment = $stmt->rowCount();
                if ($rowcomment == 0) {
                  $comment_value = 0;
                }else{
                  $comment_value = 1;     
                }
        } catch(PDOException $e) {
              $comment_value = 0;
        }

            $value += array('comment' => strval($comment_value));
            
            array_push($Final, $value);

  }

  echo json_encode($Final);

  $cn->Desconectar($con, $stmt);
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>
