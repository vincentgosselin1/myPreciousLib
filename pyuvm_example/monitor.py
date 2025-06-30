from pyuvm import *
import cocotb

class MemoryMonitor(UVMMonitor):
    def __init__(self, name, vif):
        super().__init__(name)
        self.vif = vif

    async def run_phase(self):
        while True:
            if self.vif.ready == 1:
                print(f"Monitor: Read data = {self.vif.read_data}")
            await cocotb.triggers.Timer(10, units="ns")
