#! /usr/local/bin/bash

# Script d'affectation et de retractation d'un agent a une queue. Il prend en parametres:

#$1=creation(0)/suppression(1)
#$2=nom de la queue
#$3=numero de l'agent a ajouter

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ && -f /usr/local/var/lib/queues/$2.conf && "$3" =~ ^[0-9]{2}$ ]]
	then
		# **************************************** AFFECTATION ***********************************************
		if [[ "$1" -eq 0 ]]
		then
			echo "member => SIP/$3" >> /usr/local/var/lib/asterisk/queues/$2.conf
			service asterisk reload
		# **************************************** RETRACTATION ***********************************************
		elif [[ "$1" -eq 1 ]]
		then
			chemin="member => SIP/$3"
			ligne=`grep -n "$chemin" /usr/local/var/lib/queues/$2.conf`
			if [[ ! -z $ligne ]]
			then
					num=`echo $ligne | cut -d':' -f1`
					sed -i".sav""$num d" /usr/local/var/lib/queues/$2.conf
					service asterisk reload
			else
				echo "Cet utilisateur n'est pas associe a cette queue."
			fi
		fi
	else
		echo "Veuillez saisir correctement les trois param√tres."
	fi
else
	echo "Veuillez saisir les trois parametres (creation(0)/suppression(1) - nom de la queue - numero de l'agent a ajouter)."
fi
