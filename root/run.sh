#!/bin/sh
sed -i -e "s#your_username#$PGSQL_USER#" \
       -e "s#your_password#$PGSQL_PASS#" \
       -e "s#your_hostname#$PGSQL_HOST#" \
       /backup.sh

while true; 
    do 
        /backup.sh
        sleep 172800; 
    done 
