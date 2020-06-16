#export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
#export PAT=$PATH:$ORACLE_HOME/bin
#export ORACLE_SID=XE

ARGS=$#

if [[ -z "$ARGS" ]]; then
	echo No hay variables.
	echo "Debes crear un usuario nuevo de Oracle con los permisos necesarios.
	 Si ya existe lo bloquearemos y cambiamos la contraseña."
	echo

elif [[ $# -eq 1 ]]; then
	sqlplus -S MBA/P32628c8 << HEREDOC
	set server output on
	declare
		exis integer;
		cdo varchar(25);
	being
		select count(*) into exis from dba_users where upper(username)='${1^^}';
		if (exis = 0) then
			dbms_output.put_line{'Creando Usuario: $1 con contraseña: $1');
			execute inmediate 'create user MBA_$1 identified by $1';
			execute inmediate 'grant connect, resource to $1';
			select username into cdo from dba_users where upper(username)='${1^^}';
			dbms_output.put_line{'Usuario creado: '|| creado);
		else
			dbms_output.put_line{'Ya existe el usuario: $1'};
		end if;
	end;
	/
	HEREDOC

	error_level=$?

	if [[ $error_level !=0 ]]; then
		echo Error en $0
		echo Código de error $error_level
		exit 0;
	fi
fi
