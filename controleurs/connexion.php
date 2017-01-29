<?php
include_once("modele/connexion_inscription.php");
if (isset($_POST['mail']) AND isset($_POST['mdp'])) 
{
	$existence=existencecompte($_POST['mail'], $_POST['mdp']);
	if ($existence == 1) 
	{
		connexion($_POST['mail']);
		$_SESSION['pseudo']=username($_POST['mail']);
		$admin = verifadmin($_POST['mail']);
		if ($admin == 1)
		{
			include_once("vue/admin_gestion.php");
		}
		else
		{
			include_once("vue/user_gestion.php");
		}
	}
	else
	{
		include_once("vue/connexion.php");
	}
}
else
{
	include_once("vue/connexion.php");
}
?>
