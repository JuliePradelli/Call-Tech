#! /usr/local/bin/bash

# script de creation et de suppression des callcenters qui prend en parametres 

#$1=creation(0)/suppression(1)
#$2=nom queue
#$3=strategie de distribution des appels (ringall, roundrobin, leastrecent, fewestcalls, random ou rrmemory)

if [[ ! -z "$1" && ! -z "$2" ]] 
then
	if [[ "$1" =~ ^[0-1]{1}$ ]]
	then
		# ******************** CREATION DE LA QUEUE ********************************
		if [ "$1" -eq 0 ]
		then
			if [[ "$3" =~ ((ringall)$|(roundrobin)$|(leastrecent)$|(fewestcalls)$|(random)$|(rrmemory)$) ]]
			then
				touch /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "[$2]" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "music=default" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "strategy=ringall" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "eventwhencalled=yes" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "timeout=15" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "retry=1" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "wrapuptime=0" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "maxlen=0" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "announce-frequency=90" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
				echo "announce-holdtime=yes" >> /usr/local/var/lib/asterisk/callcenters/$2_cc.conf

				echo "#include \"/usr/local/var/lib/asterisk/callcenters/$2_cc.conf\"" >> /usr/local/etc/asterisk/queues.conf
				service asterisk reload
			else
				echo "Veuillez renseigner correctement la strategie de distribution des appels (ringall, roundrobin, leastrecent, fewestcalls, random ou rrmemory)"
			fi
		# ******************** SUPPRESSION DE LA QUEUE ********************************
		elif [ "$1" -eq 1 ]
		then
			rm /usr/local/var/lib/asterisk/callcenters/$2_cc.conf
			chemin="#include \"/usr/local/var/lib/asterisk/callcenters/$2_cc.conf\""
			ligne=`grep -n "$chemin" /usr/local/etc/asterisk/queues.conf`
			num=`echo $ligne | cut -d':' -f1`
			sed -i".sav" "$num d" /usr/local/etc/asterisk/queues.conf
			rm /usr/local/etc/asterisk/queues.conf.sav
			service asterisk reload
		fi
	else
		echo "Nous vous rappelons que le premier parametre est obligatoirement 0 ou 1."
	fi
else
	echo "Veuillez renseigner au moins les deux premiers parametres (creation(0)/suppression(1) - nom de la queue - strategie de distribution d'appel."
fi
