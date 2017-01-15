#! /usr/local/bin/bash

# Script de creation et de suppression des salles de conference prenant en parametres

# $1=creation(0)/suppression(1)
# $2=nom de la salle de conference
# $3=numero de la salle de conference
# $4=admin(0(oui)/1(non))
# $5=nom utilisateur mdp 
# $6=mot de passe 4 chiffres

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" && ! -z "$4" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ && "$4" =~ ^[0-1]{1}$ ]]
	then
		if [[ "$1" -eq 0 ]]
		then
			if [[ ! -f "/usr/local/var/lib/asterisk/room_conference/$2.conf" ]]
			then
				if [[ "$4" -eq 0 ]]
				then
					user="user_admin"
				elif [[ ! -z "$5" && ! -z "$6" ]]
				then
					if [[ ! -f "/usr/local/var/lib/asterisk/users_conference/$5.conf" ]]
					then
						# A indenter correctement putain de terminal
						touch /usr/local/var/lib/asterisk/users_conference/$5.conf
						echo "[$5]" >> /usr/local/var/lib/asterisk/users_conference/$5.conf
							echo "type=user" >> /usr/local/var/lib/asterisk/users_conference/$5.conf
						echo "admin=no" >> /usr/local/var/lib/asterisk/users_conference/$5.conf
							echo "music_on_hold_when_empty=yes" >> /usr/local/var/lib/asterisk/users_conference/$5.conf
							echo "announce_user_count=yes" >> /usr/local/var/lib/asterisk/users_conference/$5.conf
							echo "pin=$6" >> /usr/local/var/lib/asterisk/users_conference/$5.conf

							echo "#include \"/usr/local/var/lib/asterisk/users_conference/$5.conf\"" >> /usr/local/etc/asterisk/confbridge.conf
							user="$5"
						else
							echo "Cet utilisateur existe deja, veuillez choisir un autre nom."
						fi
					else
						echo "Votre mot de passe est invalide ou il manque le nom du nouvel utilisateur."
					fi
				else
					user="user_nomdp"
				fi

				if [[ "$3" =~ ^9[0-9]{1}$ ]] # penser a verifier si le numero existe deja via bdd !!!!
				then
					touch /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "[$2]" >> /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "type=bridge" >> /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "max_members=10" >> /usr/local/var/lib/asterisk/room_conference/$2.conf

					echo "#include \"/usr/local/var/lib/asterisk/room_conference/$2.conf\"" >> /usr/local/etc/asterisk/confbridge.conf
					echo "exten => $3,1,Macro(confpub,$2,$2,$user,sample_user_menu)" >> /usr/local/var/lib/asterisk/context/conference.conf
					service asterisk reload
				else
					echo "Votre numero est invalide ou ce contexte n'existe pas."
				fi
			else
				echo "Cette salle existe deja."
			fi
		elif [[ "$1" -eq 1 ]]
		then
			if [[ ! -z $5 ]]
			then
				if [[ -f "/usr/local/var/lib/asterisk/users_conference/$5.conf" ]]
				then
					rm /usr/local/var/lib/asterisk/users_conference/$5.conf
				else
					" L'utilisateur mdp n'a pas pu etre supprime, son fichier est inexistant."
				fi
			fi
			if [[ -f "/usr/local/var/lib/asterisk/room_conference/$2.conf" ]] 
			then
				if [[ "$3" =~ ^9[0-9]{1}$ ]]
				then
					chemin="exten => $3,1,Macro(confpub,$2"
					ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/context/conference.conf`
					num=`echo $ligne | cut -d':' -f1`
					if [[ ! -z "$num" ]]
					then
						sed -i".sav" "$num d" /usr/local/var/lib/asterisk/context/conference.conf

						rm /usr/local/var/lib/asterisk/room_conference/$2.conf
						service asterisk reload
					else
						echo "Impossible de supprimer votre conference, elle n'est pas présente dans le contexte."
					fi
				else
					echo "le contexte est introuvable OU le switch est invalable."
				fi

			else
				echo "Cette salle est introuvable"
			fi
		fi
	else
		echo "Veuillez saisir correctement le premier parametre."
	fi
else
	echo "Veuillez renseigner au moins les quatre premiers parametres (creation(0)/suppression(1) - nom de la salle de conference - numero de la salle(pour la joindre sur deux chiffres entre 90 et 99) - role (admin ou user) - le nom de l'utilisateur mot de passe - mot de passe(4chiffres))."
fi
