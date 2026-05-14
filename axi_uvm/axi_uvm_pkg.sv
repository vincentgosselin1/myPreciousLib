//==============================================================================
// axi_uvm_pkg.sv
//
// Top-level package that imports all AXI UVM VIP components in the correct
// compilation order.  Include this package (and axi_if.sv) in your filelist
// before any test or environment files.
//
// Compilation order within the package:
//   1. axi_seq_item  – transaction object (no dependencies)
//   2. axi_driver    – depends on seq_item + Xilinx VIP types
//   3. axi_monitor   – depends on seq_item
//   4. axi_agent     – depends on driver + monitor
//   5. axi_sequences – depends on seq_item + agent
//==============================================================================

package axi_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Xilinx AXI VIP packages (must be compiled before this package)
    import axi_vip_pkg::*;
    import axi_vip_master_pkg::*;

    //--------------------------------------------------------------------------
    // Re-export AXI parameter constants so all components share them
    // (mirrors the localparam declarations in the original testbench)
    //--------------------------------------------------------------------------
    localparam AXI_ADDR_W   = axi_vip_master_pkg::axi_vip_master_VIP_ADDR_WIDTH;
    localparam AXI_DATA_W   = axi_vip_master_pkg::axi_vip_master_VIP_DATA_WIDTH;
    localparam AXI_STRB_W   = AXI_DATA_W / 8;
    localparam AXI_BURST_W  = 2;
    localparam AXI_CACHE_W  = 4;
    localparam AXI_PROT_W   = 3;
    localparam AXI_REGION_W = 4;
    localparam AXI_USER_W   = 4;
    localparam AXI_QOS_W    = 4;
    localparam AXI_LEN_W    = 8;
    localparam AXI_SIZE_W   = 3;
    localparam AXI_RESP_W   = 2;

    //--------------------------------------------------------------------------
    // Re-export AXI enum types
    //--------------------------------------------------------------------------
    typedef enum logic [AXI_BURST_W-1:0] {
        AXI_BURST_FIXED = 2'b00,
        AXI_BURST_INCR  = 2'b01,
        AXI_BURST_WRAP  = 2'b10,
        AXI_BURST_RSVD  = 2'b11
    } axi_burst_t;

    typedef enum logic [AXI_RESP_W-1:0] {
        AXI_RESP_OKAY   = 2'b00,
        AXI_RESP_EXOKAY = 2'b01,
        AXI_RESP_SLVERR = 2'b10,
        AXI_RESP_DECERR = 2'b11
    } axi_resp_t;

    typedef enum logic [AXI_SIZE_W-1:0] {
        AXI_SIZE_1B   = 3'b000,
        AXI_SIZE_2B   = 3'b001,
        AXI_SIZE_4B   = 3'b010,
        AXI_SIZE_8B   = 3'b011,
        AXI_SIZE_16B  = 3'b100,
        AXI_SIZE_32B  = 3'b101,
        AXI_SIZE_64B  = 3'b110,
        AXI_SIZE_128B = 3'b111
    } axi_size_t;

    // Convenience typedef matching the original testbench
    typedef axi_vip_master_pkg::axi_vip_master_mst_t axi_mst_agent_t;

    //--------------------------------------------------------------------------
    // Components (included in dependency order)
    //--------------------------------------------------------------------------
    `include "axi_seq_item.sv"
    `include "axi_driver.sv"
    `include "axi_monitor.sv"     // also defines axi_if (or separate axi_if.sv)
    `include "axi_agent.sv"
    `include "axi_sequences.sv"

endpackage : axi_uvm_pkg
