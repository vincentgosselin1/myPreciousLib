from pyuvm import *
from agent import MemoryAgent
from env_config import EnvConfig

class TestEnv(UVMEnv):
    def __init__(self, name, config=None):
        super().__init__(name)
        self.config = config or EnvConfig(name="DefaultEnvConfig")
        self.agent = None

    def build(self):
        """Build the environment components."""
        self.agent = MemoryAgent(name="MemoryAgent", config=self.config)
        self.add(self.agent)

    def start(self, parent):
        """Start the environment components."""
        self.agent.start(parent)
