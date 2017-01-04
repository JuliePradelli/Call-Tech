#! /usr/local/bin/bash

# Script de creation et de suppression des gateways (entrantes et sortantes) qui prend en parametre

#$1=creation(0)/suppression(1)
#$2=login
#$3=mot de passe
#$4=adresse de gateway

if [[ ! -z "$1" && ! -z "$2" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		# **************************************** CREATION ***********************************************
		if [[ "$1" -eq 0 ]]
		then
			if [[ ! -z "$3" && ! -z "$4" ]]
			then
				if [[ ! -f /usr/local/var/lib/asterisk/users/$2_incoming.conf && ! -f /usr/local/var/lib/asterisk/users/$2_outgoing.conf ]]
				then
					touch /usr/local/var/lib/asterisk/users/$2_incoming.conf
					echo "[$2_incoming]" >> /usr/local/var/lib/asterisk/users/$2_incoming.conf
					echo "type=peer" >> /usr/local/var/lib/asterisk/users/$2_incoming.conf
					echo "host=$4" >> /usr/local/var/lib/asterisk/users/$2_incoming.conf
					echo "context=from_$2" >> /usr/local/var/lib/asterisk/users/$2_incoming.conf
					echo "nat=yes" >> /usr/local/var/lib/asterisk/users/$2_incoming.conf
					echo "canreinvite=no" >> /usr/local/var/lib/asterisk/users/$2_incoming.conf

					touch /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "[$2_outgoing]" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "type=peer" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "host=$4" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "username=$2" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "secret=$3" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "fromuser=$2" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "fromdomain=$4" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "nat=yes" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					echo "canreinvite=no" >> /usr/local/var/lib/asterisk/users/$2_outgoing.conf
					
					echo "#include \"/usr/local/var/lib/asterisk/users/$2_incoming.conf\"" >> /usr/local/etc/asterisk/sip.conf
					echo "#include \"/usr/local/var/lib/asterisk/users/$2_outgoing.conf\"" >> /usr/local/etc/asterisk/sip.conf
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
			if [[ -f /usr/local/var/lib/asterisk/users/$2_incoming.conf && -f /usr/local/var/lib/asterisk/users/$2_outgoing.conf ]]
			then 
				rm /usr/local/var/lib/asterisk/users/$2_incoming.conf 
				rm /usr/local/var/lib/asterisk/users/$2_outgoing.conf 
				chemin1="#include \"/usr/local/var/lib/asterisk/users/$2_incoming.conf\""
				ligne1=`grep -n "$chemin1" /usr/local/etc/asterisk/sip.conf`
				chemin2="#include \"/usr/local/var/lib/asterisk/users/$2_outgoing.conf\""
				ligne2=`grep -n "$chemin2" /usr/local/etc/asterisk/sip.conf`
				if [[ ! -z $ligne1 && ! -z $ligne2 ]]
				then
					num1=`echo $ligne1 | cut -d':' -f1`
					sed -i".sav""$num1 d" /usr/local/etc/asterisk/sip.conf
					num2=`echo $ligne2 | cut -d':' -f1`
					sed -i".sav""$num2 d" /usr/local/etc/asterisk/sip.conf
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
	echo "Veuillez saisir au moins les deux premiers parametres (creation(0)/suppression(1) - login - mot de passe - adresse de gateway)"
fi
