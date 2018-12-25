<?php
include 'conn.php';
  if(isset($_REQUEST['id_usuario'])){
      $id_usuario = $_REQUEST['id_usuario'];
  }
try {
	
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT SECCION_USUARIOS.idseccionusr,SECCION.idseccion,SECCION.seccion,TIPO_SECCION.ubicacion,MUNICIPIO.municipio 
FROM SECCION_USUARIOS 
inner join SECCION on SECCION.idseccion = SECCION_USUARIOS.idseccion
inner join TIPO_SECCION on TIPO_SECCION.idseccion = SECCION.idseccion
inner join MUNICIPIO on MUNICIPIO.idmunicipio = SECCION.idmunicipio
WHERE iappid = :iappid ORDER BY SECCION.seccion;");
  $stmt->execute(array(':iappid' => $id_usuario));
  $secciones = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  $final = array();

  $firstValue = 0;
  foreach ($secciones as $key => $value) {
  	
  	if ($firstValue!=$value["idseccion"]) {
  		    
      $firstValue=$value["idseccion"];

		  array_push($final, $value);
	  	 
  	}

  }
  



  echo json_encode($final);
  
  $cn->Desconectar($con, $stmt);

} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}
?>