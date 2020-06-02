#!/bin/bash


instancia_arrancada(){
	sqlplus SIMON/P4774606 <<EOF 
	select status from ' v$instance ' where status = 'OPEN';
EOF
}


 _   _                                            
| | | | __ _  ___ ___ _ __ ___     ___ ___  _ __  
| |_| |/ _` |/ __/ _ \ '__/ _ \   / __/ _ \| '_ \ 
|  _  | (_| | (_|  __/ | | (_) | | (_| (_) | | | |
|_| |_|\__,_|\___\___|_|  \___/   \___\___/|_| |_|
                                                  
          _     _       _        _ _ 
__      _| |__ (_)_ __ | |_ __ _(_) |
\ \ /\ / / '_ \| | '_ \| __/ _` | | |
 \ V  V /| | | | | |_) | || (_| | | |
  \_/\_/ |_| |_|_| .__/ \__\__,_|_|_|
                 |_|                 


if instancia_arrancada
then
	read -p 'Desea apagar la instancia SI o NO' SINO
	if [ $SINO == 'SI' ]
	then
		lsnrctl stop
		sqlplus SIMON/P4774606 << EOF 
		SHUTDOWN IMMEDIATE 
EOF
	else
		echo Seguimos con la instancia iniciada
	fi
else
	read -p 'Desea encender la instancia SI o NO' NOSI
	if [ $NOSI == 'SI']
	then
		lsnrctl start 
		sqlplus SIMON/P4774606 << HEREDOC
		startup open
HEREDOC
	else
		echo Nos quedamos igual que estábamos
	fi
fi
