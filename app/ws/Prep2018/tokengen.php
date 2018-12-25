<?php 
echo token();

function token(){
	$UserID = "D89654";
	$token = md5(uniqid(microtime(), true));
	$token_time = time();
	$_SESSION['csrf'][$UserID.'_token'] = array('token'=>$token, 'time'=>$token_time);
	return $token;
}
 ?>