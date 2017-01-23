#! /usr/local/bin/bash

# Script de creation et de suppression des gateways (entrantes et sortantes) qui prend en parametre

####CREATION####
#$1=creation(0)/suppression(1)
#$2=login
#$3=mot de passe
#$4=adresse de gateway
#$5=contexte ou mettre les appels entrants
#$6=port
#$7=nom de l'utilisateur entrant
#$8=nom de l'utilisateur sortant

####SUPPRESSION####
#$1=creation(0)/suppression(1)
#$2=login
#$3=contexte ou mettre les appels entrants
#$4=nom de l'utilisateur entrant
#$5=nom de l'utilisateur sortant

if [[ ! -z "$1" && ! -z "$2" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		# **************************************** CREATION ***********************************************
		if [[ "$1" -eq 0 ]]
		then
			if [[ ! -z "$3" && ! -z "$4" && ! -z "$5" && ! -z "$6" && ! -z "$7" && ! -z "$8" ]]
			then
				if [[ ! -f /usr/local/var/lib/asterisk/users/$7.conf && ! -f /usr/local/var/lib/asterisk/users/$8.conf && ! -f /usr/local/var/lib/asterisk/context/$5.conf && "$6" =~ ^[0-9]{4}$ ]]
				then
					# utilisateur appel entrant
					touch /usr/local/var/lib/asterisk/users/$7.conf
					echo "[$7]" >> /usr/local/var/lib/asterisk/users/$7.conf
					echo "type=peer" >> /usr/local/var/lib/asterisk/users/$7.conf
					echo "host=$4" >> /usr/local/var/lib/asterisk/users/$7.conf
					echo "context=$5" >> /usr/local/var/lib/asterisk/users/$7.conf
					echo "nat=yes" >> /usr/local/var/lib/asterisk/users/$7.conf
					echo "canreinvite=no" >> /usr/local/var/lib/asterisk/users/$7.conf

					# utilisateur appel sortant
					touch /usr/local/var/lib/asterisk/users/$8.conf
					echo "[$8]" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "type=peer" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "host=$4" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "username=$2" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "secret=$3" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "fromuser=$2" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "fromdomain=$4" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "nat=yes" >> /usr/local/var/lib/asterisk/users/$8.conf
					echo "canreinvite=no" >> /usr/local/var/lib/asterisk/users/$8.conf

					# le register dans le sip et la partie general
					echo "register => $2:$3@$4:$6" >> /usr/local/var/lib/asterisk/users/DONOTDELETE_general.sys	

					# creation du contexte pour les appels entrants
					touch /usr/local/var/lib/asterisk/context/$5.conf
					echo "[$5]" >> /usr/local/var/lib/asterisk/context/$5.conf
					echo "exten => s,1,Dial(SIP/50,20)" >> /usr/local/var/lib/asterisk/context/$5.conf

					# include dans les differents fichiers
					echo "#include \"/usr/local/var/lib/asterisk/users/$7.conf\"" >> /usr/local/etc/asterisk/sip.conf
					echo "#include \"/usr/local/var/lib/asterisk/users/$8.conf\"" >> /usr/local/etc/asterisk/sip.conf
					echo "#include \"/usr/local/var/lib/asterisk/context/$5.conf\"" >> /usr/local/etc/asterisk/extensions.conf
					service asterisk reload
				else
					echo "Desolee, cette gateway existe deja."
				fi

			else
				echo "Pour la creation, les quatre parametres sont obligatoires. Pour plus d'informations, ./crea_supp_gtw.sh"
			fi
		# **************************************** DESTRUCTION ***********************************************
		elif [[ "$1" -eq 1 ]]
		then
			if [[ -f /usr/local/var/lib/asterisk/context/$3.conf && -f /usr/local/var/lib/asterisk/users/$4.conf && -f /usr/local/var/lib/asterisk/users/$5.conf ]]
			then 
				rm /usr/local/var/lib/asterisk/context/$3.conf 
				rm /usr/local/var/lib/asterisk/users/$4.conf 
				rm /usr/local/var/lib/asterisk/users/$5.conf 
				chemin1="#include \"/usr/local/var/lib/asterisk/users/$4.conf\""
				ligne1=`grep -n "$chemin1" /usr/local/etc/asterisk/sip.conf`
				chemin2="#include \"/usr/local/var/lib/asterisk/users/$5.conf\""
				ligne2=`grep -n "$chemin2" /usr/local/etc/asterisk/sip.conf`
				chemin3="#include \"/usr/local/var/lib/asterisk/context/$3.conf\""
				ligne3=`grep -n "$chemin3" /usr/local/etc/asterisk/extensions.conf`
				if [[ ! -z "$ligne1" && ! -z "$ligne2" && ! -z "$ligne3" ]]
				then
					num1=`echo $ligne1 | cut -d':' -f1`
					sed -i".sav" "$num1 d" /usr/local/etc/asterisk/sip.conf
					num2=`echo $ligne2 | cut -d':' -f1`
					sed -i".sav" "$num2 d" /usr/local/etc/asterisk/sip.conf
					num3=`echo $ligne3 | cut -d':' -f1`
					sed -i".sav" "$num3 d" /usr/local/etc/asterisk/extensions.conf
					service asterisk reload
				else
					echo "cette gateway a ete mal cree, nous n'avons pas pu la detruire."
				fi
			else
				echo "Cette gateway n'existe pas."
			fi
		fi
	fi
else
	echo "Veuillez saisir au moins les deux premiers parametres (CREATION creation(0)/suppression(1) - login - mot de passe - adresse de gateway - nom du contexte des apples entrants - port - nom de l'utilisateur pour les appels entrants - nom de l'utilisateur pour les appels sortants // SUPPRESSION creation(0)/suppression(1) - login - contexte des appels entrants - nom de l'utilisateur entrant - nom de l'utilisateur sortant)"
fi
