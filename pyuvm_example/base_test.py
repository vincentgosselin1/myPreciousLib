from pyuvm import *
from scoreboard import Scoreboard

class BaseTest(UVMTestCase):
    def build(self):
        """Build the base test."""
        self.env = TestEnv(name="BaseTestEnv")
        self.env.build()
        self.scoreboard = Scoreboard(name="Scoreboard")
        self.env.add(self.scoreboard)

    async def run_phase(self):
        """Run base test logic."""
        # Perform a write operation
        self.env.agent.driver.vif.write_en <= 1
        self.env.agent.driver.vif.write_data <= 32'hDEAD_BEEF
        self.env.agent.driver.vif.addr <= 0x1
        await cocotb.triggers.Timer(10, units="ns")
        
        # Perform a read operation
        self.env.agent.driver.vif.write_en <= 0
        await cocotb.triggers.Timer(10, units="ns")
        self.scoreboard.write(self.env.agent.monitor.vif.read_data)
