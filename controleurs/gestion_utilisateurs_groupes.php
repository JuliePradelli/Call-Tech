<?php
if(isset($_POST['username']) AND isset($_POST['mdp']) AND isset($_POST['mail']) AND isset($_POST['extension']) AND isset($_POST['contexte']) AND isset($_POST['creation']) AND isset($_POST['transfert_o']) AND isset($_POST['mobile']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer l'utilisateur ".$_POST['username']."</div>";
	exec('/var/www/script/crea_supp_users.sh 0 '.$_POST['username'].' '.$_POST['mdp'].' '.$_POST['extension'].' '.$_POST['contexte'].' 0 '.$_POST['mobile']);
	include_once("vue/gestion_utilisateurs_groupes.php");
}
elseif(isset($_POST['username']) AND isset($_POST['mdp']) AND isset($_POST['mail']) AND isset($_POST['extension']) AND isset($_POST['contexte']) AND isset($_POST['creation']) AND isset($_POST['transfert_n']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer l'utilisateur ".$_POST['username']."</div>";
	exec('/var/www/script/crea_supp_users.sh 0 '.$_POST['username'].' '.$_POST['mdp'].' '.$_POST['mail'].' '.$_POST['extension'].' '.$_POST['contexte'].' 1');
	include_once("vue/gestion_utilisateurs_groupes.php");
}
elseif(isset($_POST['username']) AND isset($_POST['suppression']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer l'utilisateur ".$_POST['username']."</div>";
	exec('/var/www/script/crea_supp_users.sh 1 '.$_POST['username']);
	include_once("vue/gestion_utilisateurs_groupes.php");
}
else
{
	include_once("vue/gestion_utilisateurs_groupes.php");
}
?>
