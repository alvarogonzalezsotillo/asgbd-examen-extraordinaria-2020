#!/bin/bash
USUARIO=$1

listado_de_usuarios(){
  sqlplus -S / as sysdba <<EOF
 
  set colsep ','
  set pagesize 0
  set trimspool on
  set headsep off 
  set linesize 1000
  spool listado.csv
  select username, default_tablespace, profile from dba_users;
  spool off
EOF
}

busca_en_oracle(){
  sqlplus / as sysdba <<EOF 
  spool ficherotemporal.txt
  select username from dba_users;
  spool off
EOF
  grep -i $USUARIO ficherotemporal.txt
  rm ficherotemporal.txt
}

listado_de_usuarios > /dev/null


exit 0

if busca_en_oracle
then
  echo el usuario $USUARIO existe
else
  echo el usuario $USUARIO no existe
fi
