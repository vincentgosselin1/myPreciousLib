//==============================================================================
// axi_monitor.sv
//
// Parameterized UVM monitor.
// Observes axi_if, reconstructs complete burst transactions, and broadcasts
// them on ap_write / ap_read analysis ports.
//==============================================================================

class axi_monitor #(type P = axi_params) extends uvm_monitor;

    typedef axi_monitor  #(P)  this_t;
    typedef axi_seq_item #(P)  item_t;

    `uvm_component_param_utils(axi_monitor #(P))

    //--------------------------------------------------------------------------
    // Virtual interface handle
    // Set via uvm_config_db #(P::vif_t) before run_phase.
    //--------------------------------------------------------------------------
    P::vif_t vif;

    //--------------------------------------------------------------------------
    // Analysis ports
    //--------------------------------------------------------------------------
    uvm_analysis_port #(item_t) ap_write;
    uvm_analysis_port #(item_t) ap_read;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_write = new("ap_write", this);
        ap_read  = new("ap_read",  this);

        if (!uvm_config_db #(P::vif_t)::get(this, "", "vif", vif))
            `uvm_fatal(`gtn, "Virtual interface 'vif' not found in config_db")
    endfunction

    //--------------------------------------------------------------------------
    // run_phase – fork write and read threads
    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        fork
            monitor_write();
            monitor_read();
        join
    endtask

    //--------------------------------------------------------------------------
    // monitor_write : AW → W beats → B
    //--------------------------------------------------------------------------
    task monitor_write();
        item_t item;
        forever begin
            // Wait for AW handshake
            @(posedge vif.aclk);
            if (!vif.aresetn) continue;
            if (!(vif.awvalid && vif.awready)) continue;

            item = item_t::type_id::create("mon_wr");
            item.direction = P::AXI_WRITE;
            item.id        = vif.awid;
            item.addr      = vif.awaddr;
            item.len       = vif.awlen;
            item.size      = P::axi_size_t'(vif.awsize);
            item.burst     = P::axi_burst_t'(vif.awburst);
            item.lock      = vif.awlock;
            item.cache     = vif.awcache;
            item.prot      = vif.awprot;
            item.region    = vif.awregion;
            item.qos       = vif.awqos;
            item.awuser    = vif.awuser;
            item.wdata     = new[item.len + 1];
            item.wstrb     = new[item.len + 1];
            item.wuser     = new[item.len + 1];

            // Collect W beats
            begin : collect_w
                int beat = 0;
                do begin
                    @(posedge vif.aclk);
                    if (vif.wvalid && vif.wready) begin
                        item.wdata[beat] = vif.wdata;
                        item.wstrb[beat] = vif.wstrb;
                        item.wuser[beat] = vif.wuser;
                        beat++;
                    end
                end while (!(vif.wvalid && vif.wready && vif.wlast));
            end

            // Collect B beat
            do @(posedge vif.aclk);
            while (!(vif.bvalid && vif.bready));
            item.wresp = P::axi_resp_t'(vif.bresp);
            item.buser = vif.buser;

            `uvm_info(`gtn, $sformatf("MON WRITE %0s", item.convert2string()), UVM_HIGH)
            ap_write.write(item);
        end
    endtask

    //--------------------------------------------------------------------------
    // monitor_read : AR → R beats
    //--------------------------------------------------------------------------
    task monitor_read();
        item_t item;
        forever begin
            // Wait for AR handshake
            @(posedge vif.aclk);
            if (!vif.aresetn) continue;
            if (!(vif.arvalid && vif.arready)) continue;

            item = item_t::type_id::create("mon_rd");
            item.direction = P::AXI_READ;
            item.id        = vif.arid;
            item.addr      = vif.araddr;
            item.len       = vif.arlen;
            item.size      = P::axi_size_t'(vif.arsize);
            item.burst     = P::axi_burst_t'(vif.arburst);
            item.lock      = vif.arlock;
            item.cache     = vif.arcache;
            item.prot      = vif.arprot;
            item.region    = vif.arregion;
            item.qos       = vif.arqos;
            item.aruser    = vif.aruser;
            item.rdata     = new[item.len + 1];
            item.rresp     = new[item.len + 1];
            item.ruser     = new[item.len + 1];

            // Collect R beats
            begin : collect_r
                int beat = 0;
                do begin
                    @(posedge vif.aclk);
                    if (vif.rvalid && vif.rready) begin
                        item.rdata[beat] = vif.rdata;
                        item.rresp[beat] = P::axi_resp_t'(vif.rresp);
                        item.ruser[beat] = vif.ruser;
                        beat++;
                    end
                end while (!(vif.rvalid && vif.rready && vif.rlast));
            end

            `uvm_info(`gtn, $sformatf("MON READ %0s", item.convert2string()), UVM_HIGH)
            ap_read.write(item);
        end
    endtask

endclass : axi_monitor
