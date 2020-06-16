#!/bin/bash
USUARIO=$2


if [ $# -eq 1 ]
then
	PARAMETRO=$1
else
	echo no tienes un parametro introducido
fi
sqlplus CONDORI/P058ad62 <<EOF | grep -i USUARIO
create user $USUARIO identified by $USUAARIO;
EOF
