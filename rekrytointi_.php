<?php

require 'PHPMailerAutoload.php';

$mail = new PHPMailer;

// $mail->setFrom($_POST["email"], $_POST["nimi"]);
$mail->CharSet = 'utf-8';
$mail->setFrom('www@konstru.fi', 'www-hakemus');
$mail->addReplyTo($_POST["email"], $_POST["nimi"]);
// $mail->addAddress('mika.laitala@konstru.fi', 'Mika Laitala');
$mail->addAddress('mikko@viiksipojat.fi', 'Mikko Leino');
$mail->Subject = 'Uusi hakemus';
$mail->Body = '
Nimi: ' . $_POST["nimi"] . '

Sähköpostiosoite: ' . $_POST["email"] . '

Hakemus: 

--- 

' . $_POST["hakemus"] . '

---

Ystävällisin terveisin,
-- Konstrun verkkopalveluautomaati 

';
if (!empty($_FILES['liite']['name'])) {
	$mail->addAttachment($_FILES["liite"][tmp_name], $_FILES["liite"]["name"]);
}

if (!$mail->send()) {
    header("Location: http://www.konstru.fi/rekrytointi/virhe/");
	die();
} else {
    header("Location: http://www.konstru.fi/rekrytointi/kiitos/");
	die();
}

// print_r($_FILES["liite"]);
// echo 'SENDING …';
// echo $_POST["nimi"];
// echo $_POST["email"];
// echo $_POST["hakemus"];
// mail('mikko@viiksipojat.fi', 'Hyvin menee ok', 'Nyt se sitten lähti.');

?>