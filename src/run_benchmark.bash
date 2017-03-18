#!/bin/bash
source ./hdbsql.bash
source ./all_benchmarks.bash

# Settings
repetitions=250

hdb_ask $1

hdb_init_log

#First run without indizes
# Run column benchmark
switch_to "column"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions

# Run row benchmark
switch_to "row"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions

#Run with indizes
# Run column benchmark
switch_to "column"

printf "Building indizes"
hdb_run_file "./sql/addBasicIndizes.sql"

run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions

# Run row benchmark
switch_to "row"
printf "Rebuilding lineorder index"
hdb_run_file "./sql/lineOrderIndex.sql"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions

hdb_finish_log
