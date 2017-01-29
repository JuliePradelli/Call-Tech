<?php
if(isset($_POST['username']) AND isset($_POST['mdp']) AND isset($_POST['adresse']) AND isset($_POST['contexte_e']) AND isset($_POST['port']) AND isset($_POST['utilisateur_e']) AND isset($_POST['utilisateur_s']) AND isset($_POST['creation']))
{
	exec('/var/www/script/crea_supp_gtw.sh 0 '.$_POST['username'].' '.$_POST['mdp'].' '.$_POST['adresse'].' '.$_POST['contexte_e'].' '.$_POST['port'].' '.$_POST['utilisateur_e'].' '.$_POST['utilisateur_s']);
}
elseif(isset($_POST['username']) AND isset($_POST['contexte_e']) AND isset($_POST['utilisateur_e']) AND isset($_POST['utilisateur_s']) AND isset($_POST['suppression']))
{
	exec('/var/www/script/crea_supp_gtw.sh 1 '.$_POST['username'].' '.$_POST['contexte_e'].' '.$_POST['utilisateur_e'].' '.$_POST['utilisateur_s']);
}
else
{
	include_once("vue/gestion_gateways.php");
}
?>
