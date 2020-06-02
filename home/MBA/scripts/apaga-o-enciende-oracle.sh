#!/bin/bash
clear

estado_de_la_instancia(){
	sqlplus / as sysdba <<HEREDOC
	lsnrctl status;
HEREDOC
}

estado_de_la_instancia

ESTADO=`estado_de_la_instancia | head -4 | tail -1 | awk '{print s3}'`

if [[ "$ESTADO" == "running" ]]
then
  read -p '¿Desea parar la instancia SI o NO?' SINO
  if [[ $SINO == 'SI' ]]
  then
   lsnrctl stop
    sqlplus / as sysdba <<EOF
	SHUTDOWN INMEDIATE
EOF
  else
     echo "La instancia se mantiene arrancada"
  fi

elif [[ "$ESTADO" == "stopped" ]]
then
  read -p '¿Desea arrancar la instancia SI o NO?' SINO
  if [[ $SINO == 'SI' ]]
  then
   lsnrctl start
    sqlplus / as sysdba <<EOF
	startup open
EOF
  else
   echo "La instancia se mantiene parada"
  fi
fi

