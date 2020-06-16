#!/bin/bash

export ORACLE_SID=XE
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

crea_usuario(){
	sqlplus SIMON/P834acb9 <<EOF
	create user SIMON_'$1' identified by USUARIO;
	grant conect, resource, create to '$1';
EOF
}

if [ $# -eq 1 ]
then
		
