#! /usr/local/bin/bash

i=0
tab=()
tab1=()
tab2=()
tab3=()
while read ligne
do
	tab[$i]="$ligne"
	i=$(($i+1))
done < /usr/local/var/lib/asterisk/context/esiea.conf

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
