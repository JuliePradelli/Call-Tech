<?php
if(isset($_POST['username']) AND isset($_POST['mdp']) AND isset($_POST['adresse']) AND isset($_POST['contexte_e']) AND isset($_POST['port']) AND isset($_POST['utilisateur_e']) AND isset($_POST['utilisateur_s']) AND isset($_POST['creation']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer la gateway d'utilisateur ".$_POST['username'].".</div>";
	exec('/var/www/script/crea_supp_gtw.sh 0 '.$_POST['username'].' '.$_POST['mdp'].' '.$_POST['adresse'].' '.$_POST['contexte_e'].' '.$_POST['port'].' '.$_POST['utilisateur_e'].' '.$_POST['utilisateur_s']);
	include_once("vue/gestion_gateways.php"); 
}
elseif(isset($_POST['username']) AND isset($_POST['contexte_e']) AND isset($_POST['utilisateur_e']) AND isset($_POST['utilisateur_s']) AND isset($_POST['suppression']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer la gateway de username ".$_POST['username'].".</div>";
	exec('/var/www/script/crea_supp_gtw.sh 1 '.$_POST['username'].' '.$_POST['contexte_e'].' '.$_POST['utilisateur_e'].' '.$_POST['utilisateur_s']);
	include_once("vue/gestion_gateways.php"); 
}
elseif(isset($_POST['user_e']) AND isset($_POST['user_s']) AND isset($_POST['switch']) AND isset($_POST['contexte']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer une destination dans le contexte ".$_POST['contexte'].".</div>";
	exec('/var/www/script/crea_destinations_gtw.sh '.$_POST['user_e'].' '.$_POST['user_s'].' '.$_POST['switch'].' '.$_POST['contexte']);
	include_once("vue/gestion_gateways.php"); 
}
else
{
	include_once("vue/gestion_gateways.php"); 
}
?>
