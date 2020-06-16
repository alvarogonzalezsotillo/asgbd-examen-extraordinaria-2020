#!/bin/bash

export ORACLE_SID=XE
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

crea_usuario(){
	sqlplus SIMON/P834acb9 <<EOF
	create user SIMON_'$1' identified by USUARIO;
	grant connect, resource, create to '$1';
EOF
}

existe_usuario(){
	sqlplus SIMON/P834acb9 <<EOF
	select username from dba_users where username = 'SIMON_$1';
FDF
}

if [ $# -eq 1 ]
then
	if existe_usuario
	then
		
else 
	echo necesito un parametro
fi
