<?php

class Conexion{
    var $BD;
    var $Server;
    var $User;
    var $Pass;
    var $IDConexion;
    
    function Conexion(){
        $this->BD = "aguadb";   
        $this->Server = "localhost"; 
        $this->User = "usradminweb"; 
        $this->Pass = "eqNZV8hCdeoS1LnN"; 
    }
    
    function Conectar(){
            try {
                //
		$this->IDConexion = new PDO('mysql:host='.$this->Server.';dbname='.$this->BD.';charset=utf8mb4', $this->User, $this->Pass);
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
