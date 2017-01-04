#! /usr/local/bin/bash

# script de modification de l'option de transfert d'un utilisateur, il prend en parametres

#$1=login utilisateur(username dans sip.conf)
#$2=option de transfert(0=oui/1=non)
#$3=numero de mobile

tab=()
i=0

if [[ ! -z "$1" && ! -z "$2" && "$2" -eq 0 ]]
then
	if [[ ! -z "$3" && "$3" =~ ^06[0-9]{8}$ && -e /usr/local/var/lib/asterisk/users/$1.conf ]]
	then	
		#******************* TROUVER LE FICHIER SIP DE L'UTILISATEUR ET LE LIRE ********************
		while read ligne
		do
			tab[$i]="$ligne"
			i=$(($i+1))
		done < /usr/local/var/lib/asterisk/users/$1.conf

		#***************** SUPPRIMER LE FICHER ****************************
		rm /usr/local/var/lib/asterisk/users/$1.conf

		#************** REECRIRE LE FICHIER AVEC LES NOUVEAUX PARAMETRES ****************
		touch /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[0]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[1]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[2]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "context=mobile" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[4]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[5]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[6]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "${tab[7]}" >> /usr/local/var/lib/asterisk/users/$1.conf
		echo "callerid=<$3>" >> /usr/local/var/lib/asterisk/users/$1.conf

		service asterisk reload

	else
		echo "Veuillez saisir un numero de telephone mobile correct."
	fi
elif [[ ! -z "$1" && ! -z "$2" && "$2" -eq 1 ]]
then
	#******************* TROUVER LE FICHIER SIP DE L'UTILISATEUR ET LE LIRE ********************
	while read ligne
	do
		tab[$i]="$ligne"
		i=$(($i+1))
	done < /usr/local/var/lib/asterisk/users/$1.conf

	#***************** SUPPRIMER LE FICHER ****************************
	rm /usr/local/var/lib/asterisk/users/$1.conf

	#************** REECRIRE LE FICHIER AVEC LES NOUVEAUX PARAMETRES ****************
	touch /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[0]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[1]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[2]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "context=somecontext" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[4]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[5]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[6]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[7]}" >> /usr/local/var/lib/asterisk/users/$1.conf
	echo "${tab[8]}" >> /usr/local/var/lib/asterisk/users/$1.conf

	service asterisk reload

else
	echo "Veuillez renseigner au moins les deux premiers parametres (username - transfert (0(oui)/1(non)) - numero mobile)."
fi
