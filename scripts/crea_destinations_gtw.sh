#! /usr/local/bin/bash

# Script de creation des destinations permettant l'acces aux gateways qui prend en parametres

#$1=login de la gateway
#$2=switch
#$3=contexte

if [[ ! -z "$1" && ! -z "$2" && ! -z "$3" ]] 
then
	if [[ -f /usr/local/var/lib/asterisk/users/$1_incoming.conf && -f /usr/local/var/lib/asterisk/users/$1_outgoing.conf ]]
	then
		if [[ -f /usr/local/var/lib/asterisk/context/$3.conf && -f /usr/local/var/lib/asterisk/context/$3.conf ]]
		then
			# verifier unicit� �du switch si tps !!!!
			touch /usr/local/var/lib/asterisk/context/$1_incoming.conf
			echo "[$1_incoming]" >> /usr/local/var/lib/asterisk/context/$1_incoming.conf
			echo "exten => s,1,Dial(SIP/21,20)" >> /usr/local/var/lib/asterisk/context/$1_incoming.conf
			echo "exten => n,GotoIf($["${DIALSTATUS}" = "BUSY"]?unavailable)" >> /usr/local/var/lib/asterisk/context/$1_incoming.conf
			echo "exten => s,n,n(unavailable),VoiceMail(24@default,b)" >> /usr/local/var/lib/asterisk/context/$1_incoming.conf

			echo "exten => $2,1,Dial(SIP/$1_outgoing,20)" >> /usr/local/var/lib/asterisk/context/$3.conf
		else
			echo "Ce contexte n'existe pas."
		fi
	else
		echo "Cette gateway n'existe pas."
	fi
else
	echo "Veuillez saisir les trois parametres (login de gateway - switch - contexte)"
fi