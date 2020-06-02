
#!/bin/bash

instancia_arrancada(){
        sqlplus SIMON/P4774606 <<EOF
        select status from ' v$instance ' where status = 'OPEN';
EOF
}


if instancia_arrancada
then
        whiptail --yesno "La instancia está arrancada. ¿Desea apagarla?" 30 50
        elif [ $? == 0 ]
        then
                lsnrctl stop
                sqlplus SIMON/P4774606 <<EOF
                SUTDOWN IMMEDIATE;
EOF
        else
                echo Seguimos con la instancia iniciada.
        fi
else
        whiptail --yesno "¿Desea encender la instancia?" 30 50
        elif [ $? == 0 ]
        then
                lsnrctl start
                sqlplus SIMON/P4774606 <<HEREDOC
                startup open;
HEREDOC
        else
                echo Nos quedamos igual que estabamos.
        fi
fi


