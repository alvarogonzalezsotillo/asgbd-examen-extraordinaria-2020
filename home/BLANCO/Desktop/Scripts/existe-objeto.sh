#!/bin/bash

clear

USUARIO=$1
OBJETO=$2

funcion_existe_objeto_y_tipo(){
	sqlplus BLANCO/P2f99761 <<HEREDOC
	select object_name, object_type from dba_objects where owner='$USUARIO' and object_name like '%OBJETO%';
HEREDOC
}

funcion_existe_objeto_y_tipo

TRA=`funcion_existe_objeto_y_tipo $1 $2 | tail -4 | head -1`

if [[ "$TRA" == "TABLE" ]]
then
	echo El objeto $1.$2 existe y es una: Tabla

elif [[ "$TRA" == "FUNCTION" ]]
then
	echo El objeto $1.$2 existe y es una: Funcion

elif [[ "$TRA" == "PROCEDURE" ]]
then
	echo El objeto $1.$2 existe y es un: Procedimiento

elif [[ "$TRA" == "VIEW" ]]
then
	echo El objeto $1.$2 existe y es una: Vista

elif [[ "$TRA" == "TRIGGER" ]]
then
	echo El objeto $1.$2 existe y es un: Trigger

else
	echo El objeto $1.$2 no lo conozco

fi