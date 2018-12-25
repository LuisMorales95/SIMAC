<?php
include 'conn.php';

if(isset($_POST['number'])){
     $number = $_POST['number'];
 }

try {
    $number = intval($number);
    $cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("SELECT dbo.MovilAlertas.id_alerta, dbo.MovilAlertas.titulo, dbo.MovilAlertas.descipcion, dbo.MovilAlertas.fecha, dbo.MovilAlertas.ubicacion, dbo.MovilAlertas.noticiaimg,
    dbo.MovilCiudadano.Nombre, dbo.MovilCiudadano.ApellidoP, dbo.MovilCiudadano.ImgURL
    from dbo.MovilAlertas inner join dbo.MovilCiudadano on dbo.MovilAlertas.fk_id_Ciudadano = dbo.MovilCiudadano.Id inner join dbo.MovilCategoria on dbo.MovilAlertas.fk_id_categoria = dbo.MovilCategoria.id where dbo.MovilCategoria.id = 1 ORDER BY dbo.MovilAlertas.id  DESC OFFSET ".$number."ROWS
    FETCH NEXT 5 ROWS ONLY ;");
    $stmt->execute();

  echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

?>
