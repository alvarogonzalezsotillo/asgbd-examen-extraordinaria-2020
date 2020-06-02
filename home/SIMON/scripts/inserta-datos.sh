#!/bin/bash
tabla=$1

existe_tabla_datos(){
  sqlplus SIMON/P4774606 <<EOF | grep -i DATOS
  select table_name from dba_tables;
EOF
}

if existe_tabla_datos
then
    echo la tabla ya existe
else
	echo la tabla no existe
	sqlplus SIMON/P4774606 <<HEREDOC
	create table DATOS(dato varchar(255) );
HEREDOC
fi

while read -p "Que dato quiere introducir en la tabla?" DATAINFO
do
    sqlplus SIMON/P4774606 <<FDF
	insert into DATOS(dato) values (' $DATAINFO ');
FDF
done


########Script modificado con fecha 18/05/2020 12:53#######

