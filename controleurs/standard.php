<?php
if(isset($_POST['hsi']) AND isset($_POST['jour1']) AND isset($_POST['jour2']) AND isset($_POST['jmsi']) AND isset($_POST['mois1']) AND isset($_POST['mois2']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de changer les horaires du standard.</div>";
	exec('/var/www/script/horaires_standard.sh r r '.$_POST['jour1'].' '.$_POST['jour2'].' r r '.$_POST['mois1'].' '.$_POST['mois2']);
	include_once("vue/standard.php");
}
elseif(isset($_POST['hsi']) AND isset($_POST['jour1']) AND isset($_POST['jour2']) AND isset($_POST['jmd']) AND isset($_POST['jmf']) AND isset($_POST['mois1']) AND isset($_POST['mois2']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de changer les horaires du standard.</div>";
	exec('/var/www/script/horaires_standard.sh r r '.$_POST['jour1'].' '.$_POST['jour2'].' '.$_POST['jmd'].' '.$_POST['jmf'].' '.$_POST['mois1'].' '.$_POST['mois2']);
	include_once("vue/standard.php");
}
elseif(isset($_POST['hd']) AND isset($_POST['hf']) AND isset($_POST['jour1']) AND isset($_POST['jour2']) AND isset($_POST['jmsi']) AND isset($_POST['mois1']) AND isset($_POST['mois2']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de changer les horaires du standard.</div>";
	exec('/var/www/script/horaires_standard.sh '.$_POST['hd'].' '.$_POST['hf'].' '.$_POST['jour1'].' '.$_POST['jour2'].' r r '.$_POST['mois1'].' '.$_POST['mois2']);
	include_once("vue/standard.php");
}
elseif(isset($_POST['hd']) AND isset($_POST['hf']) AND isset($_POST['jour1']) AND isset($_POST['jour2']) AND isset($_POST['jmd']) AND isset($_POST['jmf']) AND isset($_POST['mois1']) AND isset($_POST['mois2']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de changer les horaires du standard.</div>";
	exec('/var/www/script/horaires_standard.sh '.$_POST['hd'].' '.$_POST['hf'].' '.$_POST['jour1'].' '.$_POST['jour2'].' '.$_POST['jmd'].' '.$_POST['jmf'].' '.$_POST['mois1'].' '.$_POST['mois2']);
	include_once("vue/standard.php");
}
elseif(isset($_POST['username']) AND isset($_POST['numero']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de placer ".$_POST['username']." au standard.</div>";
	exec('/var/www/script/modif_user_standard.sh '.$_POST['username'].' '.$_POST['numero']);
	include_once("vue/standard.php");
}
else
{
	include_once("vue/standard.php");
}
?>
