<?php
session_start();
include 'Conexion.php';

$tk = '';
//8534ef64ba55507352d2bef2fbf8807e

//if($_SERVER['REQUEST_METHOD'] == 'POST') {

// Decodificando formato Json
//$body = json_decode(file_get_contents("php://input"), true);

if(isset($_GET['token'])){
   $tk = $_GET['token'];
   
try {
  $cn = new Conexion();
  $con = $cn->Conectar();

  $stmt = $con->prepare("SELECT catastro.BRIGADISTA.IDBRIGADISTA, catastro.PREDIO.IDPREDIO, catastro.BRIGADISTA.NOMBRE, catastro.BRIGADISTA.APELLIDOPATERNO, catastro.BRIGADISTA.APELLIDOMATERNO, 
          catastro.PREDIO.ZONA + catastro.PREDIO.MUNICIPIO + catastro.PREDIO.LOCALIDAD + catastro.PREDIO.REGION + catastro.PREDIO.MANZANA + catastro.PREDIO.LOTE + catastro.PREDIO.NIVEL + catastro.PREDIO.DEPTO + catastro.PREDIO.DV AS CLAVECATASTRAL, catastro.PREDIO.IDUSOPREDIO, catastro.USOPREDIO.USOPREDIO, 
          catastro.TAREACAMPO.FECHAPROGRAMADA, catastro.TAREACAMPO.IDTAREACAMPO, catastro.PROPIETARIO.NOMBRE + ' ' + ISNULL(catastro.PROPIETARIO.APELLIDOPATERNO, '') + ' ' + ISNULL(catastro.PROPIETARIO.APELLIDOMATERNO, '') AS propietario, ISNULL(ubicacion.CALLE.CALLE, '') + ' ' + ISNULL(ubicacion.DOMICILIO.NUMEXTERIOR, '') 
          + ' ' + ISNULL(ubicacion.COLONIA.COLONIA, '') + ' ' + ISNULL(ubicacion.LOCALIDAD.LOCALIDAD, '') AS DIRECCION
          FROM   ubicacion.CALLE INNER JOIN
          ubicacion.RELCOLCALLE ON ubicacion.CALLE.IDCALLE = ubicacion.RELCOLCALLE.IDCALLE INNER JOIN
          ubicacion.COLONIA ON ubicacion.RELCOLCALLE.IDCOLONIA = ubicacion.COLONIA.IDCOLONIA INNER JOIN
          catastro.PREDIO INNER JOIN
          ubicacion.DOMICILIO ON catastro.PREDIO.IDDOMICILIO = ubicacion.DOMICILIO.IDDOMICILIO ON ubicacion.RELCOLCALLE.IDRELCC = ubicacion.DOMICILIO.IDCALLECOLONIA INNER JOIN
          ubicacion.LOCALIDAD ON ubicacion.COLONIA.IDLOCALIDAD = ubicacion.LOCALIDAD.IDLOCALIDAD AND ubicacion.COLONIA.IDLOCALIDAD = ubicacion.LOCALIDAD.IDLOCALIDAD INNER JOIN
          catastro.PROPIETARIO ON catastro.PREDIO.IDPROPIETARIO = catastro.PROPIETARIO.IDPROPIETARIO INNER JOIN
          catastro.TAREACAMPO ON catastro.PREDIO.IDPREDIO = catastro.TAREACAMPO.IDPREDIO INNER JOIN
          catastro.BRIGADISTA ON catastro.TAREACAMPO.IDBRIGADISTA = catastro.BRIGADISTA.IDBRIGADISTA INNER JOIN
          catastro.USOPREDIO ON catastro.PREDIO.IDUSOPREDIO = catastro.USOPREDIO.IDUSOPREDIO INNER JOIN
          seguridad.USUARIO ON catastro.BRIGADISTA.IDBRIGADISTA = seguridad.USUARIO.IDBRIGADISTA 
          WHERE seguridad.USUARIO.TOKEN=:tk AND catastro.TAREACAMPO.IB=0 AND catastro.TAREACAMPO.TIPOTAREA=2
		  order by catastro.PREDIO.LOCALIDAD , catastro.PREDIO.REGION ,catastro.PREDIO.MANZANA , catastro.PREDIO.LOTE , catastro.PREDIO.NIVEL , catastro.PREDIO.DEPTO");
  $stmt->execute(array(':tk' => $tk ));
  
  $arr = Array();
  $arrls = Array();
  $lst = Array();
  $lst33 = Array();
  
  while($datos = $stmt->fetch()){
        
        $stmt0 = $con->prepare('SELECT catastro.PREDIO.IDPREDIO, catastro.CONSTRUCCIONES.IDCONSTRUCCION, catastro.CONSTRUCCIONES.LETRA, catastro.CONSTRUCCIONES.AREA, 
                                catastro.CONSTRUCCIONES.ANTIGUEDAD, catastro.CONSTRUCCIONES.VALOR_CONSTRUCCION, catastro.TIPO_CONSTRUCCION.IDTIPOCONSTRUCCION, 
                                catastro.TIPO_CONSTRUCCION.CLAVETIPOCONSTRUCCION, catastro.ESTADO_CONSTRUCCION.IDESTADOCONSTRUCCION, catastro.ESTADO_CONSTRUCCION.CLAVEESTADOCONSTRUCCION, 
                                catastro.TERMINO_CONSTRUCCION.IDTERMINOCONSTRUCCION, catastro.TERMINO_CONSTRUCCION.CLAVETERMINOCONSTRUCCION
                                FROM         catastro.PREDIO INNER JOIN
                                catastro.CONSTRUCCIONES ON catastro.PREDIO.IDPREDIO = catastro.CONSTRUCCIONES.IDPREDIO LEFT OUTER JOIN
                                catastro.ESTADO_CONSTRUCCION ON catastro.CONSTRUCCIONES.IDESTADOCONSTRUCCION = catastro.ESTADO_CONSTRUCCION.IDESTADOCONSTRUCCION LEFT OUTER JOIN
                                catastro.TERMINO_CONSTRUCCION ON catastro.CONSTRUCCIONES.IDTERMINOCONSTRUCCION = catastro.TERMINO_CONSTRUCCION.IDTERMINOCONSTRUCCION LEFT OUTER JOIN
                                catastro.TIPO_CONSTRUCCION ON catastro.CONSTRUCCIONES.IDTIPOCONSTRUCCION = catastro.TIPO_CONSTRUCCION.IDTIPOCONSTRUCCION WHERE catastro.PREDIO.IDPREDIO=:pred');
        $stmt0->execute(array(':pred' => $datos[1]));

        while($datos0 = $stmt0->fetch()){           
         $lst['IdConstruccion'] = $datos0[1];
         $lst['Letra'] =  $datos0[2];
         $lst['Area'] =  $datos0[3];
         $lst['Antiguedad'] =  $datos0[4];
         $lst['ValorC'] =  $datos0[5];
         $lst['IdTipoCons'] =  $datos0[6];
         $lst['ClaveTipoCons'] =  $datos0[7];
         $lst['IdEstadoCons'] =  $datos0[8];
         $lst['ClaveEstadoCons'] =  $datos0[9];
         $lst['IdTerminoCons'] =  $datos0[10];
         $lst['ClaveTerminoCons'] =  $datos0[11];
         $lst33[] = $lst;
        }
     
        $arrls['IdPersona'] = $datos[0];
        $arrls['IdPredio'] = $datos[1];
        $arrls['Nombre'] = $datos[2];
        $arrls['APP'] = $datos[3];
        $arrls['APM'] = $datos[4];
        $arrls['ClaveCT'] = $datos[5];
        $arrls['IdUsoPredio'] = $datos[6];
        $arrls['UsoPredio'] = $datos[7];
        $arrls['FechaProgramada'] = $datos[8];
        $arrls['IdTareaCampo'] = $datos[9];
        $arrls['Propietario'] = $datos[10];
		$arrls['DirPro'] = $datos[11];
		$arrls['Lista'] = $lst33;
		
        $stmt3 = $con->prepare('UPDATE [catastro].[TAREACAMPO] SET IB=1 WHERE IDTAREACAMPO=:idtc');
        $stmt3->execute(array(':idtc' => $datos[9]));
        
        $arr[] = $arrls;
        $lst = null;
        $lst33 = null;
  }
 
  echo json_encode($arr);
  
  $cn->Desconectar($con, $stmt);
  
} catch(PDOException $e) {
  echo 'Error: ' . $e->getMessage();
}

}

//}