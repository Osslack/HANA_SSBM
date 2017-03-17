from terminaltables import AsciiTable as Table
from numpy import median, average, std
import re

class Analyser:

    def __init__(self, path_to_log):
        self.times = self._get_times(path_to_log)

    def print_stats(self):
        """ Print all statistics which can be gathered. """
        table_data = [
            [ "", "Time"],
            [ "average speed", str(self.average()) + " usec" ],
            [ "median speed", str(self.median()) + " usec" ],
            [ "maximum speed", str(self.max()) + " usec" ],
            [ "minimum speed", str(self.min()) + " usec" ],
            [ "standard deviation speed", str(self.std()) + " usec" ],
            [ "total speed", str(self.total()) + " usec" ]
        ]
        table = Table(table_data)
        print(table.table)

    def _get_times(self, path_to_log):
        log_file = open(path_to_log, "r")

        times = []

        for line in log_file:
            search = re.search("TIME:\\s*([0-9]+)\\susec", line)
            if search:
                time = int(search.group(1))
                times.append(time)
        return times

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
