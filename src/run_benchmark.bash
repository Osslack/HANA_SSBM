#!/bin/bash
source ./hdbsql.bash
source ./all_benchmarks.bash

# Settings
repetitions=20

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

hdb_start_benchmark "column_benchmark_no_Index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_run_file_lite ./sql/addBasicIndizes

hdb_start_benchmark "column_benchmark_index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark


# Run row benchmark
hdb_run_file_lite ./sql/schemaRow.sql
hdb_run_file_lite ./sql/import.sql

hdb_start_benchmark "row_benchmark_no_Index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark

hdb_run_file_lite ./sql/addBasicIndizes

hdb_start_benchmark "row_benchmark_Index"
run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
hdb_end_benchmark
# TODO
# Once up on a time, a little script
# executed sql files. It was happy and satisfied that
# it was working so well running on bash and leaving
# everybody in the dust.
#
# Hurry, Hurry said the novice programmer to git.
# This needs to go out, the world must know this little script!!!
# And git did its job, knowing how lazy the programmer was,
# but unable to speak. Git pushed the script into the
# digital universe and threw the baby out with the bathwater
# lead by the terror of its master.
#
# On the other side of universe a wise programmer
# stumbles up on the little script.
# In fear of maleware cautiously but curious reading it before running it.
# Horrified by some lines of code and naming conventions
# he realizes how stubborn the novice programmer was,
# leaving a note for him:
#
# "Voices without mouths, throats or lungs; they know no language, but answers all tongues."
#
# Please think about this riddle it will lead you the path.
#

#Run with indizes
# Run column benchmark
# switch_to "column"
# 
# printf "Building indizes"
# hdb_run_file "./sql/addBasicIndizes.sql"
# 
# hdb_start_benchmark "column_indizes_benchmark"
# run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
# hdb_end_benchmark
# 
# # Run row benchmark
# switch_to "row"
# 
# printf "Rebuilding lineorder index"
# hdb_run_file "./sql/lineOrderIndex.sql"
# 
# hdb_start_benchmark "row_indizes_benchmark"
# run_all_benchmarks "/usr/sap/HXE/HDB90/work" $repetitions
# hdb_end_benchmark

hdb_finish_log
