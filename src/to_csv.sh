#!/bin/bash

path="."
if [ $# -gt 0 ]; then
	path=$1
fi

for tbl in $path/*.tbl; do
	base=`basename $tbl .tbl`
	csv="$base.csv"
	rm -f $csv
	(cat $tbl | sed -e 's/|/:/g' > "$path/$csv") &
done

wait < <(jobs -p)
