#!/bin/bash
tabla=$1

existe_tabla_datos(){
  sqlplus CASTELLANO/P4c96b37 <<EOF | grep -i DATOS
  select table_name from dba_tables;
EOF
}

if existe_tabla_datos
then
    echo la Tabla ya existe
else
	echo la tabla no existe
	sqlplus CASTELLANO/P4c96b37 <<HEREDOC
	create table DATOS(dato varchar(255) );
HEREDOC
fi

while read -p "Elegir dato que quiere introducir en la tabla" DATAINFO
do
    sqlplus CASTELLANO/P4c96b37 <<FDF
	insert into DATOS(dato) values (' $DATAINFO ');
FDF
done


########Este Script esta  modificado con fecha 27/05/2020 11:20#######

