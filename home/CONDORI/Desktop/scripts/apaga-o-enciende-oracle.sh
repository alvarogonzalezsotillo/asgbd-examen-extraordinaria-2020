#!/bin/bash

comprobar_instancia(){
	sqlplus sqlplus / as sysdba <<EOF
	select status from 'v$instance' where status = 'OPEN'
EOF
}
if comprobar_instancia
then
	echo Quiere apagar la instancia SI o NO 
	read RESPUESTA
	if [ $RESPUESTA == 'SI' ]
	then
		lsnrctl stop
		sqlplus / as sysdba <<EOF
		shutdown immediate
EOF
	else
		echo Sigue con la instancia iniciada
	fi
else
	echo Desea arrancar la instacia SI o NO 
	read RESPUESTA_DOS
	if [ $RESPUESTA_DOS == 'SI' ]
	then
		lsnrctl start
		sqlplus / as sysdba <<GEB
		startup open
GEB
	else
		echo NO se inicio la instancia de oracle
	fi
fi
