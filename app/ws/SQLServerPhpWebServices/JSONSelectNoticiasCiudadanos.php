<?php
include 'conn.php';
  if(isset($_POST['number'])){
       $number = $_POST['number'];
   }
 
try {

  $number = intval($number);
  $secondnumber= $number + 5;

  $cn = new Conexion();
  $con = $cn->Conectar();
  

  $stmt = $con->prepare("SELECT t.id_alerta, t.titulo, t.descripcion, t.fecha, t.ubicacion, t.alertaimg, t.longitud, t.latitud, t.Nombre, t.ApellidoP, t.ImgURL
FROM
(
SELECT 
dbo.MovilAlertas.id_alerta,
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
  on dbo.MovilAlertas.fk_id_categoria = dbo.MovilCategoria.id where dbo.MovilCategoria.id = 1 
)t
WHERE Seq BETWEEN ".$number." AND ".$secondnumber.";");

  $stmt->execute();

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>

<!-- OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY ; -->
