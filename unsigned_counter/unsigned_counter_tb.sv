`timescale 1ns/1ps

package tb_pkg;
  import uvm_pkg::*;

  // Define your test bench parameters here
  parameter int NUM_BITS = 8;

  class tb_config extends uvm_object;
    `uvm_object_utils(tb_config)
  endclass

  class tb_env extends uvm_env;
    `uvm_component_utils(tb_env)

    // Declare your DUT (Design Under Test) and interfaces here
    unsigned_counter #(NUM_BITS) my_counter;

    // Declare any necessary sequences, sequencers, and agents here

    // Define a configuration object
    tb_config my_config;

    // Function to build the test environment
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    // Function to create and build the test environment components
    virtual function void build();
      super.build();

      // Create the DUT and add it to the environment
      my_counter = unsigned_counter#(NUM_BITS)::type_id::create("my_counter", this);
      uvm_config_db#(unsigned_counter#(NUM_BITS))::set(this, "*", "my_counter", my_counter);

      // Create and set the configuration object
      my_config = tb_config::type_id::create("my_config");
      uvm_config_db#(tb_config)::set(this, "*", "config", my_config);
    endfunction

    // Function to connect the DUT and other components
    virtual function void connect();
      super.connect();

      // Connect the DUT and other components here
    endfunction
  endclass

  class tb_test extends uvm_test;
    `uvm_component_utils(tb_test)

    // Declare any necessary sequences, sequencers, and agents here

    // Define a configuration object
    tb_config my_config;

    // Function to build the test
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    // Function to create and build the test components
    virtual function void build();
      super.build();

      // Create and set the configuration object
      my_config = tb_config::type_id::create("my_config");
      uvm_config_db#(tb_config)::set(this, "*", "config", my_config);

      // Create sequences, sequencers, and agents here
    endfunction

    // Function to run the test
    virtual task run();
      // Start the sequences, handle results, etc.
    endtask
  endclass
endpackage

// Main test bench module
module tb;
  import uvm_pkg::*;

  initial begin
    // Initialize UVM
    uvm_pkg::uvm_cmdline_processor::process_cmdline();

    // Create the test environment
    tb_pkg.tb_env env;
    env = tb_pkg.tb_env::type_id::create("env", null);
    env.build();

    // Create the test
    tb_pkg.tb_test test;
    test = tb_pkg.tb_test::type_id::create("test", null);
    test.build();

    // Run the test
    test.run();
  end
endmodule
