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

printf "Checking for CSV data\n"

csv_exist=$(ls /usr/sap/HXE/HDB90/work/ | grep '\.csv$' | wc -l)
generate=false

if [ csv_exist = 5 ]; then

	generate=true
else
	printf "Found CSV data.\n"
	read -p "Do you want to regenerate the CSV data.(default=no, yes)" regenerate
	printf "\n"
	if [[ $regenerate =~ ^[Yy]$ ]]; then
		generate=true
	fi
fi

if $generate ; then
	printf "Generating CSV data ..."
	./to_csv.sh /usr/sap/HXE/HDB90/work
fi

read "Do you want to import the SSBM data?(default=yes, no)" import
import=${import:-yes}
printf "\n"

if [[ $import =~ ^[Yy]$ ]]; then
	printf "Creating Schema\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./schema.sql

	printf "Importing data\n"
	hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./import.sql
fi


printf "Running benchmark\n"
hdbsql -i 90 -d SystemDB -u "$username" -p "$password" -I ./benchAll.sql -O log.log
#TODO run benchmark
