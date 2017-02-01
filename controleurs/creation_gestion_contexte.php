<?php
if (isset($_POST['creation']) AND isset($_POST['nom0']) AND isset($_POST['utilisateurs']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer le contexte ".$_POST['nom0']."</div>";
	exec('/var/www/script/crea_supp_contextes.sh 0 '.$_POST['nom0'].' 0');	
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['creation']) AND isset($_POST['nom0']) AND isset($_POST['gtw']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer le contexte ".$_POST['nom0']."</div>";
	exec('/var/www/script/crea_supp_contextes.sh 0 '.$_POST['nom0'].' 1');
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['suppression']) AND isset($_POST['nom0']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer le contexte ".$_POST['nom0']."</div>";
	exec('/var/www/script/crea_supp_contextes.sh 1 '.$_POST['nom0']);
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['nom1']) AND isset($_POST['nom2']) AND isset($_POST['direction1']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer une relation bidirectionnelle entre ".$_POST['nom1']." et ".$_POST['nom2']."</div>";
	exec('/var/www/script/affectation_droits.sh '.$_POST['nom1'].' '.$_POST['nom2'].' 0');	
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['nom1']) AND isset($_POST['nom2']) AND isset($_POST['direction2']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer une relation unidirectionnelle entre ".$_POST['nom1']." et ".$_POST['nom2']."</div>";
	exec('/var/www/script/affectation_droits.sh '.$_POST['nom1'].' '.$_POST['nom2'].' 1');	
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['nom1']) AND isset($_POST['nom2']) AND isset($_POST['direction3']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de creer une relation unidirectionnelle entre ".$_POST['nom1']." et ".$_POST['nom2']."</div>";
	exec('/var/www/script/affectation_droits.sh '.$_POST['nom1'].' '.$_POST['nom2'].' 2');	
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['nom1']) AND isset($_POST['nom2']) AND isset($_POST['direction4']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer la relation bidirectionnelle entre ".$_POST['nom1']." et ".$_POST['nom2']."</div>";
	exec('/var/www/script/affectation_droits.sh '.$_POST['nom1'].' '.$_POST['nom2'].' 3');	
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['nom1']) AND isset($_POST['nom2']) AND isset($_POST['direction5']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer la relation unidirectionnelle entre ".$_POST['nom1']." et ".$_POST['nom2']."</div>";
	exec('/var/www/script/affectation_droits.sh '.$_POST['nom1'].' '.$_POST['nom2'].' 4');	
	include_once("vue/creation_gestion_contexte.php");
}
elseif (isset($_POST['nom1']) AND isset($_POST['nom2']) AND isset($_POST['direction6']))
{
	$alerte="<div class=\"alert alert-success col-md-offset-2 col-md-8\">Bravo, vous venez de supprimer la relation unidirectionnelle entre ".$_POST['nom1']." et ".$_POST['nom2']."</div>";
	exec('/var/www/script/affectation_droits.sh '.$_POST['nom1'].' '.$_POST['nom2'].' 5');	
	include_once("vue/creation_gestion_contexte.php");
}
else
{
	include_once("vue/creation_gestion_contexte.php");
}
?>
