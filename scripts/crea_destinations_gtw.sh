#! /usr/local/bin/bash

# Script de creation des destinations permettant l'acces aux gateways qui prend en parametres

#$1=nom de l'utilisateur entrant
#$2=nom de l'utilisateur sortant
#$3=switch
#$4=contexte ou on veut placer le switch

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" && ! -z "$4" ]] 
then
	if [[ -f /usr/local/var/lib/asterisk/users/$1.conf && -f /usr/local/var/lib/asterisk/users/$1.conf ]]
	then
		if [[ -f /usr/local/var/lib/asterisk/context/$4.conf ]]
		then
			echo "exten => $3,1,Dial(SIP/$2/\${EXTEN},20)" >> /usr/local/var/lib/asterisk/context/$4.conf
		else
			echo "Ce contexte n'existe pas."
		fi
	else
		echo "Cette gateway n'existe pas."
	fi
else
	echo "Veuillez saisir les trois parametres (nom de l'utilisateur entrant - nom de l'utilisateur sortant - switch - contexte(existant) ou on veut placer le switch)"
fi
