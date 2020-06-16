#!/bin/bash


if [ $# -eq 1 ]
then
	PARAMETRO=$1
else
	echo no tienes un parametro introducido
fi
sqlplus CONDORI/P058ad62 <<EOF 
create user CONDORI_$1 identified by CONDORI;
EOF
