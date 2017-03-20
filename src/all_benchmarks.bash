#!/bin/bash

source hdbsql.bash

function test {
	hdb_run_file $1 log
	hdb_log ','
	printf "."
}

function benchmark {
	test "./sql/benchmark/q1_bench/q1.sql"
	test "./sql/benchmark/q1_bench/q1.1.sql"
	test "./sql/benchmark/q1_bench/q1.2.sql"
	test "./sql/benchmark/q1_bench/q1.3.sql"
	test "./sql/benchmark/q2_bench/q2.sql"
	test "./sql/benchmark/q2_bench/q2.1.sql"
	test "./sql/benchmark/q2_bench/q2.2.sql"
	test "./sql/benchmark/q2_bench/q2.3.sql"
	test "./sql/benchmark/q3_bench/q3.sql"
	test "./sql/benchmark/q3_bench/q3.1.sql"
	test "./sql/benchmark/q3_bench/q3.2.sql"
	test "./sql/benchmark/q3_bench/q3.3.sql"
	test "./sql/benchmark/q3_bench/q3.4.sql"
	test "./sql/benchmark/q4_bench/q4.sql"
	test "./sql/benchmark/q4_bench/q4.1.sql"
	test "./sql/benchmark/q4_bench/q4.2.sql"
	test "./sql/benchmark/q4_bench/q4.3.sql"
	printf "\n"
}

function switch_to {
	printf "Switching to $1.\n"
	if [[ $1 = "column" ]]; then
		hdb_run_file ./sql/switch_to_col.sql
	elif [[ $1 = "row" ]]; then
		hdb_run_file ./sql/switch_to_row.sql
	else
		printf "Cannot switch to $1."
	fi
}

function run_all_benchmarks {
	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		hdb_log_start_array
		benchmark $1
		hdb_log_end_array
		hdb_log ","
		printf "\n"
	done
}
