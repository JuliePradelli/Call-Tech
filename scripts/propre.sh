#! /usr/local/bin/bash

# Script de remise a zero de tous les fichiers de configuration

# Pas d'argument requis

# Suppression des contextes
rm /usr/local/var/lib/asterisk/context/*.conf
rm /usr/local/var/lib/asterisk/context/*.sav
rm /usr/local/var/lib/asterisk/context/*.conf-e

# Suppression des users
rm /usr/local/var/lib/asterisk/users/*.conf
rm /usr/local/var/lib/asterisk/users/*.sav
rm /usr/local/var/lib/asterisk/users/*.conf-e

# Pas de suppression dans les autres repertoires car les fichiers ne sont pas en sys et il n'y a pas moyen de savoir si on peut les supprimer ou pas

# Copier coller du depot git dans les fichiers de conf
cp /home/freebsd/Call-Tech/fichiers_conf/context/* /usr/local/var/lib/asterisk/context/
cp /home/freebsd/Call-Tech/fichiers_conf/queues/* /usr/local/var/lib/asterisk/queues/
cp /home/freebsd/Call-Tech/fichiers_conf/room_conference/* /usr/local/var/lib/asterisk/room_conference/
cp /home/freebsd/Call-Tech/fichiers_conf/users/* /usr/local/var/lib/asterisk/users/
cp /home/freebsd/Call-Tech/fichiers_conf/users_conference/* /usr/local/var/lib/asterisk/users_conference/
cp /home/freebsd/Call-Tech/fichiers_conf/autres/* /usr/local/etc/asterisk/
