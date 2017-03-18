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
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./sql/schema.sql

	printf "Importing data\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./sql/import.sql
fi

read -p "Where do you want to save your log file?(default=/usr/sap/HXE/HDB90/work/log.log)" log_path
log_path=${log_path:-/usr/sap/HXE/HDB90/work/log.log}

read -p "Where do you want to save your clean log file?(default=/usr/sap/HXE/HDB90/work/cleanLog.log)" cleanLog_path
cleanLog_path=${cleanLog_path:-/usr/sap/HXE/HDB90/work/cleanLog.log}

source ./all_benchmarks.sh
run_all_benchmarks "/usr/sap/HXE/HDB90/work" 10

#for COUNTER in `seq 1 1`
#do
#	printf "Running benchmark number $COUNTER\n"
#	echo "Benchmark number $COUNTER" >> "$cleanLog_path"
#	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I benchAll.sql -T "$log_path" -O /dev/null
#	printf "Cleaning up the log\n"
#	awk '/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/' "$log_path" >> "$cleanLog_path"
#done
#
#
#echo "Switching to row" >> "$cleanLog_path"
#printf "Switching to row\n"
#hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./switchToRow.sql
#
#
#for COUNTER in `seq 1 1`
#do
#	printf "Running benchmark number $COUNTER\n"
#	echo "Benchmark number $COUNTER" >> "$cleanLog_path"
#	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I benchAll.sql -T "$log_path" -O /dev/null
#	printf "Cleaning up the log\n"
#	awk '/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/' "$log_path" >> "$cleanLog_path"
#done
#
#echo "Switching back to column" >> "$cleanLog_path"
#printf "Switching back to column\n"
#hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./switchToCol.sql
