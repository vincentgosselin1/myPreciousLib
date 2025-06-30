from pyuvm import *
import cocotb

class MemoryDriver(UVMDriver):
    def __init__(self, name, vif):
        super().__init__(name)
        self.vif = vif

    async def run_phase(self):
        while True:
            self.vif.addr <= 0x1
            self.vif.write_data <= 32'hDEAD_BEEF
            self.vif.write_en <= 1
            await cocotb.triggers.Timer(10, units="ns")
            self.vif.write_en <= 0
            await cocotb.triggers.Timer(10, units="ns")
