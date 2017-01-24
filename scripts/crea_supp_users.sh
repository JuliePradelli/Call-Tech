#! /usr/local/bin/bash

# script de creation des comptes utilisateurs prenant en parametres 

#$1=creation(0)/suppression(1)
#$2=login(username)
#$3=mdp
#$4=mail
#$5=extension
#$6=contexte
#$7=transfert mobile(0(oui)/1(non))
#$8=mobile

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
		if [[ "$1" -eq 0 && ! -z "$3" && ! -z "$4" && ! -z "$5" && ! -z "$6" && ! -z "$7" ]] 
		then
			if [[ "$5" =~ ^[0-9]{2}$ && "$4" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$ ]]
			then
				# ******************** TRANSFERT MOBILE ********************************
				if [[ "$7" -eq 0 && "$existence" -eq 0 ]]
				then
					if [[ ! -z "$8" ]]
					then
						if [[ "$8" =~ ^06[0-9]{8}$ ]]
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
							echo "callerid=\"transfertmob\"<$8>" >> /usr/local/var/lib/asterisk/users/$2.conf

							if [[ "$6" == "default" ]]
							then
								name="DONOTDELETE_default.sys"
							else
								name="$6.conf"
							fi

							echo "exten => $5,1,Macro(transfertmob,SIP/$5,$8)" >> /usr/local/var/lib/asterisk/context/$name
		
							echo "#include \"/usr/local/var/lib/asterisk/users/$2.conf\"" >> /usr/local/etc/asterisk/sip.conf
						
							echo "$5 => 123,$2,$4" >> /usr/local/etc/asterisk/voicemail.conf
							service asterisk reload
						else
							echo "Veuillez taper un numero mobile valide."
						fi
					else
						echo "Veuillez renseigner un numero de telephone mobile valide."
					fi
				# ******************** PAS DE TRANSFERT MOBILE ********************************
				elif [[ "$7" -eq 1 && "$existence" -eq 0 ]]
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
					echo "callerid=\"voicemail\"<>" >> /usr/local/var/lib/asterisk/users/$2.conf
					
					if [[ "$6" == "default" ]]
					then
						name="DONOTDELETE_default.sys"
					else
						name="$6.conf"
					fi

					echo "exten => $5,1,Macro(voicemail,SIP/$5,$5@default)" >> /usr/local/var/lib/asterisk/context/$name
		
					echo "#include \"/usr/local/var/lib/asterisk/users/$2.conf\"" >> /usr/local/etc/asterisk/sip.conf
				
					echo "$5 => 123,$2,$4" >> /usr/local/etc/asterisk/voicemail.conf
					service asterisk reload
				else
					echo "Cet utilisateur existe deja."
				fi
			else
				echo "Veuillez saisir correctement les parametres 4, 5 et 6."
			fi
		# ******************** DESTRUCTION USER ********************************
		elif [[ $1 -eq 1 && "$existence" -eq 1 ]]
		then
			# **************** RECHERCHE DE L'EXTEN DANS LE SIP DE L'UTILISATEUR *****************
			ligne4=`sed -n '1p' /usr/local/var/lib/asterisk/users/$2.conf`
			num4=`echo $ligne4 | cut -d'[' -f2`
			exten=`echo $num4 | cut -d']' -f1`
			# ************** RECUPERATION DU CONTEXTE POUR Y EFFACER LA LIGNE *******************
			ligne7=`sed -n '4p' /usr/local/var/lib/asterisk/users/$2.conf`
			context=`echo $ligne7 | cut -d'=' -f2`
			if [[ "$context" == "default" ]]
			then
				context="DONOTDELETE_default.sys"
			else
				context="$context.conf"
			fi
			# ************** TROUVER LA LIGNE DE L'UTILISATEUR DANS LE CONTEXTE ******************
			chemin6="exten => $exten"
			ligne6=`grep -n "$chemin6" /usr/local/var/lib/asterisk/context/$context`
			# ************* EFFACER LA LIGNE ***************
			if [[ ! -z "$ligne6" ]]
			then
				num6=`echo $ligne6 | cut -d':' -f1`
				sed -i".sav" "$num6 d" /usr/local/var/lib/asterisk/context/$context
			fi
			# **************** EFFACER LE FICHIER SIP DE L'UTILISATEUR *********************
			rm /usr/local/var/lib/asterisk/users/$2.conf
			# **************** RECHERCHER L'INCLUDE DANS LE SIP.CONF *******************
			chemin1="#include \"/usr/local/var/lib/asterisk/users/$2.conf\""
			ligne1=`grep -n "$chemin1" /usr/local/etc/asterisk/sip.conf`
			# **************** RECHERCHER LA BOITE VOCALE *******************
			chemin2="$2"
			ligne2=`grep -n "$chemin2" /usr/local/etc/asterisk/voicemail.conf`
			# **************** EFFACER L'INCLUDE DANS LE SIP.CONF ET LA BOITE VOCALE *******************
			if [[ ! -z $ligne1 && ! -z $ligne2 ]]
			then
				num1=`echo $ligne1 | cut -d':' -f1`
				sed -i".sav" "$num1 d" /usr/local/etc/asterisk/sip.conf
				rm /usr/local/etc/asterisk/sip.conf.sav
				num2=`echo $ligne2 | cut -d':' -f1`
				sed -i".sav" "$num2 d" /usr/local/etc/asterisk/voicemail.conf
				rm /usr/local/etc/asterisk/voicemail.conf.sav
				service asterisk reload
			else
				echo "Nous n'avons pas pu supprimer cet utilisateur"
			fi
		else
			echo "Si vous voulez ajouter, il manque probablement des arguments et si vous voulez supprimer, cet user n'existe pas."
		fi
	else
		echo "Veuillez renseigner correctement tous les champs (pour davantages d'informations ./crea_supp_users.sh)."
	fi
else
	echo "Veuillez renseigner au moins les deux premiers parametres (creation(0)/suppression(1) - username - mot de passe - mail personnel - extension(obligatoirement 2 chiffres) - contexte(default si vous ne savez pas) - transfert mobile(0(oui)/1(non) - numero mobile)."
fi
