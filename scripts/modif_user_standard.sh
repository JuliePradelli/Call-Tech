#! /usr/local/bin/bash

# script de modification de l'utilisateur standard 

#$1=username de l'utilisateur
#$2=exten de l'utilisateur

tab=()
i=0

if [[ ! -z "$1" && ! -z "$2" ]]
then
	if [[ -f /usr/local/var/lib/asterisk/users/$1.conf ]]
	then	
		#******************* TROUVER LE FICHIER SIP DE L'UTILISATEUR ET LE LIRE ********************
		while read ligne
		do
			tab[$i]="$ligne"
			i=$(($i+1))
		done < /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys

		#***************** SUPPRIMER LE FICHER ****************************
		rm /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys

		#************** REECRIRE LE FICHIER AVEC LES NOUVEAUX PARAMETRES ****************
		touch /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[0]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[1]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[2]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[3]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[4]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "exten => 50,n(open),Dial(SIP/$2)" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[6]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
		echo "${tab[7]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys

		#**************** RECOLLER LA FIN DU FICHIER **********************
		if [[ "$i" -ge 8 ]]
		then
			for ((j=$i-6; j<=$i; j++))
			do
				echo "${tab[$j]}" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys
			done
		fi
		service asterisk reload
	else
		echo "Cet utilisateur n'existe pas"
	fi
else
	echo "Veuillez saisir les deux parametres ( username - exten de l'utilisateur )"
fi
