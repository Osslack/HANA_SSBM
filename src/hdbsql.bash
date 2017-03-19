#!/bin/bash

hdb_tmp_path=""
hdb_tmp_path_root="/tmp/benchmark.log"

###### Init functions ######
function hdb_init_username {
	hdb_username=${hdb_username:-SYSTEM}
}

function hdb_init_instance {
	hdb_instance=${hdb_instance:-90}
}

function hdb_init_database {
	hdb_database=${hdb_database:-SystemDB}
}

function hdb_init_log_path {
	hdb_log_path=${hdb_log_path:-/usr/sap/HXE/HDB90/work/log.log}
}

function hdb_init_output_path {
	hdb_output_path=${hdb_output_path:-/dev/null}
}

hdb_init_instance
hdb_init_database
hdb_init_username
hdb_init_log_path
hdb_init_output_path

####### setters ############
function hdb_set_instance {
	hdb_instance="$1"
}

function hdb_set_database {
	hdb_database="$1"
}

function hdb_set_username {
	hdb_username="$1"
}

function hdb_set_password {
	hdb_password="$1"
}

function hdb_set_log_path {
	hdb_log_path="$1"
}

function hdb_set_output_path {
	hdb_output_path="$1"
}

########## asker ##########
function hdb_ask_password {
	read -p "Please enter your password: " -s hdb_password
	printf "\n"
}

function hdb_ask_username {
	read -p "Please enter your username: (default=SYSTEM): " hdb_username
	printf "\n"
	hdb_init_username
}

function hdb_ask_import {
	read -p "Do you want to import the SSBM data? (default=no, yes): " import
	import=${import:-no}
	printf "\n"

	if [[ $import =~ ^[Yy]([eE][sS])?$ ]]; then
		printf "Creating Schema\n"
		hdb_run_file ./sql/schema.sql

		printf "Importing data\n"
		hdb_run_file ./sql/import.sql
	fi
}

function hdb_ask_log_path {
	read -p "Where do you want to save your log file? (default=/usr/sap/HXE/HDB90/work/log.log): " hdb_log_path
	hdb_init_log_path
}

function hdb_ask {
	if [[ $1 = "-v" ]]; then
		hdb_ask_username
		hdb_ask_password
		hdb_check_connection
		hdb_ask_import
		hdb_ask_log_path
	else
		hdb_ask_password
		hdb_check_connection
	fi
}

######## utils ############
function hdb_check_connection {
	printf "Check database connection.\n"
	hdb_run "SELECT * FROM DUMMY"
}


function hdb_log {
	echo "$1" >> "$hdb_log_path"
}


function hdb_log_string {
	hdb_log "'$1'"
}

function hdb_log_number {
	hdb_log "$1"
}

function hdb_log_start_array {
	hdb_log "["
}

function hdb_log_end_array {
	hdb_log "]"
}

function hdb_log_start_map {
	hdb_log "{"
}

function hdb_log_end_map {
	hdb_log "}"
}

function hdb_log_start_attribute {
	hdb_log "'$1':"
}

function hdb_log_end_attribute {
	hdb_log ","
}

function hdb_log_set_attribute {
	hdb_log_start_attribute "$1"
	hdb_log_string "$2"
	hdb_log_end_attribute
}

function hdb_init_log {
	rm "$hdb_log_path"
	hdb_tmp_path=$(mktemp "$hdb_tmp_path_root.XXX")
	hdb_log_start_map
}

function hdb_finish_log {
	rm "$hdb_tmp_path"
	hdb_log_end_map
}

function hdb_start_benchmark {
	hdb_log_start_attribute "$1"
	hdb_log_start_array
}

function hdb_end_benchmark {
	hdb_log_end_array
	hdb_log_end_attribute
}

function hdb_flush_tmp {
	hdb_log_start_attribute "$1"
	hdb_log "'"
	filter='/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/'
	awk "$filter" "$hdb_tmp_path" >> "$hdb_log_path"
	hdb_log "'"
	hdb_log_end_attribute
}

function hdb_run_file {
	hdb_log_start_map 
	hdb_log_set_attribute "Type" "exec_file"
	hdb_log_set_attribute "Filename" "$1"

	hdbsql \
		-i "$hdb_instance" \
		-d "$hdb_database" \
		-u "$hdb_username" \
		-p "$hdb_password" \
		-T "$hdb_tmp_path" \
		-O "$hdb_output_path" \
		-I "$1"

	if [[ $? != 0 ]]; then
		printf "Could not execute:\n$1\n"
		hdb_log_set_attribute "Error" "$?"
	fi
	if [[ $2 ]]; then
		hdb_flush_tmp "Result"
	fi
	hdb_log_end_map
}

function hdb_run {
	hdb_log_start_map
	hdb_log_set_attribute "Type" "inline_command"
	hdb_log_set_attribute "Query" "$1"

	hdbsql \
		-i "$hdb_instance" \
		-d "$hdb_database" \
		-u "$hdb_username" \
		-p "$hdb_password" \
		-T "$hdb_tmp_path" \
		-O "$hdb_output_path" \
		"$1"

	if [[ $? != 0 ]]; then
		printf "Could not execute:\n$1\n"
		hdb_log_set_attribute "Error" "$?"
	fi
	if [[ $2 ]]; then
		hdb_flush_tmp "Result"
	fi
	hdb_log_end_map
}
