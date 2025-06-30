class MemoryVIF(UVMObject):
    def __init__(self, name):
        super().__init__(name)
        self.addr = None
        self.write_data = None
        self.write_en = None
        self.read_data = None
        self.ready = None


from pyuvm import *
from driver import MemoryDriver
from monitor import MemoryMonitor
from vif import MemoryVIF

class MemoryAgent(UVMAgent):
    def __init__(self, name, config):
        super().__init__(name)
        self.vif = MemoryVIF(name="MemoryVIF")
        self.driver = MemoryDriver(name="MemoryDriver", vif=self.vif)
        self.monitor = MemoryMonitor(name="MemoryMonitor", vif=self.vif)

    def start(self, parent):
        self.driver.start(parent)
        self.monitor.start(parent)
        
