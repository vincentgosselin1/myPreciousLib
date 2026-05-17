//==============================================================================
// axi_agent.sv
//
// Parameterized UVM agent.
// Bundles sequencer, driver, and monitor for one AXI bus.
// Multiple specialisations can coexist in the same environment:
//
//   axi_agent #(axi32_p)  hp_agent;   // 32-bit AXI
//   axi_agent #(axi64_p)  ddr_agent;  // 64-bit AXI
//==============================================================================

class axi_agent #(type P = axi_params) extends uvm_agent;

    typedef axi_agent    #(P)  this_t;
    typedef axi_seq_item #(P)  item_t;
    typedef axi_driver   #(P)  driver_t;
    typedef axi_monitor  #(P)  monitor_t;
    typedef axi_vip_master_mst_t vip_agent_t;

    `uvm_component_param_utils(axi_agent #(P))

    //--------------------------------------------------------------------------
    // Sub-components
    //--------------------------------------------------------------------------
    uvm_sequencer #(item_t) sequencer;
    driver_t                driver;
    monitor_t               monitor;

    //--------------------------------------------------------------------------
    // Analysis ports (forwarded from monitor for external subscribers)
    //--------------------------------------------------------------------------
    uvm_analysis_port #(item_t) ap_write;
    uvm_analysis_port #(item_t) ap_read;

    //--------------------------------------------------------------------------
    // VIP handle – assign directly OR set via config_db before build_phase:
    //   uvm_config_db #(axi_vip_master_mst_t)::set(null,
    //       "uvm_test_top.env.axi_agent", "vip_agent", h);
    //--------------------------------------------------------------------------
    vip_agent_t vip_agent;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    //--------------------------------------------------------------------------
    // build_phase
    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap_write = new("ap_write", this);
        ap_read  = new("ap_read",  this);

        monitor  = monitor_t::type_id::create("monitor", this);

        if (get_is_active() == UVM_ACTIVE) begin
            sequencer = uvm_sequencer #(item_t)::type_id::create("sequencer", this);
            driver    = driver_t::type_id::create("driver", this);
        end
    endfunction

    //--------------------------------------------------------------------------
    // connect_phase
    //--------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        monitor.ap_write.connect(ap_write);
        monitor.ap_read .connect(ap_read);

        if (get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);

            // Resolve VIP handle: direct assignment wins, else config_db
            if (vip_agent == null) begin
                if (!uvm_config_db #(vip_agent_t)::get(
                        this, "", "vip_agent", vip_agent))
                    `uvm_fatal(`gtn,
                        "vip_agent not found: set agent.vip_agent or use config_db")
            end
            driver.vip_agent = vip_agent;
        end
    endfunction

endclass : axi_agent
