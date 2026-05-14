//==============================================================================
// axi_driver.sv
//
// UVM driver for AXI4.
// Receives axi_seq_item objects from the sequencer and delegates the actual
// bus-cycle generation to the Xilinx AXI VIP master agent that is already
// instantiated in the testbench.  The driver therefore acts as a thin
// adapter between the UVM sequence layer and the VIP API.
//==============================================================================

class axi_driver extends uvm_driver #(axi_seq_item);
    `uvm_component_utils(axi_driver)

    //--------------------------------------------------------------------------
    // Handle to the Xilinx VIP master agent
    // Set by the enclosing agent after construction.
    //--------------------------------------------------------------------------
    axi_mst_agent_t vip_agent;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    //--------------------------------------------------------------------------
    // run_phase – main loop
    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        axi_seq_item item;

        // Wait until the VIP handle has been set
        if (vip_agent == null)
            `uvm_fatal(`gtn, "vip_agent handle not set before run_phase")

        forever begin
            seq_item_port.get_next_item(item);
            drive_item(item);
            seq_item_port.item_done();
        end
    endtask

    //--------------------------------------------------------------------------
    // drive_item – dispatch to write or read path
    //--------------------------------------------------------------------------
    task drive_item(axi_seq_item item);
        case (item.direction)
            axi_seq_item::AXI_WRITE : drive_write(item);
            axi_seq_item::AXI_READ  : drive_read (item);
            default: `uvm_error(`gtn, "Unknown direction in axi_seq_item")
        endcase
    endtask

    //--------------------------------------------------------------------------
    // drive_write
    //--------------------------------------------------------------------------
    task drive_write(axi_seq_item item);
        // Xilinx VIP uses a flat packed array of 4096 bytes
        logic [(4096/(AXI_DATA_W/8))-1:0][AXI_DATA_W-1:0] wdata_flat;
        axi_vip_pkg::xil_axi_resp_t wresp_raw;

        `uvm_info(`gtn, $sformatf("WRITE %0s", item.convert2string()), UVM_HIGH)

        // Pack dynamic array into flat VIP array
        for (int i = 0; i <= item.len; i++)
            wdata_flat[i] = item.wdata[i];

        vip_agent.AXI4_WRITE_BURST(
            .id     ('0),
            .addr   (axi_vip_pkg::xil_axi_ulong'(item.addr)),
            .len    (axi_vip_pkg::xil_axi_len_t'(item.len)),
            .size   (axi_vip_pkg::xil_axi_size_t'(item.size)),
            .burst  (axi_vip_pkg::xil_axi_burst_t'(item.burst)),
            .lock   (axi_vip_pkg::xil_axi_lock_t'(item.lock)),
            .cache  (item.cache),
            .prot   (item.prot),
            .region (item.region),
            .qos    (item.qos),
            .awuser ('0),
            .data   (wdata_flat),
            .wuser  ('0),
            .resp   (wresp_raw)
        );

        item.wresp = axi_resp_t'(wresp_raw);

        `uvm_info(`gtn, $sformatf("WRITE DONE wresp=%0s", item.wresp.name()), UVM_MEDIUM)
    endtask

    //--------------------------------------------------------------------------
    // drive_read
    //--------------------------------------------------------------------------
    task drive_read(axi_seq_item item);
        bit  [4096/(AXI_DATA_W/8)-1:0][AXI_DATA_W-1:0]    rdata_flat;
        axi_vip_pkg::xil_axi_resp_t [255:0]                rresp_flat;
        axi_vip_pkg::xil_axi_data_beat [255:0]             ruser_flat;

        `uvm_info(`gtn, $sformatf("READ %0s", item.convert2string()), UVM_HIGH)

        vip_agent.AXI4_READ_BURST(
            .id     ('0),
            .addr   (axi_vip_pkg::xil_axi_ulong'(item.addr)),
            .len    (axi_vip_pkg::xil_axi_len_t'(item.len)),
            .size   (axi_vip_pkg::xil_axi_size_t'(item.size)),
            .burst  (axi_vip_pkg::xil_axi_burst_t'(item.burst)),
            .lock   (axi_vip_pkg::xil_axi_lock_t'(item.lock)),
            .cache  (item.cache),
            .prot   (item.prot),
            .region (item.region),
            .qos    (item.qos),
            .aruser ('0),
            .data   (rdata_flat),
            .resp   (rresp_flat),
            .ruser  (ruser_flat)
        );

        // Unpack flat arrays back to dynamic arrays on the item
        item.rdata = new[item.len + 1];
        item.rresp = new[item.len + 1];
        for (int i = 0; i <= item.len; i++) begin
            item.rdata[i] = rdata_flat[i];
            item.rresp[i] = axi_resp_t'(rresp_flat[i]);
        end

        `uvm_info(`gtn, $sformatf("READ DONE %0s", item.convert2string()), UVM_MEDIUM)
    endtask

endclass : axi_driver
