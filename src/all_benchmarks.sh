#!/bin/bash

instance=${instance:-90}
database=${database:-SystemDB}
username=${username:-username}
log_path=${log_path:-/usr/sap/HXE/HDB90/work/log.log}
tmp_path="/tmp/benchmark.log"


function test {
	printf "."
	echo "Running test $1" >> "$log_path"
	hdbsql -i "$instance" -d "$database" -u "$username" -p "$password" -T "$tmp_path" -O /dev/null -I "$1"
	awk '/::GET SERVER PROCESSING TIME.*/,/TIME:\s*([0-9]*)\susec/' "$tmp_path" >> "$log_path"
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
}

function run_all_benchmarks {
	rm "$log_path"
	tmp_path=$(mktemp "$tmp_path.XXX")

	for i in `seq 1 ${2:-1}`; do
		printf "Running benchmark number $i"
		benchmark $1
		printf "\n"
	done

	rm "$tmp_path"
}
