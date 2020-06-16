!/bin/bash

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=XE

var=$1

if [[ -z "$var" ]]; then
	echo "====================================="
	echo "Numero de variables vacio."
	echo "Cree un usuario nuevo de oracle."
	echo "====================================="

elif [[ $# -eq 2 ]]; then
	sqlplus -S / as sysdba <<- EOF
	set serveroutput on
	
	declare
		existe integer;
		creado varchar(25);
	begin
		select count(*) into existe from dba_users where upper(username)='${1^^}';
		if (existe = 0) then
			dbms_output.put_line('Creando Usuario: $1 con Password: $1');
			execute immediate 'create user VILLARTA_$1 identified by $1';
			execute immediate 'grant connect, resource to $1';
			select username into creado from dba_users where username='${1^^}';
			dbms_output.put_line('Usuario creado: '|| creado);
		else
			dbms_output.put_line('Usuario ya existe: $1');
			execute immediate 'alter user $1 identified by $1 account unlock';
		end if;
	end;
	/
	EOF

else
	echo "======================================="
	echo "Numero de variables erróneo."
        echo "Cree un usuario nuevo de oracle con los permisos adecuados."
	echo "======================================="
fi


