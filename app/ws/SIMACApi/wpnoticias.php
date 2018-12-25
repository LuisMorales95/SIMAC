<?php
include 'ConexionWP.php';

try {
  $cn = new Conexion();
  $con = $cn->Conectar();
  //ID=454
  //post_parent=0 ORDER BY ID DESC LIMIT 10
  $fn = Array();
  //WHERE post_content <> '' AND post_title NOT LIKE '%[{{{site.name}}}]%' AND post_date > '2017-12-31 00:43:43' AND post_parent=0
  //post_parent=0 AND post_content<>"" ORDER BY ID DESC LIMIT 50
  
  $stmt0 = $con->prepare("SELECT ID, post_content FROM wp_ad2018posts WHERE post_content <> '' AND post_title NOT LIKE '%[{{{site.name}}}]%' AND post_date > '2017-12-31 00:43:43' AND post_parent=0 ORDER BY ID DESC LIMIT 10");
  $stmt0->execute();
  
   while($datos = $stmt0->fetch()){
	
	 $stmt1 = $con->prepare('SELECT ID, post_title, guid, post_date, post_content, post_parent, post_mime_type FROM wp_ad2018posts WHERE ID='.($datos[0]+1));
     $stmt1->execute();
	 $row1 = $stmt1->fetch();
  
	 $stmt2 = $con->prepare('SELECT ID, post_title, guid, post_date, post_content, post_parent FROM wp_ad2018posts WHERE ID='.($datos[0]+2));
     $stmt2->execute();
	 $row2 = $stmt2->fetch();
	 
	 $arr = Array();
	 $arr['Id'] = $datos[0];
	 $arr['Titulo'] = $row2[1];
	 $arr['Foto'] =  ($row1[6]== "image/png" || $row1[6]== "image/jpeg") ? $row1[2] : "";
	 $arr['FechaPub'] = $row2[3];
	 $arr['Contenido'] = $datos[1];
	 
	 $fn[] = $arr;
	
   }
   echo json_encode($fn);
   
   //$cn->Desconectar($con, $stmt0);
   
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}



