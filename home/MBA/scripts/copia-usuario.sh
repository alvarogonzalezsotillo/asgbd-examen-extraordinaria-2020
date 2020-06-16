#export ORACLE_HOME=/u01/app/oracle/product/11.2.0
#export PATH=$PATH:$ORACLE_HOME/bin
#export ORACLE_SID=XE

existe_usuario(){
HHMM=`
sqlplus -S MBA/P32628c8 << HEREDOC                                   
	 set server output on
        declare  
                exis integer;
                cdo varchar(25);
        being                   
                select count(*) into exis from dba_users where upper(username)='${$│
                if (exis = 0) then 
                        dbms_output.put_line{'Creando Usuario: $1 con contraseña: $│
                        execute inmediate 'create user MBA_$1 identified by $1';   │
                        execute inmediate 'grant connect, resource to $1';         │
                        select username into cdo from dba_users where upper(userna$│
                        dbms_output.put_line{'Usuario creado: '|| creado);         │
                else                                                               │
                        dbms_output.put_line{'Ya existe el usuario: $1'};          │
                end if;                                                            │
        end;                                                                       │
        /                                                                          │
        HEREDOC                                                    
}

existe_usuario
