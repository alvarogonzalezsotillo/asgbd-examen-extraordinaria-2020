#!/bin/bash

instancia_arrancada(){
  ps -elf | grep -v grep | grep -i PMON
}


if instancia_arrancada
then
    whiptail --yesno "La instancia está arrancada. ¿Desea apagarla?" 15 50
    if [ $? == 0 ]
    then
        lsnrctl stop
        sqlplus SIMON/P4774606 <<< "SHUTDOWN IMMEDIATE;"
    else
        echo Seguimos con la instancia iniciada.
    fi
else
    whiptail --yesno "¿Desea encender la instancia?" 15 50
    if [ $? == 0 ]
    then
        lsnrctl start
        sqlplus SIMON/P4774606 <<< "STARTUP open;"
    else
        echo Nos quedamos igual que estabamos.
    fi
fi

