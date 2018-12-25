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
if(isset($_POST['contrasena'])){
    $contrasena = $_POST['contrasena'];
}


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
    $contrasena = utf8_encode($contrasena);


    $cn = new Conexion();
    $con = $cn->Conectar();

    $stmt = $con->prepare("select * from dbo.Ciudadano where CorreoE = :correo");
    $stmt->execute(array(':correo' => $correo));
    $num_rows = $stmt->fetch();
    if ($num_rows>0) {
        echo '[{"EXITO":"NOVALIDO"}]';
    }else{
      $stmt = $con->prepare("INSERT INTO dbo.MovilCiudadano (Nombre,ApellidoP,fechaNac,Sexo,Telefono,Direccion,NumeroExt,IdColonia,CorreoE,Contraseña,ImgURL,fk_id_rol, Usuario_Verificado) values (:Nombre, :ApellidoP, :fechaNac, :Sexo, :Telefono, :Direccion, :NumeroExt, :IdColonia, :CorreoE, :Contrasena,'profilpic/icon.png','1',0);");
      $stmt->execute(array(':Nombre' => $nombre,':ApellidoP' => $ApellidoM,':fechaNac' => $fecha,':Sexo' => $sexo,':Telefono' => $telefono,':Direccion' => $direccion,':NumeroExt' => $numext,':IdColonia' => $colonia,':CorreoE' => $correo,':Contrasena' => $contrasena));
      echo '[{"EXITO":"SI"}]';
    }
    $cn->Desconectar($con, $stmt);

  } catch(PDOException $e) {
    echo '[{"EXITO":"'.$e->getMessage().'"}]';
  }



 ?>
