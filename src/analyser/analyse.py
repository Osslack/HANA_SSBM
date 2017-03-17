#!/usr/bin/env python3
import argparse
from functools import reduce
from terminaltables import SingleTable
from numpy import median, average, std
import re

def parse_args():
    parser = argparse.ArgumentParser(description="Analyse your Benchmark log")
    parser.add_argument(
        "path_to_log",
        help="Path to File containing the logs of the benchmark."
    )
    return vars(parser.parse_args())

def get_times(args):
    log_file = open(args["path_to_log"], "r")

    times = []

    for line in log_file:
        search = re.search("TIME:\\s*([0-9]+)\\susec", line)
        if search:
            time = int(search.group(1))
            times.append(time)
    return times


def print_statistics(times):
    """ Print all statistics which can be gathered. """
    table_data = [
        [ "", "Time"],
        [ "average speed", str(average(times)) + " usec" ],
        [ "median speed", str(median(times)) + " usec" ],
        [ "maximum speed", str(max(times)) + " usec" ],
        [ "minimum speed", str(min(times)) + " usec" ],
        [ "standard deviation speed", str(std(times)) + " usec" ],
        [ "total speed", str(sum(times)) + " usec" ]
    ]
    table = SingleTable(table_data)
    print(table.table)

def main():
    """ Main function """
    args = parse_args()
    times = get_times(args)
    print_statistics(times)

main()
