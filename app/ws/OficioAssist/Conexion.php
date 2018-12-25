<?php

class Conexion{
    var $BD;
    var $Server;
    var $User;
    var $Pass;
    var $IDConexion;
    
    function Conexion(){
        $this->BD = "OFICIO_ASSISTENTE";   
        $this->Server = "DESKTOP-DCB7S8U\SQLSERVER"; 
        $this->User = "testing"; 
        $this->Pass = "testing2018"; 
    }
    
    function Conectar(){
            try {
                //
		$this->IDConexion = new PDO('sqlsrv:Server='.$this->Server.';Database='.$this->BD, $this->User, $this->Pass);
		$this->IDConexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                // echo "Conexion realizada con exito !!!";
                
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
