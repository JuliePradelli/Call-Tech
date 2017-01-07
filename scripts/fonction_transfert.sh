#! /usr/local/bin/bash

# script de modification de l'option de transfert d'un utilisateur, il prend en parametres

#$1=login utilisateur(username dans sip.conf)
#$2=contexte
#$3=option de transfert(0=oui/1=non)
#$4=numero de mobile

tab=()
i=0

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]]
then
	if [[ "$3" -eq 0 && ! -z "$4" ]]
	then	
		if [[ "$4" =~ ^06[0-9]{8}$ && -f /usr/local/var/lib/asterisk/users/$1.conf && -f /usr/local/var/lib/asterisk/context/$2.conf ]]
		then
			#******************* TROUVER LE FICHIER SIP DE L'UTILISATEUR ET LE LIRE ********************
			while read ligne
			do
				tab[$i]="$ligne"
				i=$(($i+1))
			done < /usr/local/var/lib/asterisk/users/$1.conf

			#***************** SUPPRIMER LE FICHER ****************************
			rm /usr/local/var/lib/asterisk/users/$1.conf

			#**************** RECUPERER L'EXTEN *******************************
			transition=`echo ${tab[0]} | cut -d'[' -f2`
			exten=`echo $transition | cut -d']' -f1`

			#************** REECRIRE LE FICHIER AVEC LES NOUVEAUX PARAMETRES ****************
			touch /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[0]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[1]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[2]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "context=$2" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[4]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[5]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[6]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[7]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "callerid=\"tranfertmob\"<$4>" >> /usr/local/var/lib/asterisk/users/$1.conf

			echo "exten => $exten,1,Macro(transfertmob,SIP/$exten,$4)" >> /usr/local/var/lib/asterisk/context/$2.conf

			#***************** EFFACER LES TRACES DE VOICEMAIL ************************
			#***************** RECUPERER L'ANCIEN CONTEXTE****************************
			contexte=`echo ${tab[3]} | cut -d'=' -f2`

			#***************** RECHERCHER LA TRACE DANS L'ANCIEN CONTEXTE ****************
			chemin1="exten => $exten,1,Macro(voicemail,"
			ligne1=`grep -n "$chemin1" /usr/local/var/lib/asterisk/context/$contexte.conf`
			if [[ ! -z $ligne1 ]]
			then
				num1=`echo $ligne1 | cut -d':' -f1`
				sed -i".sav" "$num1 d" /usr/local/var/lib/asterisk/context/$contexte.conf
			else
				echo "boucle ventrale"
			fi

			service asterisk reload
		fi
	elif [[ "$3" -eq 1 ]]
	then
		if [[ -f /usr/local/var/lib/asterisk/users/$1.conf && -f /usr/local/var/lib/asterisk/context/$2.conf ]]
		then
			#******************* TROUVER LE FICHIER SIP DE L'UTILISATEUR ET LE LIRE ********************
			while read ligne
			do
				tab[$i]="$ligne"
				i=$(($i+1))
			done < /usr/local/var/lib/asterisk/users/$1.conf

			#***************** SUPPRIMER LE FICHER ****************************
			rm /usr/local/var/lib/asterisk/users/$1.conf

			#**************** RECUPERER L'EXTEN *******************************
			transition=`echo ${tab[0]} | cut -d'[' -f2`
			exten=`echo $transition | cut -d']' -f1`

			#************** REECRIRE LE FICHIER AVEC LES NOUVEAUX PARAMETRES ****************
			touch /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[0]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[1]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[2]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "context=$2" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[4]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[5]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[6]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "${tab[7]}" >> /usr/local/var/lib/asterisk/users/$1.conf
			echo "callerid=\"voicemail\"<>" >> /usr/local/var/lib/asterisk/users/$1.conf

			echo "exten => $exten,1,Macro(voicemail,SIP/$exten,$exten@default)" >> /usr/local/var/lib/asterisk/context/$2.conf

			#***************** EFFACER LES TRACES DE TRANSFERTMOB ************************
			#***************** RECUPERER L'ANCIEN CONTEXTE****************************
			contexte=`echo ${tab[3]} | cut -d'=' -f2`

			#***************** RECHERCHER LA TRACE DANS L'ANCIEN CONTEXTE ****************
			chemin1="exten => $exten,1,Macro(transfertmob,"
			ligne1=`grep -n "$chemin1" /usr/local/var/lib/asterisk/context/$contexte.conf`
			if [[ ! -z $ligne1 ]]
			then
				num1=`echo $ligne1 | cut -d':' -f1`
				sed -i".sav" "$num1 d" /usr/local/var/lib/asterisk/context/$contexte.conf
			else
				echo "boucle ventrale"
			fi

			service asterisk reload
		else
			echo "boucle seconde"
		fi
	else
		echo "boucle trois"
	fi

else
	echo "Veuillez renseigner au moins les deux premiers parametres (username - contexte - transfert (0(oui)/1(non)) - numero mobile)."
fi
