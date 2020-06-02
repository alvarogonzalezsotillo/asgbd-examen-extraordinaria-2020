#!/bin/bash
USUARIO=$1
OBJETO=$2

existe_objeto(){
	sqlplus CONDORI/Pe6260f3 <<EOF | grep -i $OBJETO
	select object_name from dba_objects where owner = '$USUARIO' and object_name = '$OBJETO';
EOF
}

tipos_objetos_en_ingles(){
	sqlplus -S CONDORI/Pe6260f3 <<GEB | tail -n 2
	select object_type from dba_objects where object_name = '$OBJETO' and owner = '$USUARIO';
GEB
}

traducir_a_castellano(){
	local PALABRA="$1"
	
	if [[ "$PALABRA" == "VIEW" ]]
	then
		echo Vista
	
	elif [[ "$PALABRA" == "TABLE" ]]
	then
		echo Tabla
        
	elif [[ "$PALABRA" == "PROCEDURE" ]]
        then
                echo Procedimiento

        elif [[ "$PALABRA" == "TRIGGER" ]]
        then
                echo Trigger

        elif [[ "$PALABRA" == "FUNCTION" ]]
        then
                echo Funcion

	else
		echo No se puede traducir $PALABRA
	fi
}

if existe_objeto
then
	echo El objeto $1.$2 existe y es una :
	traducir_a_castellano $(tipos_objetos_en_ingles)
else
	echo El objeto $1.$2 no existe
fi
