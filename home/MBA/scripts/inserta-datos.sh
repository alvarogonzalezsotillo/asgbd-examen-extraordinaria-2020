#!/bin/bash
#Creamos la tabla DATOS si no existe
clear

existe_tabla_datos(){
	sqlplus MBA/Pfbd6844 <<HEREDOC
	select table_name from user_tables order by table_name;
HEREDOC
}

existe_tabla_datos
ERR=`existe_tabla_datos |tail -4| head -1| awk '{print $1}'|cut -b 5,6,7,8,9` 
if [[ "$ERR" ]] 
then
echo La tabla DATOS ya existe.
sqlplus MBA/Pfbd6844 <<EOF
	select * from DATOS;
EOF
else
sqlplus MBA/Pfbd6844 <<EOF
	create table DATOS(
		dato varchar(255)
	);
EOF
fi


#Ahora recorremos la tabla Datos 
