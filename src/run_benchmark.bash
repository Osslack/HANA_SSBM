#!/bin/bash
source ./hdbsql.bash
source ./all_benchmarks.bash

hdb_ask $1
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
