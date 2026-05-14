//==============================================================================
// axi_monitor.sv
//
// UVM monitor for AXI4.
// Observes the AXI signal bus (via a virtual interface), reconstructs
// complete burst transactions, and broadcasts them on two analysis ports:
//
//   ap_write – completed write transactions
//   ap_read  – completed read  transactions
//
// The monitor is purely passive: it never drives any signal.
//==============================================================================

//------------------------------------------------------------------------------
// Virtual interface definition
// Place this in a separate file (axi_if.sv) or in the package header.
//------------------------------------------------------------------------------
interface axi_if #(
    parameter ADDR_W   = 32,
    parameter DATA_W   = 32,
    parameter STRB_W   = DATA_W/8,
    parameter LEN_W    = 8,
    parameter SIZE_W   = 3,
    parameter BURST_W  = 2,
    parameter CACHE_W  = 4,
    parameter PROT_W   = 3,
    parameter REGION_W = 4,
    parameter QOS_W    = 4,
    parameter RESP_W   = 2
) (input logic aclk, input logic aresetn);

    // Write address channel
    logic [ADDR_W-1:0]   awaddr;
    logic [LEN_W-1:0]    awlen;
    logic [SIZE_W-1:0]   awsize;
    logic [BURST_W-1:0]  awburst;
    logic                awlock;
    logic [CACHE_W-1:0]  awcache;
    logic [PROT_W-1:0]   awprot;
    logic [REGION_W-1:0] awregion;
    logic [QOS_W-1:0]    awqos;
    logic                awvalid;
    logic                awready;

    // Write data channel
    logic [DATA_W-1:0]   wdata;
    logic [STRB_W-1:0]   wstrb;
    logic                wlast;
    logic                wvalid;
    logic                wready;

    // Write response channel
    logic [RESP_W-1:0]   bresp;
    logic                bvalid;
    logic                bready;

    // Read address channel
    logic [ADDR_W-1:0]   araddr;
    logic [LEN_W-1:0]    arlen;
    logic [SIZE_W-1:0]   arsize;
    logic [BURST_W-1:0]  arburst;
    logic                arlock;
    logic [CACHE_W-1:0]  arcache;
    logic [PROT_W-1:0]   arprot;
    logic [REGION_W-1:0] arregion;
    logic [QOS_W-1:0]    arqos;
    logic                arvalid;
    logic                arready;

    // Read data channel
    logic [DATA_W-1:0]   rdata;
    logic [RESP_W-1:0]   rresp;
    logic                rlast;
    logic                rvalid;
    logic                rready;

endinterface : axi_if


//==============================================================================
// axi_monitor class
//==============================================================================
class axi_monitor extends uvm_monitor;
    `uvm_component_utils(axi_monitor)

    //--------------------------------------------------------------------------
    // Virtual interface handle – must be set via uvm_config_db before run_phase
    //--------------------------------------------------------------------------
    virtual axi_if #(
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
    ) vif;

    //--------------------------------------------------------------------------
    // Analysis ports
    //--------------------------------------------------------------------------
    uvm_analysis_port #(axi_seq_item) ap_write;
    uvm_analysis_port #(axi_seq_item) ap_read;

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_write = new("ap_write", this);
        ap_read  = new("ap_read",  this);

        if (!uvm_config_db #(virtual axi_if)::get(this, "", "vif", vif))
            `uvm_fatal(`gtn, "Virtual interface 'vif' not found in config_db")
    endfunction

    //--------------------------------------------------------------------------
    // run_phase – fork write and read monitor threads
    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        fork
            monitor_write();
            monitor_read();
        join
    endtask

    //--------------------------------------------------------------------------
    // monitor_write
    // Captures AW beat → collects W beats → captures B beat
    //--------------------------------------------------------------------------
    task monitor_write();
        axi_seq_item item;

        forever begin
            // 1. Wait for AW handshake
            @(posedge vif.aclk);
            if (!vif.aresetn) continue;
            if (!(vif.awvalid && vif.awready)) continue;

            item = axi_seq_item::type_id::create("mon_wr_item");
            item.direction = axi_seq_item::AXI_WRITE;
            item.addr      = vif.awaddr;
            item.len       = vif.awlen;
            item.size      = axi_size_t'(vif.awsize);
            item.burst     = axi_burst_t'(vif.awburst);
            item.lock      = vif.awlock;
            item.cache     = vif.awcache;
            item.prot      = vif.awprot;
            item.region    = vif.awregion;
            item.qos       = vif.awqos;
            item.wdata     = new[item.len + 1];
            item.wstrb     = new[item.len + 1];

            // 2. Collect W beats
            begin
                int beat = 0;
                do begin
                    @(posedge vif.aclk);
                    if (vif.wvalid && vif.wready) begin
                        item.wdata[beat] = vif.wdata;
                        item.wstrb[beat] = vif.wstrb;
                        beat++;
                    end
                end while (!(vif.wvalid && vif.wready && vif.wlast));
            end

            // 3. Collect B beat
            do begin
                @(posedge vif.aclk);
            end while (!(vif.bvalid && vif.bready));
            item.wresp = axi_resp_t'(vif.bresp);

            `uvm_info(`gtn, $sformatf("MON WRITE: %0s", item.convert2string()), UVM_HIGH)
            ap_write.write(item);
        end
    endtask

    //--------------------------------------------------------------------------
    // monitor_read
    // Captures AR beat → collects R beats (with per-beat rresp)
    //--------------------------------------------------------------------------
    task monitor_read();
        axi_seq_item item;

        forever begin
            // 1. Wait for AR handshake
            @(posedge vif.aclk);
            if (!vif.aresetn) continue;
            if (!(vif.arvalid && vif.arready)) continue;

            item = axi_seq_item::type_id::create("mon_rd_item");
            item.direction = axi_seq_item::AXI_READ;
            item.addr      = vif.araddr;
            item.len       = vif.arlen;
            item.size      = axi_size_t'(vif.arsize);
            item.burst     = axi_burst_t'(vif.arburst);
            item.lock      = vif.arlock;
            item.cache     = vif.arcache;
            item.prot      = vif.arprot;
            item.region    = vif.arregion;
            item.qos       = vif.arqos;
            item.rdata     = new[item.len + 1];
            item.rresp     = new[item.len + 1];

            // 2. Collect R beats
            begin
                int beat = 0;
                do begin
                    @(posedge vif.aclk);
                    if (vif.rvalid && vif.rready) begin
                        item.rdata[beat] = vif.rdata;
                        item.rresp[beat] = axi_resp_t'(vif.rresp);
                        beat++;
                    end
                end while (!(vif.rvalid && vif.rready && vif.rlast));
            end

            `uvm_info(`gtn, $sformatf("MON READ: %0s", item.convert2string()), UVM_HIGH)
            ap_read.write(item);
        end
    endtask

endclass : axi_monitor
