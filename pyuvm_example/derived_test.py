from pyuvm import *
from base_test import BaseTest

class DerivedTest(BaseTest):
    def build(self):
        """Build the derived test."""
        super().build()

    async def run_phase(self):
        """Override run phase to inject errors."""
        # Perform a write operation with an error (wrong data)
        self.env.agent.driver.vif.write_en <= 1
        self.env.agent.driver.vif.write_data <= 32'hBAD_DATA
        self.env.agent.driver.vif.addr <= 0x1
        await cocotb.triggers.Timer(10, units="ns")
        # Inject error during read operation
        self.env.agent.driver.vif.write_en <= 0
        await cocotb.triggers.Timer(10, units="ns")
        self.scoreboard.write(self.env.agent.monitor.vif.read_data)
