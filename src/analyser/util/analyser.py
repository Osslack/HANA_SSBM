#from terminaltables import AsciiTable as Table
from numpy import median, average, std
import re

class Statistical:
    """ Base class for making statistical analysis on a time sequence. """
    def __init__(self, times):
        self.times = times

    def min(self):
        return min(self.times)

    def max(self):
        return max(self.times)

    def median(self):
        return median(self.times)

    def average(self):
        return average(self.times)

    def std(self):
        return std(self.times)

    def total(self):
        return sum(self.times)

    def get_times(self):
        return self.times

class Query(Statistical):
    """ A query describes a SQL query which is executed in the benchmark """

    def __init__(self, path_to_query, times):
        super().__init__(times)
        self.path_to_query = path_to_query

    def set_times(self, times):
        self.times = times

    def get_name(self):
        """ return the name of the query """
        pass

    @staticmethod
    def from_log(log):
        """ Parse a Query from a given log. """
        #search = re.search("TIME:\\s*([0-9]+)\\susec", line)
            #if search:
                #time = int(search.group(1))
                #times.append(time)
        pass

class Section:

    def __init__(self, name):
        self.name = name
        self.subsections = []

    def add_subsection(self, subsection):
        self.subsection.append(subsection)

    def get_subsections(self):
        return self.subsections

class Analyser:

    def __init__(self, path_to_log):
        self.path_to_log = path_to_log
        print("test")

    def print_stats_ascii(self):
        """ Print all statistics which can be gathered in ascii art. """
        pass
        #table_data = [
        #    [ "", "Time"],
        #    [ "average speed", str(self.average()) + " usec" ],
        #    [ "median speed", str(self.median()) + " usec" ],
        #    [ "maximum speed", str(self.max()) + " usec" ],
        #    [ "minimum speed", str(self.min()) + " usec" ],
        #    [ "standard deviation speed", str(self.std()) + " usec" ],
        #    [ "total speed", str(self.total()) + " usec" ]
        #]
        #table = Table(table_data)
        #print(table.table)

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
