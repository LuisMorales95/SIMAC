<?php
mb_internal_encoding ('UTF-8');
class Conexion{
	var $Database;
	var $Server;
	var $User;
	var $Pass;
	var $IDConexion;

	function Conexion(){
		// SIMACV2
		// $this->Database = 'SIMACV2';
    // $this->Server = "AGUADULCE2001";
    // $this->User = "sa";
    // $this->Pass = "ad.gob.mx.18";
		$this->Database = 'SIMACV2';
		$this->Server = 'DESKTOP-DCB7S8U\SQLSERVER';
    $this->User = "sa";
    $this->Pass = "sqlserver2018";
	}

	function conectar(){

		try {
			$this->IDConexion = new PDO('sqlsrv:Server='.$this->Server.';Database='.$this->Database, $this->User, $this->Pass);
			$this->IDConexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			//echo "Conexion realizada con exito !!!";

                if ($this->IDConexion instanceof PDO) {
                	return $this->IDConexion;
                }
		} catch (PDOException $ex) {
			echo 'Error: '.$ex->getMessage();
			exit;
		}
	}

	function Desconectar( $pdo, $stmt ) {
      global $pdo, $stmt;
      $stmt->closeCursor();
      $stmt = null;
      $pdo = null;
    }

}
 ?>
