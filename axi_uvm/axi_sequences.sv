//==============================================================================
// axi_sequences.sv
//
// UVM sequence library for AXI4.
//
//  axi_base_seq      – base class; override body() for custom sequences
//  axi_write_seq     – single write burst with configurable parameters
//  axi_read_seq      – single read  burst with configurable parameters
//  axi_write_read_seq – write followed by readback and optional data check
//  axi_rand_seq      – randomised mix of writes and reads
//==============================================================================

//------------------------------------------------------------------------------
// axi_base_seq
//------------------------------------------------------------------------------
class axi_base_seq extends uvm_sequence #(axi_seq_item);
    `uvm_object_utils(axi_base_seq)

    // Number of transactions to generate (used by axi_rand_seq)
    int unsigned num_txns = 10;

    function new(string name = "axi_base_seq");
        super.new(name);
    endfunction

    // Convenience: send one item and block until the driver returns it
    task do_item(axi_seq_item item);
        start_item(item);
        if (!item.randomize())
            `uvm_fatal(`gtn, "Randomization failed")
        finish_item(item);
        // item is now populated with response fields by the driver
    endtask

    virtual task body();
        // Override in derived classes
    endtask

endclass : axi_base_seq


//------------------------------------------------------------------------------
// axi_write_seq
// Performs a single AXI write burst.
// All fields can be set before start() or constrained via pre_randomize.
//------------------------------------------------------------------------------
class axi_write_seq extends axi_base_seq;
    `uvm_object_utils(axi_write_seq)

    // Configurable fields – set before calling start()
    rand logic [AXI_ADDR_W-1:0]   addr  = '0;
    rand logic [AXI_LEN_W-1:0]    len   = 0;    // beats - 1
    rand axi_size_t                size  = AXI_SIZE_4B;
    rand axi_burst_t               burst = AXI_BURST_INCR;
    rand logic [AXI_DATA_W-1:0]    data  [];     // if null → randomised per beat

    // Response output
    axi_resp_t wresp;

    function new(string name = "axi_write_seq");
        super.new(name);
    endfunction

    task body();
        axi_seq_item item = axi_seq_item::type_id::create("wr_item");

        // Constrain the item to match sequence-level knobs
        item.direction = axi_seq_item::AXI_WRITE;

        start_item(item);

        // Allow data override or randomisation
        if (data != null && data.size() == (len + 1)) begin
            if (!item.randomize() with {
                    direction == axi_seq_item::AXI_WRITE;
                    item.addr  == local::addr;
                    item.len   == local::len;
                    item.size  == local::size;
                    item.burst == local::burst;
                })
                `uvm_fatal(`gtn, "Randomization failed")
            foreach (data[i]) item.wdata[i] = data[i];
        end else begin
            if (!item.randomize() with {
                    direction == axi_seq_item::AXI_WRITE;
                    item.addr  == local::addr;
                    item.len   == local::len;
                    item.size  == local::size;
                    item.burst == local::burst;
                })
                `uvm_fatal(`gtn, "Randomization failed")
        end

        finish_item(item);

        wresp = item.wresp;
        `uvm_info(`gtn, $sformatf("WRITE SEQ DONE: wresp=%0s", wresp.name()), UVM_MEDIUM)
    endtask

endclass : axi_write_seq


