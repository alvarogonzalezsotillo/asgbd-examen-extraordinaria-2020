#!/bin/bash


instancia_arrancada(){
	sqlplus CASTELLANO/P4c96b37 <<EOF 
	select status from ' v$instance ' where status = 'OPEN';
EOF
}


if instancia_arrancada
then
	read -p 'Apagar la instancia SI o NO' SINO
	if [ $SINO == 'SI' ]
	then
		lsnrctl stop
		sqlplus CASTELLANO/P4c96b37 << EOF 
		SHUTDOWN IMMEDIATE 
EOF
	else
		echo La instancia sigue iniciada
	fi
else
	read -p 'Encendemos la instancia SI o NO' NOSI
	if [ $NOSI == 'SI']
	then
		lsnrctl start 
		sqlplus CASTELLANO/P4c96b37 << HEREDOC
		startup open
HEREDOC
	else
		echo Nos quedamos igual que estábamos
	fi
fi
