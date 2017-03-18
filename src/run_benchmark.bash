#!/bin/bash
source ./hdbsql.bash
source ./all_benchmarks.bash

hdb_ask $1

hdb_init_log

# Run column benchmark
switch_to "column"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" 10

# Run row benchmark
switch_to "row"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" 10

hdb_finish_log
