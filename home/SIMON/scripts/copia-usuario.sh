#!/bin/bash

crea_dir(){
	sqlplus SIMON/P843acb9 <<EOF
	create directory backups_SIMON as '';
EOF
}
