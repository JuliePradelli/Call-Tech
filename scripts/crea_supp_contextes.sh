#! /usr/local/bin/bash

# script de creation des conntextes preant en parametres 

#$1=creation(0)/suppression(1)
#$2=nom
#$3=contexte pour utilisateur(0)/gateway(1)

if [[ ! -z "$1" && ! -z "$2" ]]
then
	touch /home/bastoo/test/a.txt
	if [[ ! -f "/usr/local/var/lib/asterisk/context/$2.conf" ]]
	then	
		echo "existence" >> /home/bastoo/test/a.txt
		existence=0
	else
		existence=1
	fi
	if [[ "$1" =~ ^[0-1]{1}$ && ! -z "$3" ]]
	then
		echo "a" >> /home/bastoo/test/a.txt
		# ******************** CREATION CONTEXTE ********************************
		if [[ "$1" -eq 0 && "$existence" -eq 0 ]] 
		then
			touch /usr/local/var/lib/asterisk/context/$2.conf
			echo "[$2]" >> /usr/local/var/lib/asterisk/context/$2.conf

			# inclusion de tous les contextes dans le standard mais pas le contraire
			echo "include => $2" >> /usr/local/var/lib/asterisk/context/DONOTDELETE_standard.sys

			echo "#include \"/usr/local/var/lib/asterisk/context/$2.conf\"" >> /usr/local/etc/asterisk/extensions.conf
			echo "exten => 100,s,VoiceMailMain()" >> /usr/local/var/lib/asterisk/context/$2.conf
			# ajout dans la bdd en fonction de l'utilisation (pour utilisateur ou gtw)
			#if [[ "$3" =~ ^[0-1]{1} ]]
			#then
		#		mysql -u root -p -e "SET @a = (SELECT MAX(\`contexte\`.\`id_contexte\`) FROM \`mydb\`.\`contexte\`); INSERT INTO \`mydb\`.\`contexte\` VALUES (@a+1,\"$2\",$3) ;"
			#else
		#		mysql -u root -p -e "SET @a = (SELECT MAX(\`contexte\`.\`id_contexte\`) FROM \`mydb\`.\`contexte\`); INSERT INTO \`mydb\`.\`contexte\` VALUES (@a+1,\"$2\",0) ;"
			#fi
			service asterisk reload
		# ******************** DESTRUCTION CONTEXTE ********************************
		elif [[ "$1" -eq 1 && "$existence" -eq 1 ]]
		then
			# verifier si le contexte est plein (si il s'agit d'un contexte utilisateurs) et si oui réecrire les lignes dans le default
			if [[ "$3" -eq 0 ]]
			then
				i=0
				tab=()
				tab1=()
				tab2=()
				tab3=()
				while read ligne
				do
					tab[$i]="$ligne"
					i=$(($i+1))
				done < /usr/local/var/lib/asterisk/context/$2.conf

				m=0
				n=0
				for ((j=1; j<i; j++))
				do
					if [[ ${tab[$j]} =~ ^[exten].+$ ]]
					then
						tab3[$n]=${tab[$j]}
						n=$(($n+1))
						num=`echo ${tab[$j]} | cut -d' ' -f3`
						exten=`echo $num | cut -d',' -f1`
						find /usr/local/var/lib/asterisk/users/*.conf > a.txt
						i=0
						while read ligne
						do
							tab1[$i]="$ligne"
							i=$(($i+1))
						done < /var/www/script/a.txt
						for ((l=0; l<i; l++))
						do
							while read ligne1
							do
								if [[ $ligne1 == "[$exten]" ]]
								then
									tab2[$m]=${tab1[$l]}
									m=$(($m+1))
								fi
							done < ${tab1[$l]}
						done
					fi
				done
	
				for ((j=0; j<m; j++))
				do
					sed -I -e -E 's/context=.+/context=default/g' ${tab2[$j]}
				done
				for ((j=0; j<n; j++))
				do
					echo ${tab3[$j]} >> /usr/local/var/lib/asterisk/context/DONOTDELETE_default.sys
				done
			fi

			# ******************** POURSUIVRE LA DESCTRUCTION DU CONTEXTE ********************
			
			rm /usr/local/var/lib/asterisk/context/$2.conf
			chemin1="#include \"/usr/local/var/lib/asterisk/context/$2.conf\""
			ligne1=`grep -n "$chemin1" /usr/local/etc/asterisk/extensions.conf`
			if [[ ! -z $ligne1 ]]
			then
				num1=`echo $ligne1 | cut -d':' -f1`
				sed -i".sav" "$num1 d" /usr/local/etc/asterisk/extensions.conf
				rm /usr/local/etc/asterisk/extensions.conf.sav
				service asterisk reload
			else
				echo "Nous n'avons pas pu supprimer ce contexte."
			fi
		else
			echo "Si vous voulez ajouter, le fichier existe deja; si vous voulez supprimer, le fichier n'existe pas."
		fi
	else
		echo "Le premier champ est mal renseigne."
	fi
else
	echo "Veuillez renseigner les trois parametres (creation(0)/suppression(1) - nom - contexte utilisateur(0)/gtw(1))."
fi
