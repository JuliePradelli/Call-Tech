#! /usr/local/bin/bash

# Script de creation et de suppression des salles de conference prenant en parametres

#### CREATION ####
# $1=creation(0)/suppression(1)
# $2=nom de la salle de conference
# $3=numero de la salle de conference
# $4=création utilisateur  admin (0 oui/1 non))
# $5=création user(mdp (0 oui/1 non))

# $6=nom utilisateur mdp 
# $7=mot de passe 4 chiffres

#### SUPPRESSION ####
# $1=creation(0)/suppression(1)
# $2=nom de la salle de conference
# $3=nom utilisateur mdp

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		#****************************** CREATION DES UTILISATEURS ***********************************
		if [[ "$1" -eq 0 && ! -z "$4" && ! -z "$5" ]]
		then
			if [[ "$4" =~ ^[0-1]{1}$ && "$5" =~ ^[0-1]{1}$ ]]
			then
				if [[ "$5" -eq 0 && ! -z "$6" && ! -z "$7" ]]
				then
					if [[ ! -f "/usr/local/var/lib/asterisk/users_conference/$6.conf" ]]
					then
						touch /usr/local/var/lib/asterisk/users_conference/$6.conf
						echo "[$5]" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
						echo "type=user" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
						echo "admin=no" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
						echo "music_on_hold_when_empty=yes" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
						echo "announce_user_count=yes" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
						echo "pin=$7" >> /usr/local/var/lib/asterisk/users_conference/$6.conf

						echo "#include \"/usr/local/var/lib/asterisk/users_conference/$6.conf\"" >> /usr/local/etc/asterisk/confbridge.conf
						user="$6"
					else
						echo "Cet utilisateur existe deja, veuillez choisir un autre nom."
					fi
				elif [[ "$5" -eq 1 ]]
				then
					user="user_nomdp"
				else
					echo "Si vous souhaitez un utilisateur mdp, veuillez saisir correctement tous les paramètres."
				fi
				#********************************* CREATION DE LA SALLE DE CONFERENCE *********************************
				if [[ "$3" =~ ^9[0-9]{1}$ ]]
				then
					touch /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "[$2]" >> /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "type=bridge" >> /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "max_members=10" >> /usr/local/var/lib/asterisk/room_conference/$2.conf

					echo "#include \"/usr/local/var/lib/asterisk/room_conference/$2.conf\"" >> /usr/local/etc/asterisk/confbridge.conf
					echo "exten => $3,1,Macro(confpub,$2,$2,$user,sample_user_menu)" >> /usr/local/var/lib/asterisk/context/conference.conf
					#****************************** CREATION DE L'ADMIN SI BESOIN ***********************************
					if [[ "$4" -eq 0 ]]
					then
						i=$(($3+1))
						echo "exten => $i,1,Macro(confpub,$2,$2,user_admin,sample_admin_menu)" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_conference.sys
					fi
					service asterisk reload
				else
					echo "Votre numero est invalide ou ce contexte n'existe pas."
				fi
			else
				echo "Cette salle existe deja"
			fi
		#****************************** SUPPRESSION DE LA CONFERENCE ***********************************
		elif [[ "$1" -eq 1 ]]
		then
			if [[ ! -z "$3" ]]
			then
				if [[ -f "/usr/local/var/lib/asterisk/users_conference/$3.conf" ]]
				then
					rm /usr/local/var/lib/asterisk/users_conference/$3.conf
					chemin="#include \"/usr/local/var/lib/asterisk/users_conference/$3.conf\""
					ligne=`grep -n "$chemin" /usr/local/etc/asterisk/confbridge.conf`
					num=`echo $ligne | cut -d':' -f1`
					if [[ ! -z "$num" ]]
					then
						sed -i".sav" "$num d" /usr/local/etc/asterisk/confbridge.conf
					fi
				else
					echo " L'utilisateur mdp n'a pas pu etre supprime, son fichier est inexistant."
				fi
			fi
			if [[ -f "/usr/local/var/lib/asterisk/room_conference/$2.conf" ]] 
			then
				rm /usr/local/var/lib/asterisk/room_conference/$2.conf
				chemin="$2"
				ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/context/DONOTDELETE_conference.sys`
				num=`echo $ligne | cut -d':' -f1`
				num1=`echo $ligne | cut -d')' -f2`
				num2=`echo $num1 | cut -d':' -f1`
				chemin3="#include \"/usr/local/var/lib/asterisk/room_conference/$2.conf\""
				ligne3=`grep -n "$chemin3" /usr/local/etc/asterisk/confbridge.conf`
				num3=`echo $ligne3 | cut -d':' -f1`
				if [[ ! -z "num3" ]]
				then
					sed -i".sav" "$num3 d" /usr/local/etc/asterisk/confbridge.conf
				fi
				if [[ ! -z "$num" && ! -z "$num2" ]]
				then
					sed -i".sav" "$num d" /usr/local/var/lib/asterisk/context/DONOTDELETE_conference.sys
					sed -i".sav" "$num2 d" /usr/local/var/lib/asterisk/context/DONOTDELETE_conference.sys
				elif [[ ! -z "$num" && -z "$num1" ]]
				then
					sed -i".sav" "$num d" /usr/local/var/lib/asterisk/context/DONOTDELETE_conference.sys
				else
					echo "Impossible de supprimer votre conference, elle n'est pas présente dans le contexte."
				fi

				service asterisk reload
			else
				echo "Cette salle est introuvable"
			fi
		fi
	else
		echo "Veuillez saisir correctement les cinq premiers parametres pour la creation et les deux premiers pour la suppression."
	fi
else
	echo "Veuillez renseigner au moins les cinq /2 premiers parametres (CREATION // creation(0)/suppression(1) - nom de la salle de conference - numero de la salle(pour la joindre sur deux chiffres entre 90 et 99) - utilisateur admin (0 oui/1 non)) - user(mdp (0 oui/1 non)) - le nom de l'utilisateur mot de passe - mot de passe(4chiffres) SUPPRESSION // creation(0)/suppression(1) -
nom de la salle de conference - nom utilisateur mdp)."
fi







