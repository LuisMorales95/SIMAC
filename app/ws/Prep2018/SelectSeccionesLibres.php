<?php
include 'conn.php';
  if(isset($_REQUEST['id_usuario'])){
      $id_usuario = $_REQUEST['id_usuario'];
  }
try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT SECCION.idseccion, SECCION.seccion, TIPO_SECCION.ubicacion, MUNICIPIO.municipio from SECCION 
inner join TIPO_SECCION on TIPO_SECCION.idseccion = SECCION.idseccion 
inner join MUNICIPIO on MUNICIPIO.idmunicipio = SECCION.idmunicipio
order by SECCION.seccion;");
  $stmt->execute();
  $secciones = $stmt->fetchAll(PDO::FETCH_ASSOC);

  $stmt = $con->prepare("SELECT * FROM SECCION_USUARIOS WHERE iappid = :iappid ORDER BY SECCION_USUARIOS.idseccion;");
  $stmt->execute(array(':iappid' => $id_usuario));
  $secciones_owned = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  $final = array();




  $firstValue=0;
  foreach ($secciones as $key => $value) {
  	
  	if ($firstValue!=$value["idseccion"]) {
  		
		$firstValue=$value["idseccion"];
		$si_encontro = 0; 
  
	  	foreach ($secciones_owned as $key => $value_owned) {
	  
	  		if ($value["idseccion"]==$value_owned["idseccion"]) {
	  			$si_encontro++; 	
	  		}
	  
	  	}
  
	  	if ($si_encontro=="0") {
	  
	  		$si_encontro=0;
	  		array_push($final, $value);

	  	 }
  	}

  }
  



  echo json_encode($final);
  
  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>