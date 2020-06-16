#!/bin/bash
sqlplus CONDORI/P058ad62 <<EOF
create directory backups_CONDORI as '/backups/CONDORI';
EOF

expdp CONDORI/P058ad62 DIRECTORY=backups_CONDORI LOGFILE=CONDORI.log

sqlplus CONDORI/P058ad62 <<INS

CREATE CON
