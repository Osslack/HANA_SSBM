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

read -p "Do you want to import the SSBM data?(default=yes, no)" import
import=${import:-yes}
printf "\n"


if [[ $import =~ ^[Yy]([eE][sS])?$ ]]; then
	printf "Creating Schema\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./schema.sql

	printf "Importing data\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./import.sql
fi

for COUNTER in 1 2 3 4 5 6 7 8 9 10
do
	printf "Running benchmark number $COUNTER\n"
	echo "Benchmark number $COUNTER\n" >> log.log
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I benchAll.sql -O log.log
done

printf "Cleaning up the log\n"
awk '/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/' log.log

#TODO run benchmark

