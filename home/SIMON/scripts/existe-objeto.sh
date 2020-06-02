#!/bin/bash

USUARIO=$1
OBJETO=$2

if [[ $# -ne 2  ]]
then
    echo Hacen falta dos argumentos
    exit 1
fi

#Script modificado 18/05/2020 12:09



existe_objeto(){
	sqlplus SIMON/P4774606 <<EOF | grep -i $OBJETO
	select object_name from dba_objects where owner = '$USUARIO' AND object_name='$OBJETO';
EOF
}

tipo_objeto_en_ingles(){
	sqlplus -S SIMON/P4774606 <<HEREDOC | tail -n 2 
	select object_type from dba_objects where object_name = '$OBJETO' and owner = '$USUARIO';
HEREDOC
}

traducir_a_castellano(){
    local PALABRA="$1"

    if [[ "$PALABRA" == "PROCEDURE" ]]
    then
        echo Procedimiento
    elif [[ "$PALABRA" == "TABLE" ]]
    then
        echo Tabla
    else
        echo No sé traducir $PALABRA
    fi
    
}

if existe_objeto
then
	echo El objeto $1.$2 existe y es una: 
	tipo_objeto_en_ingles
        traducir_a_castellano $(tipo_objeto_en_ingles)
else	
	echo El objeto $1.$2 no existe
fi
