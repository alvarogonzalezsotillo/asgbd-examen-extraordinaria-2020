mi_funcion(){
	sqlplus / as sysdba <<HEREDOC
	lsnrctl status;
HEREDOC
}

mi_funcion

ESTADO=`mi_funcion | head -4 | tail -1 | awk '{print s3}'`

if [[ "$ESTADO" == "running" ]]
then
	read -p '¿Desea apagar la instancia SI o NO?' SINO
	if [[ $SINO == 'SI' ]]
	then
	lsnrctl stop
	sqlplus / as sysdba <<HEREDOC
	SHUTDOWN INMEDIATE
HEREDOC

	else
	echo "La instancia se mantiene arrancada"
	fi
elif [[ "$ESTADO" == "stopped" ]]
then
	read -p '¿Desea encender la instancia SI o NO?' SINO
	if [[ $SINO == 'SI' ]]
	then
	lsnrctl start
	sqlplus / as sysdba <<HEREDOC
	startup open
HEREDOC
	else
	echo "la instancia se mantiene apagada"
	fi
fi
	