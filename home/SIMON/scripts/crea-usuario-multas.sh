#!/bin/bash

export ORACLE_SID=XE
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe


existe_rol(){
	sqlplus SIMON/P834acb9 <<FDA 
	select role from dba_roles where role = 'SIMON_rol';
FDA
}


crea_rol(){
	sqlplus SIMON/P834acb9 <<HEREDOC
	create role SIMON_rol;
	grant select on USUARIO.Multas to SIMON_rol;
	grant alter table on USUARIO.Multas.Importe to SIMON_rol;
HEREDOC
}

crea_usuario(){
	sqlplus SIMON/P834acb9 <<EOF
	create user SIMON_'$1' identified by USUARIO;
	grant connect, resource, create to $1;
EOF
}

existe_usuario(){
	sqlplus SIMON/P834acb9 <<FDF | grep -i $1
	select username from dba_users where username = 'SIMON_$1';
FDF
}

if [ $# -eq 1 ]
then
	if existe_usuario
	then
		echo ya existe el usuario
	else 
		crea_usuario
	if existe_rol
	then 
			echo el rol existe procedemos a asignarselo
			sqlplus SIMON/P834acb9 <<EOE 
			grant SIMON_rol to SIMON_'$1';
EOE
	else 
			crea_rol
	fi
else 
	echo necesito un parametro
fi
