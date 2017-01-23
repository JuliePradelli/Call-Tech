#! /usr/local/bin/bash

mysql -u root -p -e "SET @a = (SELECT MAX(\`contexte\`.\`id_contexte\`) FROM \`mydb\`.\`contexte\`); INSERT INTO \`mydb\`.\`contexte\` VALUES (@a+1,\"test555555\",0) ;"
