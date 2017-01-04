#! /usr/local/bin/bash

# script d'affectation des droits d'appel d'un contexte a un autre (valable pour toute sorte d'autorisation d'appel, notamment vers une gateway, vers un autre groupe d'utilisateurs (contexte) ou vers la création dynamique de salles de conférence et) qui prend en parametres  

#$1=contexte 1
#$2=contexte 2
#$3=bidirectionnel(0) - unidirectionnel 1->2(1) - unidirectionnel 2->1(2) - annulation bidirectionnel(3) - annulation unidirectionnel 1->2(4) - annulation unidirectionnel 2->1(5)

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]] 
then
	if [[ -f "/usr/local/var/lib/asterisk/context/$1.conf" && -f "/usr/local/var/lib/asterisk/context/$2.conf" && "$1" != "$2" ]]
	then	
		if [[ "$3" =~ ^[0-5]{1}$ ]]
		then
			chemin1="include => $2"
			ligne1=`grep -n "$chemin1" /usr/local/var/lib/asterisk/context/$1.conf`
			chemin2="include => $1"
			ligne2=`grep -n "$chemin2" /usr/local/var/lib/asterisk/context/$2.conf`
			# ******************** BIDIRECTIONNEL 0 ********************************
			if [[ "$3" -eq 0 ]]
			then
				if [[ -z "$ligne1" && -z "$ligne2" ]]
				then
					echo "include => $1" >> /usr/local/var/lib/asterisk/context/$2.conf 
					echo "include => $2" >> /usr/local/var/lib/asterisk/context/$1.conf 
					service asterisk reload
				elif [[ -z "$ligne1" && ! -z "$ligne2" ]]
				then
					echo "Le droit d'appel de $2 vers $1 existe deja."
				elif [[ -z "$ligne2" && ! -z "$ligne1" ]]
				then
					echo "Le droit d'appel de $2 vers $1 existe deja."
				elif [[ ! -z "$ligne1" && ! -z "$ligne2" ]]
				then
					echo "Ce droit bidirectionnel existe deja."
				fi
			# ******************** UNIDIRECTIONNEL 1 ********************************
			elif [ "$3" -eq 1 ]
			then
				if [[ -z "$ligne1" ]]
				then
					echo "include => $2" >> /usr/local/var/lib/asterisk/context/$1.conf 
					service asterisk reload
				elif [[ ! -z "$ligne1" ]]
				then
					echo "Le droit d'appel de $2 vers $1 existe deja."
				fi
			# ******************** UNIDIRECTIONNEL 2 ********************************
			elif [ "$3" -eq 2 ]
			then
				if [[ -z "$ligne2" ]]
				then
					echo "include => $1" >> /usr/local/var/lib/asterisk/context/$2.conf 
					service asterisk reload
				elif [[ ! -z "$ligne2" ]]
				then
					echo "Le droit d'appel de $1 vers $2 existe deja."
				fi
			# ******************** ANNULATION BIDIRECTIONNEL ********************************
			elif [ "$3" -eq 3 ]
			then
				if [[ ! -z "$ligne1" && ! -z "$ligne2" ]]
				then
					num1=`echo $ligne1 | cut -d':' -f1`
					sed -i".sav" "$num1 d" /usr/local/var/lib/asterisk/context/$1.conf
					num2=`echo $ligne2 | cut -d':' -f1`
					sed -i".sav" "$num2 d" /usr/local/var/lib/asterisk/context/$2.conf
					service asterisk reload
				elif [[ -z "$ligne1" && ! -z "$ligne2" ]]
				then
					echo "Le droit d'appel de $1 vers $2 n'existe pas."
				elif [[ -z "$ligne2" && ! -z "$ligne1" ]]
				then
					echo "Le droit d'appel de $2 vers $1 n'existe pas."
				elif [[ ! -z "$ligne1" && ! -z "$ligne2" ]]
				then
					echo "Ce droit bidirectionnel existe deja."
				fi
			# ******************** ANNULATION UNIDIRECTIONNEL 1 ********************************
			elif [ "$3" -eq 4 ]
			then	
				if [[ ! -z "$ligne1" ]]
				then
					num1=`echo $ligne1 | cut -d':' -f1`
					sed -i".sav" "$num1 d" /usr/local/var/lib/asterisk/context/$1.conf
					service asterisk reload
				elif [[ -z "$ligne1" ]]
				then
					echo "Le droit d'appel de $2 vers $1 n'existe pas."
				fi
			# ******************** ANNULATION UNIDIRECTIONNEL 2 ********************************
			elif [ "$3" -eq 5 ]
			then
				if [[ ! -z "$ligne2" ]]
				then
					num2=`echo $ligne2 | cut -d':' -f1`
					sed -i".sav" "$num2 d" /usr/local/var/lib/asterisk/context/$2.conf
					service asterisk reload
				elif [[ -z "$ligne2" ]]
				then
					echo "Le droit d'appel de $1 vers $2 n'existe pas."
				fi
			fi
		else
			echo "Veuillez renseigner correctement le troisieme champ, pour plus d'informations, ./affectation_droits.sh ."
		fi
	else
		echo "Un ou plusieurs contextes n'ont pas ete trouve ou vous avez tape deux fois le meme contexte, veuillez recommencer."
	fi
else
	echo "Veuillez renseigner les trois parametres (contexte 1 - contexte 2 - bidirectionnel(0)/unidirectionnel contexte 1 peut appeler contexte 2(1)/unidirectionnel le contraire(2)/annulation bidirectionnel(3)/annulation unidirectionnel 1(4)/annulation unidirectionnell 2(5))"
fi
