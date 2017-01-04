#! /usr/local/bin/bash

# script de modification des horaires du standard quiu prend en parametres

#$1=heure de debut (format hh:mm ou h:mm en fonction de l'heure)
#$2=heure de fin (format hh:mm ou h:mm en fonction de l'heure)
#$3=jour de la semaine: debut (mon/tue/wed/thu/fri/sat/sun)
#$4=jour de la semaine: fin (mon/tue/wed/thu/fri/sat/sun)
#$5=jour du mois de debut (1-31)
#$6=jour du mois de fin (1-31)
#$7=mois de debut (jan/feb/mar/apr/may/jun/jul/aug/sep/oct/nov/dec)
#$8=mois de fin (jan/feb/mar/apr/may/jun/jul/aug/sep/oct/nov/dec)

star="r"
if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" && ! -z "$4" && ! -z "$5" && ! -z "$6" && ! -z "$7" && ! -z "$8" ]]
then
	# *************************************** HEURE ****************************************
	if [[ "$1" =~ ^[0-9]{1,2}\:[0-9]{2}$ && "$2" =~ ^[0-9]{1,2}\:[0-9]{2}$ && "$1" != "$2" ]]
	then	
		h="$1-$2"
		echo "$h"
	elif [[ "$1" = $star && "$2" = $star ]]
	then	
		h="*"
		echo "$h"
	else
		echo "Veuillez saisir deux heures differentes ou deux r."
	fi
	# *************************************** JOUR DE LA SEMAINE ****************************************
	if [[ "$3" =~ ((mon)$|(tue)$|(wed)$|(thu)$|(fri)$|(sat)$|(sun)$) && "$4" =~ ((mon)$|(tue)$|(wed)$|(thu)$|(fri)$|(sat)$|(sun)$) && "$3" == "$4" ]]
	then
		d="$3"
		echo "pb $d"
	elif [[ "$3" =~ ((mon)$|(tue)$|(wed)$|(thu)$|(fri)$|(sat)$|(sun)$) && "$4" =~ ((mon)$|(tue)$|(wed)$|(thu)$|(fri)$|(sat)$|(sun)$) && "$3" != "$4" ]]
	then
		d="$3-$4"
		echo "sb $d"
	elif [[ "$3" = $star && "$4" = $star ]]
	then
		d="*"
		echo "$d"
	elif [[ "$3" =~ ((mon)$|(tue)$|(wed)$|(thu)$|(fri)$|(sat)$|(sun)$) && "$4" = $star ]]
	then
		d="$3"
		echo "$d"
	elif [[ "$4" =~ ((mon)$|(tue)$|(wed)$|(thu)$|(fri)$|(sat)$|(sun)$) && "$3" = $star ]]
	then
		d="$4"
		echo "$d"
	else
		echo "Veuillez saisir correctement les parametres 3 et 4."
	fi
	# *************************************** JOUR DU MOIS ****************************************
	if [[ "$5" =~ ^[1-31]{1,2}$ && "$6" =~ ^[1-31]{1,2}$ && "$5" == "$6" ]]
	then
		dm="$5"
		echo $dm
	elif [[ "$5" =~ ^[1-31]{1,2}$ && "$6" =~ ^[1-31]{1,2}$ && "$5" != "$6" ]]
	then
		dm="$5-$6"
		echo $dm
	elif [[ "$5" = $star && "$6" = $star ]]
	then
		dm="*"
		echo "$dm"
	elif [[ "$5" =~ ^[1-31]{1,2}$ && "$6" = $star ]]
	then
		dm="$5"
		echo $dm
	elif [[ "$6" =~ ^[1-31]{1,2}$ && "$5" = $star ]]
	then
		dm="$6"
		echo $dm
	else
		echo "Veuillez saisir correctement les parametres 5 et 6."
	fi
	# *************************************** MOIS ****************************************
	if [[ "$7" =~ ((jan)$|(feb)$|(mar)$|(apr)$|(may)$|(jun)$|(jul)$|(aug)$|(sep)$|(oct)$|(nov)$|(dec)$) && "$8" =~ ((jan)$|(feb)$|(mar)$|(apr)$|(may)$|(jun)$|(jul)$|(aug)$|(sep)$|(oct)$|(nov)$|(dec)$) && "$7" == "$8" ]]
	then
		m="$7"
		echo $m
	elif [[ "$7" =~ ((jan)$|(feb)$|(mar)$|(apr)$|(may)$|(jun)$|(jul)$|(aug)$|(sep)$|(oct)$|(nov)$|(dec)$) && "$8" =~ ((jan)$|(feb)$|(mar)$|(apr)$|(may)$|(jun)$|(jul)$|(aug)$|(sep)$|(oct)$|(nov)$|(dec)$) && "$7" != "$8" ]]
	then
		m="$7-$8"
		echo $m
	elif [[ "$7" = $star && "$8" = $star ]]
	then
		m="*"
		echo "$m"
	elif [[ "$7" =~ ((jan)$|(feb)$|(mar)$|(apr)$|(may)$|(jun)$|(jul)$|(aug)$|(sep)$|(oct)$|(nov)$|(dec)$) && "$8" = $star ]]
	then
		m="$7"
		echo $m
	elif [[ "$8" =~ ((jan)$|(feb)$|(mar)$|(apr)$|(may)$|(jun)$|(jul)$|(aug)$|(sep)$|(oct)$|(nov)$|(dec)$) && "$7" = $star ]]
	then
		m="$8"
		echo $m
	else
		echo "Veuillez saisir correctement les parametres 7 et 8."
	fi
	# ********************************** COMPOSITION FINALE ***********************************
	if [[ ! -z "$h" && ! -z "$d" && ! -z "$dm" && ! -z "$m" ]]
	then
		var="$h","$d","$dm","$m"
		tab=()
		i=0
		while read ligne
		do
			tab[$i]="$ligne"
			echo "$ligne"
			i=$(($i+1))
		done < /usr/local/var/lib/asterisk/context/standard.conf

		#************** REECRITURE DU FICHIER AVEC LE SNOUVEAUX PARAMETRES ****************
		rm /usr/local/var/lib/asterisk/context/standard.conf
		touch /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[0]}" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[1]}" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[2]}" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[3]}" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "exten => 50,n,GotoIfTime($var?open:close)" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[5]}" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[6]}" >> /usr/local/var/lib/asterisk/context/standard.conf
		echo "${tab[7]}" >> /usr/local/var/lib/asterisk/context/standard.conf

		service asterisk reload
	fi
else
	echo "Veuillez renseigner tous les parametres (heure de debut (format hh:mm ou h:mm en fonction de l'heure) - heure de fin (format hh:mm ou h:mm en fonction de l'heure) - jour de la semaine: debut (mon/tue/wed/thu/fri/sat/sun) - jour de la semaine: fin (mon/tue/wed/thu/fri/sat/sun) - jour du mois de debut (1-31) - jour du mois de fin (1-31) - mois de debut (jan/feb/mar/apr/may/jun/jul/aug/sep/oct/nov/dec) - mois de fin (jan/feb/mar/apr/may/jun/jul/aug/sep/oct/nov/dec)). Vous avez tj la possibilite de saisir r pour choix indefini."
fi
