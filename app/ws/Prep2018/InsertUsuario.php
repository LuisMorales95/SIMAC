<?php
include 'conn.php';

  if(isset($_POST["nombre"])){
      $nombre = $_POST["nombre"];
  }
  if(isset($_POST["usuario"])){
      $usuario = $_POST["usuario"];
  }
  if(isset($_POST["contra"])){
      $contra = $_POST["contra"];
  }


  if(isset($_POST["ACuenta"])){
      $ACuenta = $_POST["ACuenta"];
  }
  if(isset($_POST["PerAdmin"])){
      $PerAdmin = $_POST["PerAdmin"];
  }
  if(isset($_POST["VGrafica"])){
      $VGrafica = $_POST["VGrafica"];
  }
  if(isset($_POST["CapturarInfo"])){
      $CapturarInfo = $_POST["CapturarInfo"];
  }


try {
	
	$nombre = utf8_encode($nombre);
	$usuario = utf8_encode($usuario);
	$contra = utf8_encode($contra);
	$ACuenta = utf8_encode($ACuenta);
	$PerAdmin = utf8_encode($PerAdmin);
	$VGrafica = utf8_encode($VGrafica);
	$CapturarInfo = utf8_encode($CapturarInfo);
  
  	$cn = new Conexion();
  	$con = $cn->Conectar();

  	$stmt = $con->prepare("INSERT INTO USUARIOS_WEB 
(iAppLogin, iAppNombre, iAppPwd, iAppActivo, iAppAdmin, iAppMobil, iAppCaptura, iAppGrafica, iAppMensaje, iAppUsrMobil, iAppPrivilegio) VALUES 
(:AppLogin, :AppNombre, :AppPwd, :AppActivo, :AppAdmin, '1', :AppCaptura, :AppGrafica,'0','1','0');");

  	$stmt->execute(array(
	  	':AppLogin' => $usuario,
	  	':AppNombre' => $nombre,
	  	':AppPwd' => $contra,
	  	':AppActivo' => $ACuenta,
	  	':AppAdmin' => $PerAdmin,
	  	':AppCaptura' => $CapturarInfo,
	  	':AppGrafica' => $VGrafica
  	));

  	$cn->Desconectar($con, $stmt);
  	echo '[{"EXITO":"SI"}]';

	} catch(PDOException $e) {
	  echo '[{"EXITO":"'.$e->getMessage().'"}]';
	}
?>