#!/bin/bash

export ORACLE_SID=XE
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

crear_un_usuario(){
	sqlplus CASTELLANO/P5a6a14a
	select * from dba_users
		
