<?php
include 'conn.php';
	if(isset($_POST["idusuario"])){
        $idusuario = $_POST["idusuario"];
    }
    if(isset($_POST["nombre"])){
        $nombre = $_POST["nombre"];
    }
    if(isset($_POST["usuario"])){
        $usuario = $_POST["usuario"];
    }
    if(isset($_POST["passwd"])){
        $passwd = $_POST["passwd"];
    }
    if(isset($_POST["activo"])){
        $activo = $_POST["activo"];
    }
    if(isset($_POST["admin"])){
        $admin = $_POST["admin"];
    }
    if(isset($_POST["grafica"])){
        $grafica = $_POST["grafica"];
    }
    if(isset($_POST["captura"])){
        $captura = $_POST["captura"];
    }
try {
  $cn = new Conexion();
  $con = $cn->Conectar();
  $stmt = $con->prepare("UPDATE USUARIOS_WEB SET iAppLogin= :usu ,iAppNombre= :nom ,iAppPwd= :pass ,iAppActivo= :activo ,iAppAdmin= :admin ,iAppGrafica= :grafica ,iAppCaptura= :captura WHERE iAppID = :idusu ;");
  $stmt->execute(array(':usu'=>$usuario,':nom'=>$nombre, ':pass'=>$passwd,':activo'=>$activo, ':admin'=>$admin,':grafica'=>$grafica, ':captura'=>$captura, ':idusu'=>$idusuario));

  echo '[{"EXITO":"SI"}]';

  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo '[{"EXITO":"'.$e->getMessage().'"}]';
}
?>