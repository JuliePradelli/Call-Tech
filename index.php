<?php

# ****************************** Démarrage du système de sessions PHP *************************************

#session_start();

# ********************************** Fonction de connexion à la BDD ****************************************

function connexion_bdd($mabdd)
{
	try
	{
	   $bdd = new PDO('mysql:host=localhost;dbname=mydb;charset=utf8', 'root', '');
	}
	catch (Exception $e)
	{
	       die('Erreur : ' . $e->getMessage());
	}
	return($bdd);
}

# ********************************** Analyse de la query string ********************************************

if($_SERVER['QUERY_STRING'] != "")
{
	$querybreak = explode("&", $_SERVER['QUERY_STRING']);
	$t = array();
	for ($i=0; $i < count($querybreak); $i++) 
	{ 
		$t[$i] = explode("=", $querybreak[$i]);
	}
	$page = $t[0][1];
	if (count($t) > 1) 
	{
		$choix = $t[1][1];
	}
	switch ($page) 
	{
		case 'connexion':
			include_once("controleur/connexion.php");
			break;
		case 'accueil':
			include_once("vue/index.php");
			break;
		case 'inscription':
			include_once("controleur/inscription.php");
			break;
		case 'plan_appel':
			include_once("controleur/plan_appel.php");
			break;
		case 'admin_gestion':
			include_once("controleur/admin_gestion.php");
			break;
		case 'authorisation_conference':
			include_once("controleur/authorisation_conference.php");
			break;
		case 'creation_gestion_contexte':
			include_once("controleur/creation_gestion_contexte.php");
			break;
		case 'gestion_callcenters':
			include_once("controleur/gestion_callcenters.php");
			break;
		case 'gestion_gateways':
			include_once("controleur/gestion_gateways.php");
			break;
		case 'gestion_salles_conf':
			include_once("controleur/gestion_salles_conf.php");
			break;
		case 'gestion_utilisateurs_groupes':
			include_once("controleur/gestion_utilisateurs_groupes.php");
			break;
		case 'inclusion_contexte':
			include_once("controleur/inclusion_contexte.php");
			break;
		case 'user_gestion':
			include_once("controleur/user_gestion.php");
			break;
		case 'user_gestion_conference':
			include_once("controleur/user_gestion_conference.php");
			break;
		case 'user_messages_vocaux':
			include_once("controleur/user_messages_vocaux.php");
			break;
		case 'user_plan_appel':
			include_once("controleur/user_plan_appel.php");
			break;
	}
}
else
{
	include_once("vue/index.php");
}
?>
<?php
# Si l'utilisateur a cliqué sur le bouton de connexion ou d'inscription
/*if(isset($_POST["action"]) AND ($_POST["action"] == "connexion" OR $_POST["action"] == "inscription"))
{
	include_once("controleur/accueil.php");
}
# Sinon si la query string n'est pas vide
elseif($_SERVER['QUERY_STRING'] != "") 
{
	# tronchature de la query string pour analyse
	$querybreak = explode("&", $_SERVER['QUERY_STRING']);
	$t = array();
	for ($i=0; $i < count($querybreak); $i++) 
	{ 
		$t[$i] = explode("=", $querybreak[$i]);
	}
	$page = $t[0][1];
	if (count($t) > 1) 
	{
		$choix = $t[1][1];
	}

	switch ($page) 
	{
	}	
}
# Sinon si la query string est vide mais que $_SESSION['pseudo'] existe, connexion immédiate
elseif($_SERVER['QUERY_STRING'] == "" AND isset($_SESSION['pseudo']))
{
	include_once("controleur/avatarcon2.php");
}
# Sinon, Retour à la page d'accueil
else
{
	include_once("controleur/debut.php");
}*/
?>
