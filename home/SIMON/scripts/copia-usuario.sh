#!/bin/bash

crea_dir(){
	sqlplus SIMON/P843acb9 <<EOF
	create directory backups_SIMON as '/backups/SIMON';
EOF
}

copia_tablas(){
expdp SIMON/P843acb9 directory=/backups/SIMON schema=SIMON dumpfile=copia.dmp logfile=copia.log
}


nuevo_usu(){
	DATE=$(date +%H%M)
	sqlplus SIMON/P843acb9 <<FDF
	create user SIMON_$DATE identified by USUARIO;
FDF
}
 
existe_usuario(){
	sqlplus SIMON/P843acb9 <<HEREDOC | grep -i $1
	select username from dba_users where username = '$1';

HEREDOC
}

if existe_usuario
then 
	echo el usuario ya existe
else
	nuevo_usu
fi 
