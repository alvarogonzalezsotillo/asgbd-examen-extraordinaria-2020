#!/bin/bash
clear

USUARIO=$1
OBJETO=$2

existe_objeto_usuario(){
 sqlplus MBA/Pfbd6844 <<HEREDOC
	select object_name, object_type from dba_objects where owner='$USUARIO' and object_name like '%$OBJETO%';
HEREDOC
}

existe_objeto_usuario
TRA=`existe_objeto_usuario $1 $2| tail -4| head -1`

if [[ "$TRA" == "TABLE" ]]
then
  echo El objeto $1.$2 existe y es una: Tabla
elif [[ "$TRA" == "FUNCTION" ]]
then
  echo El objeto $1.$2 existe y es una: Función
elif [[ "$TRA" == "PROCEDURE" ]]
then
  echo El objeto $1.$2 existe y es un: Procedimiento
elif [[ "$TRA" == "VIEW" ]]
then
  echo El objeto $1.$2 existe y es una: Vista
elif [[ "$TRA" == "TRIGGER" ]]
then
  Echo El objeto $1.$2 existe y es un: Trigger
else
 echo El objeto $1.$2 no existe.
fi

