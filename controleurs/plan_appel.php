<?php
if (isset($_POST['username']) AND isset($_POST['contexte']) AND isset($_POST['transfert_o']) AND isset($_POST['numero']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de transferer l'utilisateur ".$_POST['username']."</div>";
	exec('/var/www/script/fonction_transfert.sh '.$_POST['username'].' '.$_POST['contexte'].' 0 '.$_POST['numero']);	
	include_once("vue/plan_appel.php");
}
elseif (isset($_POST['username']) AND isset($_POST['contexte']) AND isset($_POST['transfert_n']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer le transfert de ".$_POST['username']."</div>";
	exec('/var/www/script/fonction_transfert.sh '.$_POST['username'].' '.$_POST['contexte'].' 1');	
	include_once("vue/plan_appel.php");
}
else
{
	include_once("vue/plan_appel.php");
}
?>
