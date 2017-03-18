#!/bin/bash

hdb_instance=${hdb_instance:-90}
hdb_database=${hdb_database:-SystemDB}
hdb_username=${hdb_username:-username}
hdb_log_path=${hdb_log_path:-/usr/sap/HXE/HDB90/work/log.log}
hdb_output_path=${hdb_output_path:-/dev/null}
hdb_tmp_path="/tmp/benchmark.log"


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

function hdb_run_file {
	echo "Running $1" >> "$hdb_log_path"

	hdbsql \
		-i "$hdb_instance" \
		-d "$hdb_database" \
		-u "$hdb_username" \
		-p "$hdb_password" \
		-T "$hdb_tmp_path" \
		-O "$hdb_output_path" -I "$1"

	filter='/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/'
	awk "$filter" "$hdb_tmp_path" >> "$hdb_log_path"
}
