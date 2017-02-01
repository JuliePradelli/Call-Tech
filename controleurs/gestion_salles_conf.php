<?php
if (isset($_POST['creation']) AND isset($_POST['nom']) AND isset($_POST['numero']) AND isset($_POST['admin_o']) AND isset($_POST['user_mdp_o']) AND isset($_POST['nom_mdp']) AND isset($_POST['mdp']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer la salle de conference ".$_POST['nom']."</div>";
	exec('/var/www/script/crea_supp_conferences.sh 0 '.$_POST['nom'].' '.$_POST['numero'].' 0 0 '.$_POST['nom_mdp'].' '.$_POST['mdp']);	
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['creation']) AND isset($_POST['nom']) AND isset($_POST['numero']) AND isset($_POST['admin_o']) AND isset($_POST['user_mdp_n']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer la salle de conference ".$_POST['nom']."</div>";
	exec('/var/www/script/crea_supp_conferences.sh 0 '.$_POST['nom'].' '.$_POST['numero'].' 0 1');	
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['creation']) AND isset($_POST['nom']) AND isset($_POST['numero']) AND isset($_POST['admin_n']) AND isset($_POST['user_mdp_o']) AND isset($_POST['nom_mdp']) AND isset($_POST['mdp']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer la salle de conference ".$_POST['nom']."</div>";
	exec('/var/www/script/crea_supp_conferences.sh 0 '.$_POST['nom'].' '.$_POST['numero'].' 1 0 '.$_POST['nom_mdp'].' '.$_POST['mdp']);	
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['creation']) AND isset($_POST['nom']) AND isset($_POST['numero']) AND isset($_POST['admin_n']) AND isset($_POST['user_mdp_n']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer la salle de conference ".$_POST['nom']."</div>";
	exec('/var/www/script/crea_supp_conferences.sh 0 '.$_POST['nom'].' '.$_POST['numero'].' 1 1');
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['suppression']) AND isset($_POST['nom']) AND isset($_POST['nom_mdp']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer la salle de conference ".$_POST['nom']."</div>";
	exec('/var/www/script/crea_supp_conferences.sh 1 '.$_POST['nom'].' '.$_POST['nom_mdp']);
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['suppression']) AND isset($_POST['nom']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer la salle de conference ".$_POST['nom']."</div>";
	exec('/var/www/script/crea_supp_conferences.sh 1 '.$_POST['nom']);
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['user_mdp_n']) AND isset($_POST['meo']) AND isset($_POST['opt']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de modifier l'utilisateur sans mot de passe</div>";
	exec('/var/www/script/options_conference.sh user_nomdp 0 '.$_POST['opt']);
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['user_mdp_o']) AND isset($_POST['meo']) AND isset($_POST['opt']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de modifier l'utilisateur ".$_POST['user_mdp_o'].".</div>";
	exec('/var/www/script/options_conference.sh '.$_POST['user_mdp_o'].' 0 '.$_POST['opt']);
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['user_mdp_n']) AND isset($_POST['sup']) AND isset($_POST['opt']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de modifier l'utilisateur sans mot de passe</div>";
	exec('/var/www/script/options_conference.sh user_nomdp 1 '.$_POST['opt']);
	include_once("vue/gestion_salles_conf.php");
}
elseif (isset($_POST['user_mdp_o']) AND isset($_POST['sup']) AND isset($_POST['opt']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de modifier l'utilisateur ".$_POST['user_mdp_o'].".</div>";
	exec('/var/www/script/options_conference.sh '.$_POST['user_mdp_o'].' 1 '.$_POST['opt']);
	include_once("vue/gestion_salles_conf.php");
}
else
{
	include_once("vue/gestion_salles_conf.php");
}
?>
