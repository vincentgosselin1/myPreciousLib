import cocotb
from cocotb.regression import TestFactory
from pyuvm import *
from env import TestEnv
from dut_wrapper import DUTWrapper

class TestTop(UVMTestCase):
    def build(self):
        """Build the UVM environment."""
        self.env = TestEnv(name="TestEnv")
        self.dut_wrapper = DUTWrapper(name="DUTWrapper", dut=self.dut)
        self.env.add(self.dut_wrapper)

    async def run_phase(self):
        """Run the test phases."""
        self.env.start(self)

    def check_results(self):
        """Check results after simulation."""
        assert self.dut_wrapper.dut.ready.value == 1, "DUT did not respond with ready signal."

# Cocotb test fixture
@cocotb.coroutine
def run_test(dut):
    factory = TestFactory(TestTop)
    factory.add_option("-sv")
    factory.generate()

    cocotb.fork(cocotb.start_soon(dut.clk))
    yield cocotb.external(lambda: factory.run())
