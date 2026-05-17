//==============================================================================
// axi_driver.sv
//
// Parameterized UVM driver.
// Delegates bus cycles to a Xilinx AXI VIP master agent handle that is
// injected by the enclosing agent at connect_phase.
//==============================================================================

class axi_driver #(type P = axi_params) extends uvm_driver #(axi_seq_item #(P));

    typedef axi_driver  #(P)          this_t;
    typedef axi_seq_item #(P)         item_t;
    typedef axi_vip_master_mst_t      vip_agent_t; // Xilinx VIP type

    `uvm_component_param_utils(axi_driver #(P))

    //--------------------------------------------------------------------------
    // VIP agent handle – set by the enclosing axi_agent at connect_phase
    //--------------------------------------------------------------------------
    vip_agent_t vip_agent;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        item_t item;
        if (vip_agent == null)
            `uvm_fatal(`gtn, "vip_agent not set before run_phase")
        forever begin
            seq_item_port.get_next_item(item);
            drive_item(item);
            seq_item_port.item_done();
        end
    endtask

    //--------------------------------------------------------------------------
    // Dispatch
    //--------------------------------------------------------------------------
    task drive_item(item_t item);
        case (item.direction)
            P::AXI_WRITE : drive_write(item);
            P::AXI_READ  : drive_read (item);
            default: `uvm_error(`gtn, "Unknown direction")
        endcase
    endtask

    //--------------------------------------------------------------------------
    // Write
    //--------------------------------------------------------------------------
    task drive_write(item_t item);
        // Flat packed array expected by the Xilinx VIP
        logic [P::VIP_DATA_DEPTH-1:0][P::DATA_W-1:0] wdata_flat;
        axi_vip_pkg::xil_axi_resp_t wresp_raw;

        `uvm_info(`gtn, $sformatf("DRIVE WRITE %0s", item.convert2string()), UVM_HIGH)

        for (int i = 0; i <= item.len; i++)
            wdata_flat[i] = item.wdata[i];

        vip_agent.AXI4_WRITE_BURST(
            .id     (axi_vip_pkg::xil_axi_id_t'(item.id)),
            .addr   (axi_vip_pkg::xil_axi_ulong'(item.addr)),
            .len    (axi_vip_pkg::xil_axi_len_t'(item.len)),
            .size   (axi_vip_pkg::xil_axi_size_t'(item.size)),
            .burst  (axi_vip_pkg::xil_axi_burst_t'(item.burst)),
            .lock   (axi_vip_pkg::xil_axi_lock_t'(item.lock)),
            .cache  (item.cache),
            .prot   (item.prot),
            .region (item.region),
            .qos    (item.qos),
            .awuser (item.awuser),
            .data   (wdata_flat),
            .wuser  ('0),
            .resp   (wresp_raw)
        );

        item.wresp = P::axi_resp_t'(wresp_raw);
        `uvm_info(`gtn, $sformatf("WRITE DONE wresp=%0s", item.wresp.name()), UVM_MEDIUM)
    endtask

    //--------------------------------------------------------------------------
    // Read
    //--------------------------------------------------------------------------
    task drive_read(item_t item);
        bit  [P::VIP_DATA_DEPTH-1:0][P::DATA_W-1:0]    rdata_flat;
        axi_vip_pkg::xil_axi_resp_t [255:0]             rresp_flat;
        axi_vip_pkg::xil_axi_data_beat [255:0]          ruser_flat;

        `uvm_info(`gtn, $sformatf("DRIVE READ %0s", item.convert2string()), UVM_HIGH)

        vip_agent.AXI4_READ_BURST(
            .id     (axi_vip_pkg::xil_axi_id_t'(item.id)),
            .addr   (axi_vip_pkg::xil_axi_ulong'(item.addr)),
            .len    (axi_vip_pkg::xil_axi_len_t'(item.len)),
            .size   (axi_vip_pkg::xil_axi_size_t'(item.size)),
            .burst  (axi_vip_pkg::xil_axi_burst_t'(item.burst)),
            .lock   (axi_vip_pkg::xil_axi_lock_t'(item.lock)),
            .cache  (item.cache),
            .prot   (item.prot),
            .region (item.region),
            .qos    (item.qos),
            .aruser (item.aruser),
            .data   (rdata_flat),
            .resp   (rresp_flat),
            .ruser  (ruser_flat)
        );

        item.rdata = new[item.len + 1];
        item.rresp = new[item.len + 1];
        for (int i = 0; i <= item.len; i++) begin
            item.rdata[i] = rdata_flat[i];
            item.rresp[i] = P::axi_resp_t'(rresp_flat[i]);
        end

        `uvm_info(`gtn, $sformatf("READ DONE %0s", item.convert2string()), UVM_MEDIUM)
    endtask

endclass : axi_driver