//------------------------------------------------------------------------------
// axi_read_seq
// Performs a single AXI read burst.
//------------------------------------------------------------------------------
class axi_read_seq extends axi_base_seq;
    `uvm_object_utils(axi_read_seq)

    // Configurable fields
    rand logic [AXI_ADDR_W-1:0]   addr  = '0;
    rand logic [AXI_LEN_W-1:0]    len   = 0;
    rand axi_size_t                size  = AXI_SIZE_4B;
    rand axi_burst_t               burst = AXI_BURST_INCR;

    // Response output
    logic [AXI_DATA_W-1:0] rdata [];
    axi_resp_t              rresp [];

    function new(string name = "axi_read_seq");
        super.new(name);
    endfunction

    task body();
        axi_seq_item item = axi_seq_item::type_id::create("rd_item");

        start_item(item);
        if (!item.randomize() with {
                direction == axi_seq_item::AXI_READ;
                item.addr  == local::addr;
                item.len   == local::len;
                item.size  == local::size;
                item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Randomization failed")
        finish_item(item);

        rdata = item.rdata;
        rresp = item.rresp;
        `uvm_info(`gtn, $sformatf("READ SEQ DONE: %0s", item.convert2string()), UVM_MEDIUM)
    endtask

endclass : axi_read_seq


//------------------------------------------------------------------------------
// axi_write_read_seq
// Writes a burst then reads it back, optionally checking that the data
// matches.  Useful as a quick sanity test for any AXI slave.
//------------------------------------------------------------------------------
class axi_write_read_seq extends axi_base_seq;
    `uvm_object_utils(axi_write_read_seq)

    // Configurable fields
    rand logic [AXI_ADDR_W-1:0]  addr          = '0;
    rand logic [AXI_LEN_W-1:0]   len           = 0;
    rand axi_size_t               size          = AXI_SIZE_4B;
    rand axi_burst_t              burst         = AXI_BURST_INCR;
    bit                           check_data    = 1; // enable readback check

    // Outputs
    axi_resp_t              wresp;
    logic [AXI_DATA_W-1:0]  rdata [];
    axi_resp_t              rresp [];

    function new(string name = "axi_write_read_seq");
        super.new(name);
    endfunction

    task body();
        axi_seq_item wr_item, rd_item;
        wr_item = axi_seq_item::type_id::create("wr_item");
        rd_item = axi_seq_item::type_id::create("rd_item");

        //----------------------------------------------------------------------
        // Write phase
        //----------------------------------------------------------------------
        start_item(wr_item);
        if (!wr_item.randomize() with {
                direction == axi_seq_item::AXI_WRITE;
                wr_item.addr  == local::addr;
                wr_item.len   == local::len;
                wr_item.size  == local::size;
                wr_item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Write randomization failed")
        finish_item(wr_item);
        wresp = wr_item.wresp;

        //----------------------------------------------------------------------
        // Read-back phase
        //----------------------------------------------------------------------
        start_item(rd_item);
        if (!rd_item.randomize() with {
                direction == axi_seq_item::AXI_READ;
                rd_item.addr  == local::addr;
                rd_item.len   == local::len;
                rd_item.size  == local::size;
                rd_item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Read randomization failed")
        finish_item(rd_item);
        rdata = rd_item.rdata;
        rresp = rd_item.rresp;

        //----------------------------------------------------------------------
        // Optional data integrity check
        //----------------------------------------------------------------------
        if (check_data) begin
            foreach (wr_item.wdata[i]) begin
                if (rd_item.rdata[i] !== wr_item.wdata[i]) begin
                    `uvm_error(`gtn, $sformatf(
                        "Data mismatch at beat %0d: wrote 0x%0h, read 0x%0h",
                        i, wr_item.wdata[i], rd_item.rdata[i]))
                end else begin
                    `uvm_info(`gtn, $sformatf(
                        "Beat %0d OK: 0x%0h", i, rd_item.rdata[i]), UVM_HIGH)
                end
            end
        end
    endtask

endclass : axi_write_read_seq


//------------------------------------------------------------------------------
// axi_rand_seq
// Fires num_txns fully randomised write or read transactions.
//------------------------------------------------------------------------------
class axi_rand_seq extends axi_base_seq;
    `uvm_object_utils(axi_rand_seq)

    function new(string name = "axi_rand_seq");
        super.new(name);
    endfunction

    task body();
        axi_seq_item item;
        repeat (num_txns) begin
            item = axi_seq_item::type_id::create("rand_item");
            do_item(item);
        end
    endtask

endclass : axi_rand_seq
