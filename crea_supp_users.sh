#! /usr/local/bin/bash

# script de creation des comptes utilisateurs prenant en parametres 

#$1=creation(0)/suppression(1)
#$2=login(username)
#$3=mdp
#$4=mail
#$5=extension
#$6=contexte
#$7=mobile

if [[ ! -z "$1" && ! -z "$2" ]]
then
	if [[ ! -f "/usr/local/var/lib/asterisk/users/$2.conf" ]]
	then	
		existence=0
	else
		existence=1
	fi
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		# ******************** CREATION USER ********************************
		if [[ "$1" -eq 0 && ! -z "$3" && ! -z "$4" && ! -z "$5" && ! -z "$6" ]] 
		then
			if [[ "$5" =~ ^[0-9]{2}$ && "$6" =~ ((mobile)$|(somecontext)$) ]] # ici regex mail et verif pas d'espace ds username
			then
				# ******************** MOBILE ********************************
				if [[ "$6" -eq "mobile" && ! -z "$7" && "$existence" -eq 0 ]]
				then
					if [[ "$7" =~ ^06[0-9]{8}$ ]]
					then
						touch /usr/local/var/lib/asterisk/users/$2.conf
						echo "[$5]" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "type=friend" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "host=dynamic" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "context=$6" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "disallow=all" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "allow=ulaw" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "secret=$3" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "username=$2" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "mailbox=$4" >> /usr/local/var/lib/asterisk/users/$2.conf
						echo "callerid=<$7>" >> /usr/local/var/lib/asterisk/users/$2.conf
		
						echo "#include \"/usr/local/var/lib/asterisk/users/$2.conf\"" >> /usr/local/etc/asterisk/sip.conf
						
						echo "$5 => 123,$2,$4" >> /usr/local/etc/asterisk/voicemail.conf
						service asterisk reload
					else
						echo "Veuillez renseigner un numero de telephone mobile valide."
					fi
				# ******************** SOMECONTEXT ********************************
				elif [[ "$6" -eq "somecontext" && "$existence" -eq 0 ]]
				then
					touch /usr/local/var/lib/asterisk/users/$2.conf
					echo "[$5]" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "type=friend" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "host=dynamic" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "context=$6" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "disallow=all" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "allow=ulaw" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "secret=$3" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "username=$2" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "mailbox=$4" >> /usr/local/var/lib/asterisk/users/$2.conf
					echo "callerid=<>" >> /usr/local/var/lib/asterisk/users/$2.conf
		
					echo "#include \"/usr/local/var/lib/asterisk/users/$2.conf\"" >> /usr/local/etc/asterisk/sip.conf
				
					echo "$5 => 123,$2,$4" >> /usr/local/etc/asterisk/voicemail.conf
					service asterisk reload
				else
					echo "cet utilisateur existe deja"
				fi
			else
				echo "Veuillez saisir correctement les parametres 5 et 6."
			fi
		# ******************** DESTRUCTION USER ********************************
		elif [[ $1 -eq 1 && "$existence" -eq 1 ]]
		then
			rm /usr/local/var/lib/asterisk/users/$2.conf
			chemin="#include \"/usr/local/var/lib/asterisk/users/$2.conf\""
			ligne=`grep -n "$chemin" /usr/local/etc/asterisk/sip.conf`
			num=`echo $ligne | cut -d':' -f1`
			sed -i".sav" "$num d" /usr/local/etc/asterisk/sip.conf
			rm /usr/local/etc/asterisk/sip.conf.sav
			service asterisk reload
		else
			echo "Si vous voulez ajouter, il manque probablement des arguments et si vous voulez supprimer, cet user n'existe pas."
		fi
	else
		echo "Veuillez renseigner correctement tous les champs (pour davantages d'informations ./creation_users.sh)."
	fi
else
	echo "Veuillez renseigner au moins les deux premiers parametres (creation(0)/suppression(1) - username - mot de passe - mail personnel - extension(obligatoirement 2 chiffres) - contexte(mobile ou somecontext) - numéro mobile)."
fi
