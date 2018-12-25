<?php

class Conexion{
    var $BD;
    var $Server;
    var $User;
    var $Pass;
    var $IDConexion;
    
    function Conexion(){
        $this->BD = "GSIREM103";   
        $this->Server = ""; 
        $this->User = "sa"; 
        $this->Pass = "C0atzac0alc0s"; 
    }
    
    function Conectar(){
            try {
                //
		$this->IDConexion = new PDO('sqlsrv:Server='.$this->Server.'MPCTZSVR02-3;Database='.$this->BD, $this->User, $this->Pass);
		$this->IDConexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                //echo "Conexion realizada con exito !!!";
                
                if ($this->IDConexion instanceof PDO) {
                 return $this->IDConexion;
                }
                
	    }catch (PDOException $ex) {
		echo $ex->getMessage();
		exit;             
	    }	
    }
    
    function Desconectar( $pdo, $stmt ) {
      global $pdo, $stmt;
      $stmt->closeCursor();
      $stmt = null;
      $pdo = null;
    }
     
    //http://josehernandez.xyz/2012/01/07/consultas-base-datos-pdo.html
}
