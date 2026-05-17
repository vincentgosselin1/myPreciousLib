//==============================================================================
// axi_uvm_pkg.sv
//
// UVM package for the parameterized AXI4 agent.
// Import this package once in your TB; then declare specialised typedefs
// for each bus configuration you need.
//
// Compilation order
// ─────────────────
//   1. axi_vip_pkg, axi_vip_master_pkg  (Xilinx, from IP catalog)
//   2. uvm_pkg                           (simulator built-in)
//   3. axi_params.sv                     (also defines axi_if)
//   4. axi_uvm_pkg.sv                    (this file)
//
// Note: axi_params.sv and axi_if are compiled OUTSIDE the package because
// interfaces cannot be declared inside a package in SystemVerilog.
//==============================================================================

package axi_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import axi_vip_pkg::*;
    import axi_vip_master_pkg::*;

    // Components (order matters: each file may reference the ones above)
    `include "axi_seq_item.sv"
    `include "axi_driver.sv"
    `include "axi_monitor.sv"
    `include "axi_agent.sv"
    `include "axi_sequences.sv"

endpackage : axi_uvm_pkg
