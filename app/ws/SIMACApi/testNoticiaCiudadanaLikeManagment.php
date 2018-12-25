<?php
include 'conn.php';
  //  if(isset($_REQUEST['number'])){
  //      $number = $_REQUEST['number'];
  //  }
  // if(isset($_REQUEST['id_usuario'])){
  //     $id_usuario = $_REQUEST['id_usuario'];
  // }
  $number = "5";
  $id_usuario = 1353;
try {

  $number = intval($number);
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("select dbo.Noticia.id, dbo.Noticia.titulo, dbo.Noticia.descripcion, dbo.Noticia.fecha, dbo.Noticia.ubicacion, dbo.Noticia.noticiaimg, dbo.Noticia.longitud, dbo.Noticia.latitud, dbo.Ciudadano.Nombre, dbo.Ciudadano.ApellidoP, dbo.Ciudadano.ImgURL
  from dbo.Noticia inner join dbo.Ciudadano on dbo.Noticia.fk_id_Ciudadano = dbo.Ciudadano.Id inner join dbo.NoticiaCategoria
  on dbo.Noticia.fk_id_categoria = dbo.NoticiaCategoria.id where dbo.NoticiaCategoria.id = 1  ORDER BY dbo.Noticia.id  DESC OFFSET ".$number."ROWS
  FETCH NEXT 5 ROWS ONLY ;");
  // $stmt->bindParam(':numeroprox', $number, PDO::PARAM_INT);

  $stmt->execute();
  $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

  $Final = array();
  $like_value = 0;
  foreach ($rows as $key => $value) {
    // echo "==============================>";
    // echo "<br>";
    // echo "<br>";
    // echo "<br>";
    // print_r($value);
    // echo "<br>";
    // echo $value["id"];
    // echo "<br>";
    // echo "<br>";
        try {

            $stmt = $con->prepare("SELECT * FROM dbo.tiene_reaccion WHERE fk_id_ciudadano = :ciudadano AND fk_id_noticia = :noticia");
            $stmt->execute(array(':ciudadano' => $id_usuario,':noticia' => $value["id"]));
            // echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
            $rowlike = $stmt->fetch();
            // echo $row[3];
            if ($rowlike[3]=="1") {
              $like_value = 1;
            }else{
              $like_value = 0;
            }
        } catch (PDOException $e) {
            // echo '[{"EXITO":"'.$e->getMessage().'"}]';
        }
    // echo "<br>";
    // echo "<br>";
    // array_push($value, $like_value);
    $value += array('like' => strval($like_value));
    // echo json_encode($value);
    array_push($Final, $value);
    // echo "<br>";
    // echo "<br>";
    // echo "<br>";
    // echo "<br>";
    // echo "<br>";
    // echo "==============================>";
  }

  // echo "<br>";
  // echo "<br>";
  // echo "<br>";
  echo json_encode($Final);


  // echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
  // echo "<br>";
  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>