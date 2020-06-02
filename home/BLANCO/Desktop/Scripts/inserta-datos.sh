#!/bin/bash

clear

funcion_existe_tabla(){
	sqlplus BLANCO/P2f99761 <<HEREDOC
	select table_name from user_tables order by table_name;
HEREDOC
}

funcion_existe_tabla

ERR=`funcion_existe_tabla | tail -4 | head -1 | awk '{print $1}' | cut -b 5,6,7,8,9`

if [[ "$ERR" ]]
then
	echo La tabla DATOS ya existe

	sqlplus BLANCO/P2f99761 <<HEREDOC
	select * from DATOS;
HEREDOC

else
sqlplus BLANCO/P2f99761 <<HEREDOC
	create table DATOS(
	  dato varchar(255)
	);
HEREDOC
fi