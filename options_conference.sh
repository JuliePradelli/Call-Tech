#! /usr/local/bin/bash

# Script de modification des options d'une salle de conference qui prend en parametres

# $1=utilisateur associe
# $2=mise en oeuvre(0)/suppression(1)
# $3=parametre a modifier(musique de fond lorsque l'utilisateur est seul(0), commencer la conference en mode mute(1), annoncer le denombrement des utilisateurs(2), annoncer si on est seul(3), eviter le bruit de fond(4), annoncer les entrees et les sorties(5))

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]] 
then
	if [[ -f /usr/local/var/lib/asterisk/users_conference/$1.conf && "$2" =~ ^[0-1]{1}$ && "$3" =~ ^[0-5]{1}$ ]]
	then
		if [[ "$3" -eq 0 ]]
		then
			chemin="music_on_hold_when_empty=yes"
			ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/users_conference/$1.conf`
		elif [[ "$3" -eq 1 ]]
		then
			chemin="startmuted=yes"
			ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/users_conference/$1.conf`
		elif [[ "$3" -eq 2 ]]
		then
			chemin="announce_user_count_all=yes"
			ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/users_conference/$1.conf`
		elif [[ "$3" -eq 3 ]]
		then
			chemin="announce_only_user=yes"
			ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/users_conference/$1.conf`
		elif [[ "$3" -eq 4 ]]
		then
			chemin="dsp_drop_silence=yes"
			ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/users_conference/$1.conf`
		elif [[ "$3" -eq 5 ]]
		then
			chemin="announce_join_leave=yes"
			ligne=`grep -n "$chemin" /usr/local/var/lib/asterisk/users_conference/$1.conf`
		fi

		if [[ "$2" -eq 0 ]]
		then
			if [[ -z "$ligne" ]]
			then
				echo "$chemin" >> /usr/local/var/lib/asterisk/users_conference/$1.conf
				service asterisk reload
			else
				echo "Ce parametre est deja mis en ouevre pour cet utilisateur"
			fi	
		elif [[ "$2" -eq 1 ]]
		then
			if [[ ! -z "$ligne" ]]
			then
				num=`echo $ligne | cut -d':' -f1`
				sed -i".sav" "$num d" /usr/local/var/lib/asterisk/users_conference/$1.conf
				service asterisk reload
			else
				echo "Ce parametre n'est pas mis en oeuvre pour cet utilisateur"
			fi	
		fi
	else
		echo "Le fichier utilisateur n'existe pas OU le parametre 2 est incorrect OU le parametre 3 est incorrect."
	fi
else
	echo "Veuillez renseigner les trois parametres (utilisateur de la conference a modifier - mise en ouevre(0)/suppression(1) - parametre a modifier(musique de fond lorsque l'utilisateur est seul(0), commencer la conference en mode mute(1), annoncer le denombrement des utilisateurs(2), annoncer si on est seul(3), eviter le bruit de fond(4), annoncer les entrees et les sorties(5))"
fi
