!/bin/bash


export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=XE

variable1=$1

if [[ -z "$variable1" ]]; then
	
echo "-------"
echo "se a de colocar 1 solo parametro obligatoriamente"
echo "-------"

fi


