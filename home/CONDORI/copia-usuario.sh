#!/bin/bash
sqlplus CONDORI/P058ad62 <<EOF
create directory backups_CONDORI as '/backups/CONDORI';
EOF

expdp CONDORI/P058ad62 DIRECTORY=backups_CONDORI LOGFILE=CONDORI.log

USUARIO=$1
DATE=$(date)

busca_en_oracle(){
	sqlplus / as sysdba <<INS | grep -i $USUARIO
	select username from dba_users;
INS
}

if busca_en_oracle
then 
	echo el usuario $USUARIO existe
else
	echo el usuario $USUARIO no existe
	sqlplus CONDORI/P058ad62 <<JAV

	CREATE CONDORI_$DATE IDENTIFIED BY CONDORI;

	GRANT CREATE SESSION TO CONDORI_$DATE;
JAV

fi
