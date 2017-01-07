#! /usr/local/bin/bash

# script de creation des conntextes preant en parametres 

#$1=creation(0)/suppression(1)
#$2=nom

if [[ ! -z "$1" && ! -z "$2" ]]
then
	if [[ ! -f "/usr/local/var/lib/asterisk/context/$2.conf" ]]
	then	
		existence=0
	else
		existence=1
	fi
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		# ******************** CREATION CONTEXTE ********************************
		if [[ "$1" -eq 0 && "$existence" -eq 0 ]] 
		then
			touch /usr/local/var/lib/asterisk/context/$2.conf
			echo "[$2]" >> /usr/local/var/lib/asterisk/context/$2.conf
			echo "include => standard" >> /usr/local/var/lib/asterisk/context/$2.conf
			echo "include => conference" >> /usr/local/var/lib/asterisk/context/$2.conf

			echo "include => $2" >> /usr/local/var/lib/asterisk/context/standard.conf

			echo "#include \"/usr/local/var/lib/asterisk/context/$2.conf\"" >> /usr/local/etc/asterisk/extensions.conf

			service asterisk reload
		# ******************** DESTRUCTION CONTEXTE ********************************
		elif [[ "$1" -eq 1 && "$existence" -eq 1 ]]
		then
			rm /usr/local/var/lib/asterisk/context/$2.conf
			chemin1="#include \"/usr/local/var/lib/asterisk/context/$2.conf\""
			ligne1=`grep -n "$chemin1" /usr/local/etc/asterisk/extensions.conf`
			chemin2="include => $2"
			ligne2=`grep -n "$chemin2" /usr/local/var/lib/asterisk/context/standard.conf`
			if [[ ! -z $ligne1 && ! -z $ligne2 ]]
			then
				num1=`echo $ligne1 | cut -d':' -f1`
				sed -i".sav" "$num1 d" /usr/local/etc/asterisk/extensions.conf
				rm /usr/local/etc/asterisk/extensions.conf.sav
				num2=`echo $ligne2 | cut -d':' -f1`
				sed -i".sav" "$num2 d" /usr/local/var/lib/asterisk/standard.conf
				rm /usr/local/etc/asterisk/standard.conf.sav
				service asterisk reload
			else
				echo "Nous n'avons pas pu supprimer ce contexte."
			fi
		else
			echo "Si vous voulez ajouter, le fichier existe deja; si vous voulez supprimer, le fichier n'existe pas."
		fi
	else
		echo "Le premier champ est mal renseign√."
	fi
else
	echo "Veuillez renseigner les 3 parametres (creation(0)/suppression(1) - nom)."
fi
