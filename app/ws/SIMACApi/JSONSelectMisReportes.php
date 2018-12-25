<?php
include 'conn.php';

    if(isset($_REQUEST["id_ciudadano"])){
      $id_ciudadano = $_REQUEST["id_ciudadano"];
    }

try {

  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT * FROM dbo.MovilSolicitud_Temp WHERE fk_id_ciudadano = :idfkciudadano order by id desc;");
  $stmt->execute(array('idfkciudadano' => $id_ciudadano ));
  $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

  $Final = array();
  $like_value = "";
  foreach ($rows as $key => $value) {
        try {
            $stmt = $con->prepare("exec [dbo].[proc_GetConsultarByIdSolicitudMobil] :idsolicitudtemp");
            $stmt->execute(array(':idsolicitudtemp' => $value["id"]));
            $rowlike = $stmt->fetch();
            if ($rowlike[2]<>null) {
              $value += array('Estado' => $rowlike[2]);
              array_push($Final, $value);
            }else{
              $value += array('Estado' => "");
              array_push($Final, $value);
            }
        } catch (PDOException $e) {
            echo '[{"EXITO":"'.$e->getMessage().'"}]';
        }
    
  }

  echo json_encode($Final);

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>