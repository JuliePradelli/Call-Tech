<?php
if (isset($_POST['nom']) AND isset($_POST['utilisateurs']))
{
	exec('/var/www/script/crea_supp_contextes.sh 0 coucou 0');	
}
elseif (isset($_POST['nom']) AND isset($_POST['gtw']))
{
	echo "couocu2";
}
else
{
	include_once("vue/creation_gestion_contexte.php");
}
?>
