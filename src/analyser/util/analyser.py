#from terminaltables import AsciiTable as Table
from numpy import median, average, std
from .table import display_table
import re
import json

class Statistical:
    """ Base class for making statistical analysis on a time sequence. """
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
            ["Samples", self.samples()],
            ["Average", self.average()],
            ["Min", self.min()],
            ["Max", self.max()],
            ["Median", self.median()],
            ["Standard Deviation", self.std()],
            ["Total", self.total()]
        ]

class Script(Statistical):
    """ A query describes a SQL query which is executed in the benchmark """

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


class Benchmark(Statistical):
    def __init__(self, data):
        self.data = data
        super().__init__(self.get_all_times())

    def count_repetitions(self):
        return len(self.get_repetitions())

    def get_repetitions(self):
        return self.data

    def get_tests(self):
        return [Test(data)
                for data in repetition
                for repetition in self.get_repetitions()]

    def get_all_times(self):
        times = []

        for repetition in self.data:
            for query in repetition:
                times = times + list(map(
                        lambda x: int(x),
                        filter(lambda x: x != "",
                            re.split(";", query["times"]))))
        return times

class Analyser:

    def __init__(self, path_to_log):
        with open(path_to_log, "r") as log:
            self.log = json.loads(log.read())

    def get_repetitions(self):
        return int(self.log["General"]["Repetitions:"])

    def get_column_benchmark_noI(self):
        return Benchmark(self.log["column_benchmark_no_index"])

    def get_column_benchmark_I(self):
        return Benchmark(self.log["column_benchmark_index"])

    def get_row_benchmark_noI(self):
        return Benchmark(self.log["row_benchmark_no_index"])

    def get_row_benchmark_I(self):
        return Benchmark(self.log["row_benchmark_index"])

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
