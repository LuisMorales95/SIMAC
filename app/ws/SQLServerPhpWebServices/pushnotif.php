<?php
include 'conn.php';
if(isset($_REQUEST['id'])){
    $id = $_REQUEST['id'];
}
// if(isset($_REQUEST['t'])){
//     $titulo = $_REQUEST['t'];
// }if(isset($_REQUEST['m'])){
//     $men = $_REQUEST['m'];
// }
 $titulo='alguntitulo';
 $men = 'algunmensaje';

     try {
       $cn = new Conexion();
       $con = $cn->Conectar();

       $stmt = $con->prepare("select id, tokennotif from Ciudadano where Ciudadano.id <> :id and Ciudadano.tokennotif <> 'null' and Ciudadano.tokennotif <> '';");
       $stmt->execute(array(':id' => $id ));
       $token= array();
       $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

       if ($data > 0) {
         foreach ($data as $row) {
           $token[]= $row["tokennotif"];
           # code...
         }
       }
       $cn->Desconectar($con, $stmt);
       $message = array
       (
         'id' => 'algo',
         'body' => $men,
         'title' => $titulo
       );

       $message_status = send_notification($token, $message);
       echo $message_status;
       echo '[{"EXITO":"SI"}]';


     } catch(PDOException $e) {
       echo '[{"EXITO":"'.$e->getMessage().'"}]';
     }


     function send_notification($token, $mensaje)
     {
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
        $result = curl_exec($ch);
        if ($result === FALSE) {
            die('Curl failed: ' . curl_error($ch));
        }
        curl_close($ch);
        return $result;
      }

 ?>
