from pyuvm import *

class Scoreboard(UVMScoreboard):
    def __init__(self, name):
        super().__init__(name)
        self.expected_data = None

    def write(self, data):
        """Compare read data with expected output."""
        if data != self.expected_data:
            print(f"ERROR: Expected {self.expected_data}, got {data}")
        else:
            print(f"PASS: Expected {self.expected_data}, got {data}")
