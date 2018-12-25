<?php
  $name = $_POST['name'];
  $image = $_POST['image'];

  $decodedimage = base64_decode("$image");
  file_put_contents("imagen/" . $name . ".jpg", $decodedimage);

 ?>
