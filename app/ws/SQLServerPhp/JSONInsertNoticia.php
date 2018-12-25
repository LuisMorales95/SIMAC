  <?php
        include 'conn.php';

        if(isset($_POST["titulo"])){
            $titulo = $_POST["titulo"];
        }
        if(isset($_POST["descripcion"])){
            $descripcion = $_POST["descripcion"];
        }
        if(isset($_POST["fecha"])){
            $fecha = $_POST["fecha"];
        }
        if(isset($_POST["direccion"])){
            $direccion = $_POST["direccion"];
        }
        if(isset($_POST["idcategoria"])){
            $idcategoria = $_POST["idcategoria"];
        }
        if(isset($_POST["idusuario"])){
            $idusuario = $_POST["idusuario"];
        }

        if(isset($_POST["name"])){
            $name = $_POST["name"];
        }
        if(isset($_POST["image"])){
            $image = $_POST["image"];
        }
        if (isset($_POST["long"])) {
          $long = $_POST["long"];
        }
        if (isset($_POST["lat"])) {
          $lat = $_POST["lat"];
        }
        $dir = "imagen/".$name.".jpg";


  try {
    $titulo = utf8_encode($titulo);
    $descripcion = utf8_encode($descripcion);
    $fecha = utf8_encode($fecha);
    $direccion = utf8_encode($direccion);
    $dir = utf8_encode($dir);


    $cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("INSERT INTO dbo.MovilAlertas (titulo,descripcion,fecha,ubicacion,alertaimg,longitud,latitud,fk_id_categoria,fk_id_ciudadano) VALUES (:titulo, :descrip, :fecha, :ubica, :dirimagen, :long, :lat, :fkcat, :fkusu);");
    $stmt->execute(array(':titulo' => $titulo, ':descrip' => $descripcion, ':fecha' => $fecha, ':ubica' => $direccion, ':dirimagen' => $dir, ':long' => $long, ':lat' => $lat, ':fkcat' => $idcategoria, ':fkusu' => $idusuario));

    $decodedimage = base64_decode($image);
    file_put_contents($dir, $decodedimage);
    $cn->Desconectar($con, $stmt);



           $cn = new Conexion();
           $con = $cn->Conectar();

           $stmt = $con->prepare("SELECT id, tokennotif from MovilCiudadano where MovilCiudadano.id <> :id and MovilCiudadano.tokennotif <> 'null' and MovilCiudadano.tokennotif <> '';");
           $stmt->execute(array(':id' => $idusuario ));
           $token= array();
           $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

           if ($data > 0) {
             foreach ($data as $row) {
               $token[]= $row["tokennotif"];
               # code...
             }
           }
           $concatitulo="";
           $parts = explode(' ', $titulo);
           for ($i=0; $i < count($parts) ; $i++) {
             $concatitulo.=$parts[$i]."~";
           }
           $concatmen="";
           $parts = explode(' ', $descripcion.' '.$name);
           for ($i=0; $i < count($parts) ; $i++) {
             $concatmen.=$parts[$i]."~";
           }

           // $titulop = "algunmensaje";
           // $menp = "algunmensaje";
           $message = array
           (
             'id' => 'algo',
             'body' => $concatmen,
             'title' => $concatitulo
           );

           $cn->Desconectar($con, $stmt);
           send_notification($token, $message);


    echo '[{"EXITO":"SI"}]';

  } catch(PDOException $e) {
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
  }


  function send_notification($token, $mensaje){
        $url = 'https://fcm.googleapis.com/fcm/send';
        $fields =  array(
          'registration_ids' => $token,
          'data' => $mensaje
        );
        $headers = array(
          'Authorization:key = AAAAvVhIjLg:APA91bE-0wLKazcuJueg8YymcLX2yHx40fqttmYI4MflNhlHV_XXh4mda45MhAkugn1uNzqK-zu2j9NRIhSUaVY6VWGbyTGr3PO-ke1obuEVMaqyR7r0Gab-CEIS4gtUtTjz_Xi646c2',
          'Content-Type: application/json'
        );


     $ch = curl_init();
     curl_setopt($ch, CURLOPT_URL, $url);
     curl_setopt($ch, CURLOPT_POST, true);
     curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
     curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
     curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
     curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
     curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
     // echo json_encode($fields);
     curl_exec($ch);

     curl_close($ch);
   }


   ?>
