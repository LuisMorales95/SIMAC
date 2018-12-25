<?php
include 'conn.php';

if(isset($_POST['nombre'])){
    $nombre = $_POST['nombre'];
}
if(isset($_POST['ApellidoM'])){
    $ApellidoM = $_POST['ApellidoM'];
}
if(isset($_POST['fecha'])){
    $fecha = $_POST['fecha'];
}
if(isset($_POST['sexo'])){
    $sexo = $_POST['sexo'];
}
if(isset($_POST['telefono'])){
    $telefono = $_POST['telefono'];
}
if(isset($_POST['direccion'])){
    $direccion = $_POST['direccion'];
}
if(isset($_POST['numext'])){
    $numext = $_POST['numext'];
}
if(isset($_POST['colonia'])){
    $colonia = $_POST['colonia'];
}
if(isset($_POST['correo'])){
    $correo = $_POST['correo'];
}

// use PHPMailer\PHPMailer\PHPMailer;
// use PHPMailer\PHPMailer\Exception;

// require 'PHPMailer/src/Exception.php';
// require 'PHPMailer/src/PHPMailer.php';
// require 'PHPMailer/src/SMTP.php';

// $mail = new PHPMailer(true);
$rancode = getRandomCode();
  try {
    $nombre = utf8_encode($nombre);
    $ApellidoM = utf8_encode($ApellidoM);
    $fecha = utf8_encode($fecha);
    $sexo = utf8_encode($sexo);
    $telefono = utf8_encode($telefono);
    $direccion = utf8_encode($direccion);
    $numext = utf8_encode($numext);
    $colonia = utf8_encode($colonia);
    $correo = utf8_encode($correo);
    $rancode =  utf8_decode($rancode);

    $cn = new Conexion();
    $con = $cn->Conectar();
    

    $stmt = $con->prepare("select * from dbo.MovilCiudadano where CorreoE = :correo");
    $stmt->execute(array(':correo' => $correo));
    $num_rows = $stmt->fetch();
    if ($num_rows>0) {
        echo '[{"EXITO":"NOVALIDO"}]';
    }else{
      $stmt = $con->prepare("INSERT INTO dbo.MovilCiudadano (Nombre,ApellidoP,fechaNac,Sexo,Telefono,Direccion,NumeroExt,IdColonia,CorreoE,ImgURL,fk_id_rol,Verificacion_Usuario) values (:Nombre, :ApellidoP, :fechaNac, :Sexo, :Telefono, :Direccion, :NumeroExt, :IdColonia, :CorreoE,'profilpic/icon.png','1',0);");
      $stmt->execute(array(':Nombre' => $nombre,':ApellidoP' => $ApellidoM,':fechaNac' => $fecha,':Sexo' => $sexo,':Telefono' => $telefono,':Direccion' => $direccion,':NumeroExt' => $numext,':IdColonia' => $colonia,':CorreoE' => $correo));

        echo '[{"EXITO":"SI"}]';

        // $mail->SMTPDebug = 2;
        //     $mail->isSMTP();     
        //     $mail->Host = 'smtp.gmail.com';
        //     $mail->SMTPAuth = true;        
        //     $mail->Username = 'simacappdevelopment@gmail.com';
        //     $mail->Password = '496e443376336c30706d656e745331386132'; 
        //     $mail->SMTPSecure = 'tls';
        //     $mail->Port = 587;                  
        //     $mail->isHTML(true);                
        //     $mail->Subject = 'Verificacion SIMAC';
        //     $mail->Body    = 'Codigo de Verificacion:-->'.$rancode.'<--';
        //     $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
        //     $mail->setFrom('simacappdevelopment@gmail.com', 'SIMAC Correo de Verificacion');
        //     $mail->addAddress($correo, $nombre);
        //     $mail->send();

    }

    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
     error(1,'Error: ' . $e->getMessage());
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
  }



function getRandomCode(){
    $an = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $su = strlen($an) - 1;
    return substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1).
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1) .
            substr($an, rand(0, $su), 1);
}

function error($numero,$texto){
$ddf = fopen('Error.log','a');
fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
fclose($ddf);
}

 ?>
