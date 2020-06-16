#!/bin/bash

export ORACLE_SID=XE
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe

Grant create any directory to backups_CASTELLANO;
Create directory backup as '/backups/CASTELLANO';
