#!/bin/bash
source ./hdbsql.bash
source ./all_benchmarks.bash

# Settings
repetitions=1

hdb_ask $1

hdb_init_log

# General Information
hdb_log_start_attribute "General"
hdb_log_start_map
hdb_log_set_attribute "Repetitions:" "$repetitions"
hdb_log_end_map
hdb_log_end_attribute

# Run column benchmark
switch_to "column"

hdb_start_benchmark "column_benchmark"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

# Run row benchmark
switch_to "row"

hdb_start_benchmark "row_benchmark"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_finish_log
