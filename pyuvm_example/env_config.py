from pyuvm import *

class EnvConfig(UVMObject):
    def __init__(self, name, mem_depth=256, bus_width=8):
        super().__init__(name)
        self.mem_depth = mem_depth
        self.bus_width = bus_width
