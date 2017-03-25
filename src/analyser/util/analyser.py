#from terminaltables import AsciiTable as Table
from numpy import median, average, std
from .table import display_table
import re
import json
from functools import reduce
import matplotlib.pyplot as plt

class Statistical:
    """
    Base class for making statistical analysis on a time sequence.
    """
    def __init__(self, times, name):
        self.times = times
        self.name = name

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

    def get_name(self):
        return self.name

    def set_name(self, name):
        self.name = name

    def get_stats(self):
        return [
            ["Samples", int(round(self.samples(), 0))],
            ["Average", int(round(self.average(), 0))],
            ["Min", int(round(self.min(), 0))],
            ["Max", int(round(self.max(), 0))],
            ["Median", int(round(self.median(), 0))],
            ["Standard Deviation", int(round(self.std(), 0))],
            ["Total", int(round(self.total(), 0))]
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
    """
    Compare multiple benchmarks.
    """

    def __init__(self, *statisticals):
        self.statisticals = statisticals

    def get_keys(self, stats):
        return set([row[0] for stat in stats for row in stat])


    def get_statisticals(self):
        return list(sorted(self.statisticals, key=lambda x: x.get_name()))

    def get_data(self):
        data = [ self._create_headings(*self.benchmarks) ]
        data += self.join_stats(self.get_stats())
        return data

    def join_stats(self, stats):
        stats = list(map(lambda x: x.get_stats(), stats))
        data = []
        for key in self.get_keys(stats):
            row = [key]
            for stat in stats:
                row.append(self._get_stat_value(key, stat))
            data.append(row)
        return data

    def compare_raw(self):
        data = [self._create_headings(*self.get_statisticals())]
        data += self.join_stats(self.get_statisticals())
        display_table(data)

    def compare(self):
        data = [self._create_headings(*self.get_statisticals())]
        data += list(map(lambda x: self.normalize_row(x), self.join_stats(self.get_statisticals())))
        display_table(data)

    def normalize_row(self, row):
        name = row[0]
        values = row[1:]
        result = []
        if min(values) - max(values) == 0:
            return row
        for value in values:
            result += [round((value - min(values)) / (max(values) - min(values)), 2)]
        return [name] + result

    def compare_visually(self):
        plt.subplot()
        for statistical in self.get_statisticals():
            plt.plot(statistical.get_times(), label=statistical.get_name())
        plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
        plt.show()

    def _create_headings(self, *benchmarks):
        return [""] + [benchmark.get_name() for benchmark in benchmarks]

    def _get_stat_value(self, key, stat):
        for row in stat:
            if row[0] == key:
                return row[1]
        return "-"
    def _statisticals_to_stat(self):
        return [statistical.get_stats() for statistical in self.get_statisticals()]

class Benchmark(Statistical):

    def __init__(self, data, name=""):
        self.data = data
        super().__init__(list(self.get_all_times()), name)

    # Simple getters
    def count_repetitions(self):
        """
        Returns how often the benchmark
        was repeated.
        """
        return len(self.get_repetitions())

    def get_repetitions(self):
        """
        Returns all repetitions.
        This is a json structur, therefore a repetition is
        a list of tests.
        """
        return self.data

    def get_all_times(self):
        """
        Get every total time of a repetition.
        """
        for repetition in self.get_repetitions():
            yield self._get_repetition_time(repetition)

    def get_all_filenames(self):
        """
        Returns a list of all filenames which contain queries
        which were used in this benchmark.
        """
        return set([
            result["Filename"]
            for benchmark in self.data
            for result in benchmark
        ])

    def get_all_querynames(self):
        """
        Returns a list of all query names e.g.: q1.1 etc.
        which were used in this benchmark.
        """
        return list(map(lambda x: self._extract_queryname(x), self.get_all_filenames()))

    def get_query(self, name):
        """
        Get all tests for a given test name e.g. q1.1 etc.
        """
        return [
            result
            for benchmark in self.data
            for result in benchmark
            if self._extract_queryname(result["Filename"]) == name
        ]

    def get_all_queries(self):
        """
        Get all Queries grouped by their name.
        """
        result = { }

        for name in self.get_all_querynames():
            result[name] = self.get_query(name)

        return result

    def get_query_stats(self, name_condition=lambda x: re.search("\\.", x)):
        """
        Returns a statistical object for every query
        which is executed by this benchmark.
        """
        result = []
        for name, query in self._filter_grouped_sqls(self.get_all_queries(), name_condition).items():
            result.append(self._query_to_stat(name, query))
        return result

    def print_stats(self):
        display_table(self.get_stats())

    # Helper functions
    def _extract_queryname(self, path):
        match = re.search("/([^\/]+)\\.sql", path)
        if match:
            return match.group(1)
        else:
            return "unknown"

    def _extract_time(self, test):
        time_string = test["times"]
        times = list(map(
            lambda x: int(x),
            filter(
                lambda y: y != "",
                re.split(";", time_string)
            )
        ))
        return reduce(lambda x, y: x + y or 0, times)

    def _get_repetition_time(self, repetition):
        return reduce(lambda x, y: x + y or 0, map(lambda z: self._extract_time(z), repetition))

    def _query_to_stat(self, name, query):
        times = list(map(lambda test: self._extract_time(test), query))
        return Statistical(times, name)

    def _filter_grouped_sqls(self, queries, name_condition):
        return dict({k: v for k, v in queries.items() if name_condition(k)})

class Analyser:
    """
    Analyse a log file.
    This means extracting the general data and every benchmark.
    """

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
        return Benchmark(self.log["row_benchmark_Index"], "Row Benchmark with Index")
