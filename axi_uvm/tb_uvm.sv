//==============================================================================
// tb_uvm.sv
//
// Top-level testbench that shows how to integrate the axi_uvm_pkg agent
// with the existing Xilinx AXI VIP master and the axi_ram DUT.
//
// Key integration points
// ──────────────────────
//  1. Import axi_uvm_pkg.
//  2. Instantiate axi_if and pass its virtual handle via uvm_config_db.
//  3. Create and start the Xilinx VIP master agent.
//  4. Set the vip_agent handle on the UVM agent (or via config_db).
//  5. Run your UVM test with run_test().
//==============================================================================

`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

import axi_vip_pkg::*;
import axi_vip_master_pkg::*;
import axi_uvm_pkg::*;

module tb_uvm();

    //--------------------------------------------------------------------------
    // Clock and reset
    //--------------------------------------------------------------------------
    bit aclk;
    always #10 aclk = ~aclk;   // 50 MHz

    bit aresetn;
    initial begin
        aresetn = 1'b0;
        repeat (20) @(negedge aclk);
        aresetn = 1'b1;
    end

    //--------------------------------------------------------------------------
    // AXI signal bus (flat wires, connected to VIP and DUT)
    //--------------------------------------------------------------------------
    // Reuse the same declarations from the original tb.sv
    logic [AXI_ADDR_W-1:0]   axi_awaddr;
    logic [AXI_LEN_W-1:0]    axi_awlen;
    logic [AXI_SIZE_W-1:0]   axi_awsize;
    logic [AXI_BURST_W-1:0]  axi_awburst;
    logic                    axi_awlock;
    logic [AXI_CACHE_W-1:0]  axi_awcache;
    logic [AXI_PROT_W-1:0]   axi_awprot;
    logic [AXI_REGION_W-1:0] axi_awregion;
    logic [AXI_QOS_W-1:0]    axi_awqos;
    logic                    axi_awvalid;
    logic                    axi_awready;
    logic [AXI_DATA_W-1:0]   axi_wdata;
    logic [AXI_STRB_W-1:0]   axi_wstrb;
    logic                    axi_wlast;
    logic                    axi_wvalid;
    logic                    axi_wready;
    logic [AXI_RESP_W-1:0]   axi_bresp;
    logic                    axi_bvalid;
    logic                    axi_bready;
    logic [AXI_ADDR_W-1:0]   axi_araddr;
    logic [AXI_LEN_W-1:0]    axi_arlen;
    logic [AXI_SIZE_W-1:0]   axi_arsize;
    logic [AXI_BURST_W-1:0]  axi_arburst;
    logic                    axi_arlock;
    logic [AXI_CACHE_W-1:0]  axi_arcache;
    logic [AXI_PROT_W-1:0]   axi_arprot;
    logic [AXI_REGION_W-1:0] axi_arregion;
    logic [AXI_QOS_W-1:0]    axi_arqos;
    logic                    axi_arvalid;
    logic                    axi_arready;
    logic [AXI_DATA_W-1:0]   axi_rdata;
    logic [AXI_RESP_W-1:0]   axi_rresp;
    logic                    axi_rlast;
    logic                    axi_rvalid;
    logic                    axi_rready;

    //--------------------------------------------------------------------------
    // axi_if – monitored by the UVM monitor
    //--------------------------------------------------------------------------
    axi_if #(
        .ADDR_W   (AXI_ADDR_W),
        .DATA_W   (AXI_DATA_W),
        .STRB_W   (AXI_STRB_W),
        .LEN_W    (AXI_LEN_W),
        .SIZE_W   (AXI_SIZE_W),
        .BURST_W  (AXI_BURST_W),
        .CACHE_W  (AXI_CACHE_W),
        .PROT_W   (AXI_PROT_W),
        .REGION_W (AXI_REGION_W),
        .QOS_W    (AXI_QOS_W),
        .RESP_W   (AXI_RESP_W)
    ) axi_bus_if (.aclk(aclk), .aresetn(aresetn));

    // Connect interface signals to the flat bus wires
    assign axi_bus_if.awaddr   = axi_awaddr;
    assign axi_bus_if.awlen    = axi_awlen;
    assign axi_bus_if.awsize   = axi_awsize;
    assign axi_bus_if.awburst  = axi_awburst;
    assign axi_bus_if.awlock   = axi_awlock;
    assign axi_bus_if.awcache  = axi_awcache;
    assign axi_bus_if.awprot   = axi_awprot;
    assign axi_bus_if.awregion = axi_awregion;
    assign axi_bus_if.awqos    = axi_awqos;
    assign axi_bus_if.awvalid  = axi_awvalid;
    assign axi_bus_if.awready  = axi_awready;
    assign axi_bus_if.wdata    = axi_wdata;
    assign axi_bus_if.wstrb    = axi_wstrb;
    assign axi_bus_if.wlast    = axi_wlast;
    assign axi_bus_if.wvalid   = axi_wvalid;
    assign axi_bus_if.wready   = axi_wready;
    assign axi_bus_if.bresp    = axi_bresp;
    assign axi_bus_if.bvalid   = axi_bvalid;
    assign axi_bus_if.bready   = axi_bready;
    assign axi_bus_if.araddr   = axi_araddr;
    assign axi_bus_if.arlen    = axi_arlen;
    assign axi_bus_if.arsize   = axi_arsize;
    assign axi_bus_if.arburst  = axi_arburst;
    assign axi_bus_if.arlock   = axi_arlock;
    assign axi_bus_if.arcache  = axi_arcache;
    assign axi_bus_if.arprot   = axi_arprot;
    assign axi_bus_if.arregion = axi_arregion;
    assign axi_bus_if.arqos    = axi_arqos;
    assign axi_bus_if.arvalid  = axi_arvalid;
    assign axi_bus_if.arready  = axi_arready;
    assign axi_bus_if.rdata    = axi_rdata;
    assign axi_bus_if.rresp    = axi_rresp;
    assign axi_bus_if.rlast    = axi_rlast;
    assign axi_bus_if.rvalid   = axi_rvalid;
    assign axi_bus_if.rready   = axi_rready;

    //--------------------------------------------------------------------------
    // Xilinx AXI VIP Master
    //--------------------------------------------------------------------------
    axi_vip_master axi_mst (
        .aclk           (aclk),
        .aresetn        (aresetn),
        .m_axi_awaddr   (axi_awaddr),
        .m_axi_awlen    (axi_awlen),
        .m_axi_awsize   (axi_awsize),
        .m_axi_awburst  (axi_awburst),
        .m_axi_awlock   (axi_awlock),
        .m_axi_awcache  (axi_awcache),
        .m_axi_awprot   (axi_awprot),
        .m_axi_awregion (axi_awregion),
        .m_axi_awqos    (axi_awqos),
        .m_axi_awvalid  (axi_awvalid),
        .m_axi_awready  (axi_awready),
        .m_axi_wdata    (axi_wdata),
        .m_axi_wstrb    (axi_wstrb),
        .m_axi_wlast    (axi_wlast),
        .m_axi_wvalid   (axi_wvalid),
        .m_axi_wready   (axi_wready),
        .m_axi_bresp    (axi_bresp),
        .m_axi_bvalid   (axi_bvalid),
        .m_axi_bready   (axi_bready),
        .m_axi_araddr   (axi_araddr),
        .m_axi_arlen    (axi_arlen),
        .m_axi_arsize   (axi_arsize),
        .m_axi_arburst  (axi_arburst),
        .m_axi_arlock   (axi_arlock),
        .m_axi_arcache  (axi_arcache),
        .m_axi_arprot   (axi_arprot),
        .m_axi_arregion (axi_arregion),
        .m_axi_arqos    (axi_arqos),
        .m_axi_arvalid  (axi_arvalid),
        .m_axi_arready  (axi_arready),
        .m_axi_rdata    (axi_rdata),
        .m_axi_rresp    (axi_rresp),
        .m_axi_rlast    (axi_rlast),
        .m_axi_rvalid   (axi_rvalid),
        .m_axi_rready   (axi_rready)
    );

    //--------------------------------------------------------------------------
    // DUT – axi_ram
    //--------------------------------------------------------------------------
    localparam RAM_ADDR_W = 12;

    axi_ram #(
        .DATA_WIDTH (AXI_DATA_W),
        .ADDR_WIDTH (RAM_ADDR_W),
        .STRB_WIDTH (AXI_STRB_W)
    ) dut (
        .clk            (aclk),
        .rst            (~aresetn),
        .s_axi_awid     ('0),
        .s_axi_awaddr   (axi_awaddr[RAM_ADDR_W-1:0]),
        .s_axi_awlen    (axi_awlen),
        .s_axi_awsize   (axi_awsize),
        .s_axi_awburst  (axi_awburst),
        .s_axi_awlock   (axi_awlock),
        .s_axi_awcache  (axi_awcache),
        .s_axi_awprot   (axi_awprot),
        .s_axi_awvalid  (axi_awvalid),
        .s_axi_awready  (axi_awready),
        .s_axi_wdata    (axi_wdata),
        .s_axi_wstrb    (axi_wstrb),
        .s_axi_wlast    (axi_wlast),
        .s_axi_wvalid   (axi_wvalid),
        .s_axi_wready   (axi_wready),
        .s_axi_bid      (),
        .s_axi_bresp    (axi_bresp),
        .s_axi_bvalid   (axi_bvalid),
        .s_axi_bready   (axi_bready),
        .s_axi_arid     (),
        .s_axi_araddr   (axi_araddr[RAM_ADDR_W-1:0]),
        .s_axi_arlen    (axi_arlen),
        .s_axi_arsize   (axi_arsize),
        .s_axi_arburst  (axi_arburst),
        .s_axi_arlock   (axi_arlock),
        .s_axi_arcache  (axi_arcache),
        .s_axi_arprot   (axi_arprot),
        .s_axi_arvalid  (axi_arvalid),
        .s_axi_arready  (axi_arready),
        .s_axi_rid      (),
        .s_axi_rdata    (axi_rdata),
        .s_axi_rresp    (axi_rresp),
        .s_axi_rlast    (axi_rlast),
        .s_axi_rvalid   (axi_rvalid),
        .s_axi_rready   (axi_rready)
    );

    //--------------------------------------------------------------------------
    // UVM kickoff
    //--------------------------------------------------------------------------
    initial begin : uvm_start
        axi_mst_agent_t vip_agent_h;

        // 1. Pass the virtual interface to the monitor
        uvm_config_db #(virtual axi_if)::set(
            null, "uvm_test_top.*", "vif", axi_bus_if);

        // 2. Create and start the Xilinx VIP agent
        vip_agent_h = new("vip_agent_h", axi_mst.inst.IF);
        vip_agent_h.start_master();

        // 3. Pass the VIP agent handle so the UVM driver can call AXI4_WRITE/READ_BURST
        uvm_config_db #(axi_mst_agent_t)::set(
            null, "uvm_test_top.*", "vip_agent", vip_agent_h);

        // 4. Launch the UVM test (name supplied via +UVM_TESTNAME=<test>)
        run_test();
    end

endmodule : tb_uvm


//==============================================================================
// axi_base_test
// Minimal UVM test skeleton – extend this for each test scenario.
//==============================================================================
class axi_base_test extends uvm_test;
    `uvm_component_utils(axi_base_test)

    axi_agent agent;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = axi_agent::type_id::create("agent", this);
        // Agent is active: driver + sequencer + monitor all instantiated
        uvm_config_db #(uvm_active_passive_enum)::set(
            this, "agent", "is_active", UVM_ACTIVE);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        // Wait for reset de-assertion
        @(posedge tb_uvm.aresetn);
        repeat(3) @(posedge tb_uvm.aclk);

        run_sequences();

        phase.drop_objection(this);
    endtask

    // Override in derived tests
    virtual task run_sequences();
    endtask

endclass : axi_base_test


//==============================================================================
// axi_write_read_test
// Example test: write three beats then read them back and verify.
//==============================================================================
class axi_write_read_test extends axi_base_test;
    `uvm_component_utils(axi_write_read_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_sequences();
        axi_write_read_seq seq = axi_write_read_seq::type_id::create("seq");
        seq.addr       = 'h100;
        seq.len        = 2;       // 3 beats
        seq.size       = AXI_SIZE_4B;
        seq.burst      = AXI_BURST_INCR;
        seq.check_data = 1;
        seq.start(agent.sequencer);
    endtask

endclass : axi_write_read_test


//==============================================================================
// axi_rand_test
// Example test: fire num_txns randomised transactions.
//==============================================================================
class axi_rand_test extends axi_base_test;
    `uvm_component_utils(axi_rand_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_sequences();
        axi_rand_seq seq = axi_rand_seq::type_id::create("seq");
        seq.num_txns = 20;
        seq.start(agent.sequencer);
    endtask

endclass : axi_rand_test
