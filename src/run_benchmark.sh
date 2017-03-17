#!/bin/bash

read -p "Please enter your username(default=SYSTEM): " username
username=${name:-SYSTEM}
read -p "Please enter your password: " -s password
printf "\n"

printf "Check database connection\n"
hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -o /dev/null "SELECT * from DUMMY"
if [[ $? != 0 ]]; then
	exit 1
fi

read -p "Do you want to import the SSBM data?(default=no, yes)" import
import=${import:-no}
printf "\n"

if [[ $import =~ ^[Yy]([eE][sS])?$ ]]; then
	printf "Creating Schema\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./schema.sql

	printf "Importing data\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./import.sql
fi

read -p "Where do you want to save your log file?(default=/usr/sap/HXE/HDB90/work/log.log)" log_path
log_path=${log_path:-/usr/sap/HXE/HDB90/work/log.log}

cleanLog=/usr/sap/HXE/HDB90/work/cleanLog.log

for COUNTER in `seq 1 1`
do
	printf "Running benchmark number $COUNTER\n"
	echo "Benchmark number $COUNTER" >> "$cleanLog"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I benchAll.sql -T "$log_path" -O /dev/null
	printf "Cleaning up the log\n"
	awk '/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/' "$log_path" >> "$cleanLog"
done
