#from terminaltables import AsciiTable as Table
from numpy import median, average, std
from .table import display_table
import re
import json
from functools import reduce

class Statistical:
    """
    Base class for making statistical analysis on a time sequence.
    """
    def __init__(self, times):
        self.times = times

    def min(self):
        return min(self.get_times())

    def max(self):
        return max(self.get_times())

    def median(self):
        return median(self.get_times())

    def average(self):
        return average(self.get_times())

    def std(self):
        return std(self.get_times())

    def total(self):
        return sum(self.get_times())

    def samples(self):
        return len(self.get_times())

    def get_times(self):
        return self.times

    def get_stats(self):
        return [
            ["Samples", round(self.samples(), 0)],
            ["Average", round(self.average(), 0)],
            ["Min", round(self.min(), 0)],
            ["Max", round(self.max(), 0)],
            ["Median", round(self.median(), 0)],
            ["Standard Deviation", round(self.std(), 0)],
            ["Total", round(self.total(), 0)]
        ]

class Script(Statistical):
    """
    A query describes a SQL query which is executed in the benchmark.
    """

    def __init__(self, data):
        self.data = data
        super().__init__(self.get_all_times())

    def get_data(self):
        return self.data

    def get_statement(self):
        with open(self.get_path_to_file()) as statement:
            return statement.read()

    def get_path_to_file(self):
        return "../" + self.get_data()["Filename"]

    def get_times(self):
        return list(map(lambda x: int(x),
            filter(lambda x: x != "",
                re.split(";", self.get_data()["times"])
                )
            )
        )

class Comparison:

    def __init__(self, *benchmarks):
        self.benchmarks = benchmarks

    def get_keys(self, stats):
        return set([row[0] for stat in stats for row in stat])

    def get_stats(self):
        return [benchmark.get_stats() for benchmark in self.benchmarks]

    def _get_stat_value(self, key, stat):
        for row in stat:
            if row[0] == key:
                return row[1]
        return "-"

    def get_data(self):
        data = [ self._create_headings(*self.benchmarks) ]
        data += self.join_stats(self.get_stats())
        return data

    def join_stats(self, stats):
        data = []
        for key in self.get_keys(stats):
            row = [key]
            for stat in stats:
                row.append(self._get_stat_value(key, stat))
            data.append(row)
        return data

    def get_benchmark(self, name):
        for benchmark in self.benchmarks:
            if benchmark.get_name() == name:
                return benchmark

    def _create_headings(self, *benchmarks):
        return [""] + [benchmark.get_name() for benchmark in benchmarks]

    def compare(name1, name2):
        b1 = self.get_benchmark(name1)
        b2 = self.get_benchmakr(name2)
        data = [ self._create_headings(b1, b2) + ["Difference"] ]
        stat = self.join_stats(b1.get_stats(), b2.get_stats())
        for row in stat:
            row.append(row[1] - row[2])
            data.append(row)
        display_table(data)

    def print(self):
        display_table(self.get_data())




class Benchmark(Statistical):
    def __init__(self, data, name=""):
        self.data = data
        self.name = name
        super().__init__(list(self.get_all_times()))

    def count_repetitions(self):
        return len(self.get_repetitions())

    def get_repetitions(self):
        return self.data

    def get_tests(self):
        return [Test(data)
                for data in repetition
                for repetition in self.get_repetitions()]

    def get_all_filenames(self):
        return set([
            result["Filename"]
            for benchmark in self.data
            for result in benchmark
        ])

    def get_all_querynames(self):
        return map(lambda x: x, self.get_all_filenames())

    def get_query(self, name):
        return [
            result
            for benchmark in self.data
            for result in benchmark
            if result["Filename"] == name
        ]

    def get_all_queries(self):
        filenames = self.get_all_filenames()
        return [self.get_query(name) for name in filenames]

    def get_benchmarks(self):
        for benchmark in self.data:
            yield benchmark

    def get_all_times(self):
        for benchmark in self.get_benchmarks():
            time = 0
            for test in benchmark:
                time_string = test["times"]
                times = list(map(
                    lambda x: int(x),
                    filter(
                        lambda y: y != "",
                        re.split(";", time_string)
                    )
                ))
                time += reduce(lambda x, y: x + y or 0, times)
            yield time

    def get_name(self):
        return self.name

class Analyser:

    def __init__(self, path_to_log):
        with open(path_to_log, "r") as log:
            self.log = json.loads(log.read())

    def get_repetitions(self):
        return int(self.log["General"]["Repetitions:"])

    def get_column_benchmark(self):
        return Benchmark(self.log["column_benchmark_no_index"], "Column Benchmark")

    def get_row_benchmark(self):
        return Benchmark(self.log["row_benchmark_no_index"], "Row Benchmark")

    def get_column_benchmark_I(self):
        return Benchmark(self.log["column_benchmark_index"], "Column Benchmark with Index")

    def get_row_benchmark_I(self):
        return Benchmark(self.log["row_benchmark_index"], "Row Benchmark with Index")

    def print_stats(self, stats):
        """ Print all statistics which can be gathered in ascii art. """
        display_table(stats)

    def print_benchmark_stats(self, benchmark):
        stats = benchmark.get_stats()
        display_table(stats)

    def set_query_filter(self, filter):
        """
        This sets a filter which will be executed on every query
        before a statistical analysis is done.
        """
        self.filter = filter

    def print_stats(self):
        """ Print all statistics via matplotlib. """
        pass

    def print_fastest_queries(self, num=3):
        """ Print the num fastest queries. """
        queries = self._get_queries()
        #TODO print query
        #TODO print context -> column, row, index etc.

    def print_slowest_queries(self, num=3):
        """ Print the num slowest queries. """
        queries = self._get_queries()
        #TODO print query
        #TODO print context -> column, row, index etc.

    def compare(self, *args):
        #TODO fastes
        #TODO slowest
        #TODO average etc.
        pass

    def _get_queries(self):
        log_file = open(self.path_to_log, "r")
        #TODO filter queries

        for line in log_file:
            # get sql name or file
            # create query
            # add query 

            pass
            # TODO
