#! /usr/local/bin/bash

# Script de creation et de suppression des salles de conference prenant en parametres

# $1=creation(0)/suppression(1)
# $2=nom de la salle de conference
# $3=numero de la salle de conference
# $4=contexte ou on place la salle de conference
# $5=mot de passe(4 chiffres)
# $6=nom du nouvel utilisateur mdp 

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" && ! -z "$4" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		if [[ "$1" -eq 0 ]]
		then
			if [[ ! -f "/usr/local/var/lib/asterisk/room_conference/$2.conf" ]]
			then
				if [[ ! -z "$5" ]]
				then
					if [[ "$5" =~ ^[0-9]{4}$ && ! -z "$6" ]]
					then
						if [[ ! -f "/usr/local/var/lib/asterisk/users_conference/$6.conf" ]]
						then
							touch /usr/local/var/lib/asterisk/users_conference/$6.conf
							echo "[$6]" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
							echo "type=user" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
							echo "admin=no" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
							echo "music_on_hold_when_empty=yes" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
							echo "announce_user_count=yes" >> /usr/local/var/lib/asterisk/users_conference/$6.conf
							echo "pin=$5" >> /usr/local/var/lib/asterisk/users_conference/$6.conf

							echo "#include \"/usr/local/var/lib/asterisk/users_conference/$6.conf\"" >> /usr/local/etc/asterisk/confbridge.conf
							user="$6"
						else
							echo "cet utilisateur existe deja, veuillez choisir un autre nom."
						fi
					else
						echo "Votre mot de passe est invalide ou il manque le nom du nouvel utilisateur."
					fi
				else
					user="user_nomdp"
				fi

				if [[ "$3" =~ ^[90-99]{2}$ && -f /usr/local/var/lib/asterisk/context/$4.conf ]] # penser a verifier si le numero existe deja !!!!
				then
					touch /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "[$2]" >> /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "type=bridge" >> /usr/local/var/lib/asterisk/room_conference/$2.conf
					echo "max_members=10" >> /usr/local/var/lib/asterisk/room_conference/$2.conf

					echo "#include \"/usr/local/var/lib/asterisk/room_conference/$2.conf\"" >> /usr/local/etc/asterisk/confbridge.conf
					echo "exten => $3,1,Macro(confpub,$2,$2,$user,sample_user_menu)" >> /usr/local/var/lib/asterisk/context/$4.conf
					service asterisk reload
				else
					echo "Votre numero est invalide ou ce contexte n'existe pas."
				fi
			else
				echo "Cette salle existe deja."
			fi
		elif [[ "$1" -eq 1 ]]
		then
			if [[ -f "/usr/local/var/lib/asterisk/room_conference/$2.conf" ]] # si le temps, supprimer aussi l'utilisateur mdp
			then
				if [[ -f "/usr/local/var/lib/asterisk/context/$4.conf" && "$3" =~ ^[90-99]{2}$ ]]
				then
					chemin="exten => $3,1,Macro(confpub,$2"
					ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/context/$4.conf`
					num=`echo $ligne | cut -d':' -f1`
					if [[ ! -z "$num" ]]
					then
						sed -i".sav" "$num d" /usr/local/var/lib/asterisk/context/$4.conf

						rm /usr/local/var/lib/asterisk/room_conference/$2.conf
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
	echo "Veuillez renseigner au moins les quatre premiers parametres (creation(0)/suppression(1) - nom de la salle de conference - numero de la salle(pour la joindre sur deux chiffres entre 90 et 99) - le contexte ou il y aura son exten - le mot de passe - le nom de l'utilisateur mot de passe)."
fi