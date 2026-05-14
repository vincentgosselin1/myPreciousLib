//==============================================================================
// axi_agent.sv
//
// UVM agent for AXI4.
// Bundles the sequencer, driver, and monitor.  When configured as PASSIVE
// (UVM_PASSIVE) only the monitor is created; the driver and sequencer are
// omitted so the agent can be used on the slave side or for snooping.
//==============================================================================

class axi_agent extends uvm_agent;
    `uvm_component_utils(axi_agent)

    //--------------------------------------------------------------------------
    // Sub-components
    //--------------------------------------------------------------------------
    uvm_sequencer #(axi_seq_item) sequencer;
    axi_driver                    driver;
    axi_monitor                   monitor;

    //--------------------------------------------------------------------------
    // Analysis ports – forwarded from the monitor for external subscribers
    // (scoreboards, coverage collectors, etc.)
    //--------------------------------------------------------------------------
    uvm_analysis_port #(axi_seq_item) ap_write;
    uvm_analysis_port #(axi_seq_item) ap_read;

    //--------------------------------------------------------------------------
    // Configuration knob: handle to the Xilinx VIP master agent.
    // Must be set in the testbench before run_phase when is_active == UVM_ACTIVE.
    // Alternatively set via uvm_config_db #(axi_mst_agent_t).
    //--------------------------------------------------------------------------
    axi_mst_agent_t vip_agent;

    //--------------------------------------------------------------------------
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    //--------------------------------------------------------------------------
    // build_phase
    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Analysis ports are always created
        ap_write = new("ap_write", this);
        ap_read  = new("ap_read",  this);

        // Monitor is always created (active and passive agents observe)
        monitor = axi_monitor::type_id::create("monitor", this);

        if (get_is_active() == UVM_ACTIVE) begin
            sequencer = uvm_sequencer #(axi_seq_item)::type_id::create(
                            "sequencer", this);
            driver    = axi_driver::type_id::create("driver", this);
        end
    endfunction

    //--------------------------------------------------------------------------
    // connect_phase
    //--------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        // Forward monitor analysis ports upward
        monitor.ap_write.connect(ap_write);
        monitor.ap_read .connect(ap_read);

        if (get_is_active() == UVM_ACTIVE) begin
            // Wire sequencer → driver
            driver.seq_item_port.connect(sequencer.seq_item_export);

            // Pass VIP agent handle to the driver
            // (can also be set via config_db before build_phase completes)
            if (vip_agent == null) begin
                if (!uvm_config_db #(axi_mst_agent_t)::get(
                        this, "", "vip_agent", vip_agent))
                    `uvm_fatal(`gtn,
                        "vip_agent not set: assign agent.vip_agent or use config_db")
            end
            driver.vip_agent = vip_agent;
        end
    endfunction

endclass : axi_agent
