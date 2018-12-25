<?php 

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';


error_reporting(0);
ini_set('display_errors', 0);

if($_SERVER['REQUEST_METHOD'] == 'POST') {
	$body = json_decode(file_get_contents("php://input"), true);

	$ws_PDFEmail = $body['ws_PDFEmail'];
  	$ws_PDFName = $body['ws_PDFName'];
  	$ws_PDFBase64 = $body['ws_PDFBase64'];
  	$ws_PDFNomenclatura = $body['ws_PDFNomenclatura'];
  	$ws_PDFNombre = $body['ws_PDFNombre'];
  	$ws_PDFSolicitante = $body['ws_PDFSolicitante'];
  	$ws_PDFEnviada = $body['ws_PDFEnviada'];
  	$ws_PDFAsunto = $body['ws_PDFAsunto'];
  	$ws_PDFEstado = $body['ws_PDFEstado'];
  	$ws_PDFUbicacion = $body['ws_PDFUbicacion'];
  	$ws_PDFNotas = $body['ws_PDFNotas'];

  	$path = "GeneratedPDFs/".$ws_PDFName;
  	$pdf_b64 = base64_decode($ws_PDFBase64);

  	if (file_put_contents($path, $pdf_b64)) {
  		echo '{"Response":"Success"}';
  		$mail = new PHPMailer(true);
  		try {
  			$mail->SMTPDebug = 2;
		    $mail->isSMTP();
		    $mail->Host = 'smtp.gmail.com;';
		    $mail->SMTPAuth = true;
		    $mail->Username = 'beedocsdevelopment@gmail.com';
		    $mail->Password = 'beedocs2018';
		    $mail->SMTPSecure = 'tls';
		    $mail->Port = 587;
		    $mail->setFrom('beedocsdevelopment@gmail.com', 'BeeDocsMailer');
		    $mail->addAddress($ws_PDFEmail);
		    $mail->addCC('beedocsdevelopment@gmail.com');
		    $mail->addBCC('beedocsdevelopment@gmail.com');
		    $mail->addAttachment($path);
		    $mail->isHTML(true);
		    $mail->Subject = 'PDF Generado';
		    $mail->Body    = '<html>
			<head>
			  <meta charset="utf-8" />

			  <style type="text/css">
			  body {
			   padding-top: 0 !important;
			   padding-bottom: 0 !important;
			   padding-top: 0 !important;
			   padding-bottom: 0 !important;
			   margin:0 !important;
			   width: 100% !important;
			   -webkit-text-size-adjust: 100% !important;
			   -ms-text-size-adjust: 100% !important;
			   -webkit-font-smoothing: antialiased !important;
			 }
			 .tableContent img {
			   border: 0 !important;
			   display: block !important;
			   outline: none !important;
			 }
			 a{
			  color:#382F2E;
			}

			p, h1,h2,ul,ol,li,div{
			  margin:0;
			  padding:0;
			}

			h1,h2{
			  font-weight: normal;
			  background:transparent !important;
			  border:none !important;
			}

			@media only screen and (max-width:480px)
					
			{
					
			table[class="MainContainer"], td[class="cell"] 
				{
					width: 100% !important;
					height:auto !important; 
				}
			td[class="specbundle"] 
				{
					width: 100% !important;
					float:left !important;
					font-size:13px !important;
					line-height:17px !important;
					display:block !important;
					padding-bottom:15px !important;
				}	
			td[class="specbundle2"] 
				{
					width:80% !important;
					float:left !important;
					font-size:13px !important;
					line-height:17px !important;
					display:block !important;
					padding-bottom:10px !important;
					padding-left:10% !important;
					padding-right:10% !important;
				}
					
			td[class="spechide"] 
				{
					display:none !important;
				}
				    img[class="banner"] 
				{
				          width: 100% !important;
				          height: auto !important;
				}
					td[class="left_pad"] 
				{
						padding-left:15px !important;
						padding-right:15px !important;
				}
					 
			}
				
			@media only screen and (max-width:540px) 

			{
					
			table[class="MainContainer"], td[class="cell"] 
				{
					width: 100% !important;
					height:auto !important; 
				}
			td[class="specbundle"] 
				{
					width: 100% !important;
					float:left !important;
					font-size:13px !important;
					line-height:17px !important;
					display:block !important;
					padding-bottom:15px !important;
				}	
			td[class="specbundle2"] 
				{
					width:80% !important;
					float:left !important;
					font-size:13px !important;
					line-height:17px !important;
					display:block !important;
					padding-bottom:10px !important;
					padding-left:10% !important;
					padding-right:10% !important;
				}
					
			td[class="spechide"] 
				{
					display:none !important;
				}
				    img[class="banner"] 
				{
				          width: 100% !important;
				          height: auto !important;
				}
					td[class="left_pad"] 
				{
						padding-left:15px !important;
						padding-right:15px !important;
				}
					
			}

			.contentEditable h2.big,.contentEditable h1.big{
			  font-size: 18px !important;
			}

			 .contentEditable h2.bigger,.contentEditable h1.bigger{
			  font-size: 37px !important;
			}

			td,table{
			  vertical-align: top;
			}
			td.middle{
			  vertical-align: middle;
			}

			a.link1{
			  font-size:13px;
			  color:#27A1E5;
			  line-height: 24px;
			  text-decoration:none;
			}
			a{
			  text-decoration: none;
			}

			.link2{
			color:#ffffff;
			border-top:10px solid #27A1E5;
			border-bottom:10px solid #27A1E5;
			border-left:18px solid #27A1E5;
			border-right:18px solid #27A1E5;
			border-radius:3px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			background:#27A1E5;
			}

			.link3{
			color:#555555;
			border:1px solid #cccccc;
			padding:10px 18px;
			border-radius:3px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			background:#ffffff;
			}

			.link4{
			color:#27A1E5;
			line-height: 24px;
			}

			h2,h1{
			line-height: 20px;
			}
			p{
			  font-size: 14px;
			  line-height: 21px;
			  color:#AAAAAA;
			}

			.contentEditable li{
			 
			}

			.appart p{
			 
			}
			.bgItem{
			background: #ffffff;
			}
			.bgBody{
			background: #ffffff;
			}

			img { 
			  outline:none; 
			  text-decoration:none; 
			  -ms-interpolation-mode: bicubic;
			  width: auto;
			  max-width: 100%; 
			  clear: both; 
			  display: block;
			  float: none;
			}

			</style>


			<script type="colorScheme" class="swatch active">
			{
			    "name":"Default",
			    "bgBody":"ffffff",
			    "link":"27A1E5",
			    "color":"AAAAAA",
			    "bgItem":"ffffff",
			    "title":"444444"
			}
			</script>


			</head>
			<body paddingwidth="0" paddingheight="0" bgcolor="#d1d3d4"  style="padding-top: 0; padding-bottom: 0; padding-top: 0; padding-bottom: 0; background-repeat: repeat; width: 100% !important; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; -webkit-font-smoothing: antialiased;" offset="0" toppadding="0" leftpadding="0">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td><table width="600" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#ffffff" style="font-family:helvetica, sans-serif;" class="MainContainer">
			      <!-- =============== START HEADER =============== -->
			  <tbody>
			    <tr>
			      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td valign="top" width="20">&nbsp;</td>
			      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td class="movableContentContainer">
			      <div class="movableContent" style="border: 0px; padding-top: 0px; position: relative;">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td height="15"></td>
			    </tr>
			    <tr>
			      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td valign="top" width="60"><img src="http://www.aguadulce.gob.mx/images/logo.png" alt="Logo" title="Logo" width="60" height="60" data-max-width="100"></td>
			      <td width="10" valign="top">&nbsp;</td>
			      <td valign="middle" style=\'vertical-align: middle;\'>
			                          <div class=\'contentEditableContainer contentTextEditable\'>
			                            <div class=\'contentEditable\' style=\'text-align: left;font-weight: light; color:#555555;font-size:26;line-height: 39px;font-family: Helvetica Neue;\'>
			                              <h1 class=\'big\'><a style=\'color:#DF0101\'>'.$ws_PDFNomenclatura.'</a></h1>
			                            </div>
			                          </div>
			                        </td>
			    </tr>
			  </tbody>
			</table>
			</td>
			      <td valign="top" width="90" class="spechide">&nbsp;</td>
			      <td valign="middle" style=\'vertical-align: middle;\' width=\'150\'>
			                          <div class=\'contentEditableContainer contentTextEditable\'>
			                            <div class=\'contentEditable\' style=\'text-align: right;\'>
			                              <a target=\'_blank\' href="https://play.google.com/store/apps/details?id=com.BeeDocs" class=\'link1\' >Bee Docs </a>
			                            </div>
			                          </div>
			                        </td>
			    </tr>
			  </tbody>
			</table></td>
			    </tr>
			    <tr>
			       <td height=\'15\'></td>
			    </tr>
			    <tr>
			       <td ><hr style=\'height:1px;background:#DDDDDD;border:none;\'></td>
			     </tr>
			  </tbody>
			</table>
				  </div>
			      <!-- =============== END HEADER =============== -->
			<!-- =============== START BODY =============== -->
			      
			      <div class="movableContent" style="border: 0px; padding-top: 0px; position: relative;">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td height="40"></td>
			    </tr>
			    <tr>
			      <td valign="top" width="580"><div class=\'contentEditableContainer contentImageEditable\'>
			                      <div class=\'contentEditable\' style="text-align: center;"><img class="banner" src="http://www.aguadulce.gob.mx/images/bigImg.png" alt="Logo" title="Logo" width="580" height="221" border="0"></div></div></td>
			    </tr>
			  </tbody>
			</table>

			      
			      
			      </div>
			      <div class="movableContent" style="border: 0px; padding-top: 0px; position: relative;">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td height=\'40\'></td>
			    </tr>
			    <tr>
			      <td style="border: 1px solid #EEEEEE; border-radius:6px;-moz-border-radius:6px;-webkit-border-radius:6px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td valign="top" width="40">&nbsp;</td>
			      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
			                      <tr><td height=\'25\'></td></tr>
			                      <tr>
			                        <td>
			                          <div class=\'contentEditableContainer contentTextEditable\'>
			                            <div class=\'contentEditable\' style=\'text-align: center;\'>
			                              <h2 style="font-size: 20px;">NOTAS</h2>
			                              <br>
			                              <p>'.$ws_PDFNotas.' </p>
			                            </div>
			                          </div>
			                        </td>
			                      </tr>
			                      <tr><td height=\'24\'></td></tr>
			                    </table></td>
			      <td valign="top" width="40">&nbsp;</td>
			    </tr>
			  </tbody>
			</table>
			</td>
			    </tr>
			  </tbody>
			</table>

			      
			      
			      </div>
			      

			</table>

			      
			      
			      </div>
			      
			      


			      <div class="movableContent" style="border: 0px; padding-top: 0px; position: relative;">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td height="40"></td>
			    </tr>
			    <tr>
			      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tbody>
			    <tr>
			      <td class="specbundle" valign="top" width="142" align="center"><div class=\'contentEditableContainer contentImageEditable\'>
			                      <div class=\'contentEditable\'>
			                        <img src="http://www.aguadulce.gob.mx/images/side3.png" alt="side image" width=\'142\' height=\'142\' data-default="placeholder" border="0">
			                      </div>
			                    </div></td>
			      <td width="20" valign="top" class="spechide"></td>
			      <td class="specbundle"><table width="100%" cellpadding="0" cellspacing="0" align="center">
			                      <tr><td height=\'15\'></td></tr>
			                      <tr>
			                        <td>
			                          <div class=\'contentEditableContainer contentTextEditable\'>
			                            <div class=\'contentEditable\' style=\'text-align: left;\'>
			                              <h2 style=\'font-size:16px;\'>Nombre solicitante:  '.$ws_PDFNombre.'</h2>
			                              <br>
			                              <p>Asunto:  '.$ws_PDFAsunto.'</p> 
			                               <p>Dependencia solicitante:  '.$ws_PDFSolicitante.'</p>
			                                 <p>Dependencia destino:  '.$ws_PDFEnviada.'</p> 
			                            </div>
			                          </div>
			                        </td>
			                      </tr>
			                    </table></td>
			    </tr>
			  </tbody>
			</table></td>
			    </tr>
			    <tr><td height=\'40\' colspan="3"></td></tr>
			                <tr><td colspan="3"><hr style=\'height:1px;background:#DDDDDD;border:none;\'></td></tr>
			  </tbody>
			</table>
			      </div>
			      <!-- =============== END BODY =============== -->
			<!-- =============== START FOOTER =============== -->
			      </td>
			    </tr>
			  </tbody>
			</table>
			</td>
			      <td valign="top" width="20">&nbsp;</td>
			    </tr>
			  </tbody>
			</table>
			</td>
			    </tr>
			  </tbody>
			</table>
			</td>
			    </tr>
			  </tbody>
			</table>
			  </body>
			  </html>';
		    $mail->AltBody = 'Message sin \n HTML';
		    $mail->send();

	  		echo '{"Response":"Success"}';
  		} catch (Exception $e) {
	    	error(1,'Exception: ' . $e->getMessage().' \n EmailInfo: '.$mail->ErrorInfo);
		}	
	  		echo '{"Response":"EmailError"}';	
  	}
  	echo '{"Response":"PDFError"}';
}else{
	echo '{"Response":"POSTError"}';
}

function error($numero,$texto){
  $ddf = fopen('Error.log','a');
  fwrite($ddf,"[".date("r")."] Error $numero: $texto\r\n");
  fclose($ddf);
}

?>