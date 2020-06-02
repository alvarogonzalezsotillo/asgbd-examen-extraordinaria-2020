#!/bin/bash
TABLA=$1

existe_tabla(){
 	sqlplus CONDORI/Pe6260f3 <<EOF | grep -i DATOS
 	select table_name from dba_tables;
EOF
}

if existe_tabla
then
	echo la tabla ya existe
else
	echo la tabla no exite
	sqlplus CONDORI/Pe6260f3 <<HEREDOC
	create table DATOS(dato varchar(255) );
HEREDOC
fi

while echo "Introducir un dato para la tabla" 
read DATO_INSERTADO
do
	sqlplus CONDORI/Pe6260f3 <<INS
	insert into DATOS(dato) values (' $DATO_INSERTADO ');
INS
done
