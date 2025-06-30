from pyuvm import *

class DUTWrapper(UVMComponent):
    def __init__(self, name, dut):
        super().__init__(name)
        self.dut = dut
        self.addr = dut.addr
        self.write_data = dut.write_data
        self.write_en = dut.write_en
        self.read_data = dut.read_data
        self.ready = dut.ready

    def reset(self):
        """Reset the DUT."""
        self.write_en <= 0
        self.addr <= 0
        self.write_data <= 0

    async def drive_signals(self):
        """Drive signals for the DUT."""
        self.addr <= 0x1
        self.write_data <= 32'hDEAD_BEEF
        self.write_en <= 1
        await cocotb.triggers.Timer(10, units='ns')
        self.write_en <= 0
        await cocotb.triggers.Timer(10, units='ns')
