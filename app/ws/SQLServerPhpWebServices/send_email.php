<?php 

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

$mail = new PHPMailer(true);                              // Passing `true` enables exceptions
try {
    //Server settings
    $mail->SMTPDebug = 2;                                 // Enable verbose debug output
    $mail->isSMTP();                                      // Set mailer to use SMTP
    $mail->Host = 'smtp.gmail.com';  // Specify main and backup SMTP servers
    $mail->SMTPAuth = true;                               // Enable SMTP authentication
    $mail->Username = 'simacappdevelopment@gmail.com';                 // SMTP username
    $mail->Password = '496e443376336c30706d656e745331386132';                           // SMTP password
    $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
    // $mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
    
    $mail->Port = 587;                                    // TCP port to connect to

    //Content
    $mail->isHTML(true);                                  // Set email format to HTML
    $mail->Subject = 'Verificacion SIMAC';
    $mail->Body    = '  <div class=""><div class="aHl"></div><div id=":li" tabindex="-1"></div><div id=":jm" class="ii gt"><div id=":jn" class="a3s aXjCH m163a1be058bfda1b"><u></u>
  <div bgcolor="#ffffff" style="width:100%;background-color:#ffffff;margin:0;padding:0">
    <table height="100%" width="100%" cellpadding="0" cellspacing="0" border="0">
      <tbody><tr>
        <td valign="top" align="center" class="m_2647829932658133818devicewidth" style="background-color:#ffffff">
          
          <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth" align="center">
           	<tbody>
            


            	<tr>
              		<td>
              			<table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth" align="center">
  							<tbody>
  								<tr>
    							<td align="left" style="color:#2dbe60;font-family:helvetica,arial,sans-serif;font-size:30px;font-weight:100;padding:0 0 10px 0" class="m_2647829932658133818pl25 m_2647829932658133818pr25">Bienvenido a SIMAC</td>
  						</tr>
					</tbody>
				</table>
              </td>
            </tr>
            


            <tr>
              <td>
    	    <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse;table-layout:fixed;word-wrap:break-word" width="600" class="m_2647829932658133818devicewidth">
				<tbody>
					<tr>
					<td style="color:#484848;font-family:helvetica,arial,sans-serif;font-size:18px;line-height:26px;font-weight:100;padding:0 30px 35px 0" align="left" class="m_2647829932658133818pr25 m_2647829932658133818pl25 m_2647829932658133818f18 m_2647829932658133818l26">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
				  	<br><br>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
					</td>
					</tr>
				</tbody>
			</table>

              </td>
            </tr>



            <tr>
              <td>
              <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth">
			  <tbody>
			  	<tr>
			    <td style="padding:0 0 30px 0" class="m_2647829932658133818pl25 m_2647829932658133818pr25" align="left">
			      <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth">
			        <tbody><tr>
			          <td align="left" class="m_2647829932658133818full">
			            <div>
			              <a href="http://localhost/SQLServerPhpWebServices/JSONSelectColonia.php" style="background-color:#2dbe60;border:1px solid #2dbe60;border-radius:4px;color:#ffffff;display:inline-block;font-family:Helvetica,Arial,sans-serif;font-size:14px;font-weight:bold;line-height:35px;text-align:center;text-decoration:none;padding:0 25px 0 25px;letter-spacing:.5px;min-width:150px" class="m_2647829932658133818button" target="_blank">Validar Usuario</a>
			            </div>
			          </td>
			        </tr>
			      </tbody></table>
			    </td>
			  </tr>
			</tbody>



		</table>
              </td>
            </tr>
        



            <tr>
              <td>
                <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth">
  <tbody><tr>
    <td align="center" class="m_2647829932658133818pl25 m_2647829932658133818pr25">
      <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse;border-top:#bbbbbb solid 1px;padding:10px 0 10px 0" width="100%" class="m_2647829932658133818devicewidth" align="center">
        <tbody><tr>
          <td align="center">
            <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth" align="center">
              <tbody><tr>
                <td align="center">
                  <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="600" class="m_2647829932658133818devicewidth">
                    <tbody><tr>
                      <td align="center" style="padding:25px 5px 25px 5px;font-family:arial,sans-serif;font-size:12px;font-weight:400" class="m_2647829932658133818block">
                        
                        <!-- Windows LINK -->

                        <a href="" style="text-decoration:none;color:#20c05c;font-family:helvetica,arial,sans-serif;font-size:17px;font-weight:400;padding-right:9px" class="m_2647829932658133818block m_2647829932658133818pt25 m_2647829932658133818pr0 m_2647829932658133818pb10 m_2647829932658133818pl0" target="_blank" data-saferedirecturl="">Windows</a>

                        <!-- Mac OS LINK -->
                        <a href="" style="text-decoration:none;color:#20c05c;font-family:helvetica,arial,sans-serif;font-size:17px;font-weight:400;padding-right:12px;padding-left:10px" class="m_2647829932658133818block m_2647829932658133818pt10 m_2647829932658133818pr0 m_2647829932658133818pb10 m_2647829932658133818pl0" target="_blank" data-saferedirecturl="">Mac</a>
                        
                        <!-- PlayStore LINK -->

                        <a href="" style="padding-right:1px;padding-left:12px" class="m_2647829932658133818block m_2647829932658133818pt10 m_2647829932658133818pr0 m_2647829932658133818pb10 m_2647829932658133818pl0" target="_blank"><img src="https://ci6.googleusercontent.com/proxy/DobkNsuPSgYE4_zvQEQNld5Rhg76N5R6hE317CZEP6X4fa5lViYm-6a9BSLYVYI5fRgt2k-0fDQBKf-fZeyRnfk5mL4XvpHJjffagKII3l3-7iY_kHKQMCfJQAC2XBlUR21_iJB2vbhRcg=s0-d-e1-ft#https://www.evernote.com/redesign/mail/puck/downloadBannerMailPlugin/google_play.png" height="40" style="vertical-align:middle" alt="Android" class="CToWUd"></a>
                        	
                        	<!-- App Store -->

                        <a href="" style="padding-left:1px" class="m_2647829932658133818block m_2647829932658133818pt10 m_2647829932658133818pr0 m_2647829932658133818pl0" target="_blank" data-saferedirecturl=""><img src="https://ci4.googleusercontent.com/proxy/0WYvWpntvc-8ZtykIwdM22uMRzmGrSlnvyjEvseIl391YwIliU0JKZhd0DAVD3vSX03sQ7YrRVjPymj0esYfgnbRRpKlZs-Nf2vyQX-zUzg8zuCK2ZKGG4rmsEds6ANiVdoTuY0zIkc=s0-d-e1-ft#https://www.evernote.com/redesign/mail/puck/downloadBannerMailPlugin/app_store.png" height="40" style="vertical-align:middle" alt="iOS" class="CToWUd"></a>
                      </td>
                    </tr>
                  </tbody></table>
                </td>
              </tr>
            </tbody></table>
          </td>
        </tr>
      </tbody></table>
    </td>
  </tr>
</tbody></table>


              </td>
            </tr>
            <tr>
              <td>
              <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="100%" class="m_2647829932658133818devicewidth">
  <tbody><tr>
    <td align="center" class="m_2647829932658133818pl25 m_2647829932658133818pr25">
      <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse;border-top:#bbbbbb solid 1px;padding:10px 0 10px 0" width="100%" class="m_2647829932658133818devicewidth" align="center">
        <tbody><tr>
          <td align="center">
            <table border="0" cellpadding="0" cellspacing="0" style="border:none;border-collapse:collapse" width="100%" class="m_2647829932658133818devicewidth" align="center">
              </table>
          </td>
        </tr>
      </tbody></table>
    </td>
  </tr>
  <tr>
    <td width="100%" class="m_2647829932658133818mleft m_2647829932658133818pl25 m_2647829932658133818pr70" align="center" style="padding:10px;font-family:helvetica,arial,sans-serif;font-size:10px;line-height:17px;color:#535353">
        Este Correo se ha enviado de parte de SIMAC App.
<br>
      <a style="color:#535353;text-decoration:none"> <!-- href="" -->
        Direccion de SIMAC
      </a>
    </td>
  </tr>
  
  
  </tbody></table>

              </td>
            </tr>
          </tbody></table>
          
        </td>
      </tr>
    </tbody></table><div class="yj6qo"></div><div class="adL">
  </div></div><div class="adL">

</div></div></div><div id=":k6" class="ii gt" style="display:none"><div id=":k5" class="a3s aXjCH undefined"></div></div><div class="hi"></div></div>';
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    //Recipients
    $mail->setFrom('simacappdevelopment@gmail.com', 'SIMAC Correo de Verificacion');
    $mail->addAddress('joseluismoralesp95@gmail.com', 'Luis Morales');     // Add a recipient
    // // // $mail->addAddress('ellen@example.com');               // Name is optional
    // // $mail->addReplyTo('info@example.com', 'Information');
    // // $mail->addCC('cc@example.com');
    // // $mail->addBCC('bcc@example.com');

    // //Attachments
    // $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
    // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
}
?>