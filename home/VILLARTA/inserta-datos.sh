#!/bin/bash
#vamos a crear la tabla DATOS si no existe

existe_tabla_datos(){
	sqlplus VILLARTA/Pa6d6b76 <<HEREDOC
	select table_name from user_tables order by table_name;
HEREDOC
}

existe_tabla_datos
ERR=`existe_tabla_datos |tail -4| head -1| awk {print $1}'|cut -b 5,6,7,8,9`
if [[ "$ERR" ]]
then
echo La tabla DATOS ya existe.
sqlplus VILLARTA/Pa6d6b76 <<EOF
	select * from DATOS;
EOF
else
sqlplus VILLARTA/Pa6d6b76 <<EOF
	create table DATOS(
		dato varchar(255)
	);
EOF
fi
