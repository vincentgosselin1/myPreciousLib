//==============================================================================
// axi_sequences.sv
//
// Parameterized UVM sequence library.
// All sequences take the same P type parameter as the agent they target.
//
//  axi_base_seq        – virtual base; override body()
//  axi_write_seq       – single directed write burst
//  axi_read_seq        – single directed read  burst
//  axi_write_read_seq  – write + readback with optional data check
//  axi_rand_seq        – num_txns fully-randomised transactions
//==============================================================================

//------------------------------------------------------------------------------
// axi_base_seq
//------------------------------------------------------------------------------
class axi_base_seq #(type P = axi_params)
    extends uvm_sequence #(axi_seq_item #(P));

    typedef axi_base_seq #(P) this_t;
    typedef axi_seq_item #(P) item_t;

    `uvm_object_param_utils(axi_base_seq #(P))

    int unsigned num_txns = 10;

    function new(string name = "axi_base_seq");
        super.new(name);
    endfunction

    // Helper: randomise and send one item, block until driver returns it
    task do_item(item_t item);
        start_item(item);
        if (!item.randomize())
            `uvm_fatal(`gtn, "Randomization failed")
        finish_item(item);
    endtask

    virtual task body();
    endtask

endclass : axi_base_seq


//------------------------------------------------------------------------------
// axi_write_seq
//------------------------------------------------------------------------------
class axi_write_seq #(type P = axi_params) extends axi_base_seq #(P);

    typedef axi_write_seq #(P) this_t;
    typedef axi_seq_item  #(P) item_t;

    `uvm_object_param_utils(axi_write_seq #(P))

    // Knobs – set before start()
    rand logic [P::ADDR_W-1:0]  addr  = '0;
    rand logic [P::LEN_W-1:0]   len   = 0;
    rand logic [P::ID_W-1:0]    id    = '0;
    rand P::axi_size_t           size  = P::AXI_SIZE_4B;
    rand P::axi_burst_t          burst = P::AXI_BURST_INCR;
    // Optional: provide wdata[], leave null for randomised data
    logic [P::DATA_W-1:0]       data [];

    // Output
    P::axi_resp_t wresp;

    function new(string name = "axi_write_seq");
        super.new(name);
    endfunction

    virtual task body();
        item_t item = item_t::type_id::create("wr_item");
        start_item(item);

        if (!item.randomize() with {
                direction == P::AXI_WRITE;
                item.addr  == local::addr;
                item.len   == local::len;
                item.id    == local::id;
                item.size  == local::size;
                item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Randomization failed")

        // Override wdata if caller supplied it
        if (data != null && data.size() == (len + 1))
            foreach (data[i]) item.wdata[i] = data[i];

        finish_item(item);
        wresp = item.wresp;
        `uvm_info(`gtn, $sformatf("WRITE SEQ DONE wresp=%0s", wresp.name()), UVM_MEDIUM)
    endtask

endclass : axi_write_seq


//------------------------------------------------------------------------------
// axi_read_seq
//------------------------------------------------------------------------------
class axi_read_seq #(type P = axi_params) extends axi_base_seq #(P);

    typedef axi_read_seq  #(P) this_t;
    typedef axi_seq_item  #(P) item_t;

    `uvm_object_param_utils(axi_read_seq #(P))

    rand logic [P::ADDR_W-1:0]  addr  = '0;
    rand logic [P::LEN_W-1:0]   len   = 0;
    rand logic [P::ID_W-1:0]    id    = '0;
    rand P::axi_size_t           size  = P::AXI_SIZE_4B;
    rand P::axi_burst_t          burst = P::AXI_BURST_INCR;

    // Outputs
    logic [P::DATA_W-1:0]  rdata [];
    P::axi_resp_t           rresp [];

    function new(string name = "axi_read_seq");
        super.new(name);
    endfunction

    virtual task body();
        item_t item = item_t::type_id::create("rd_item");
        start_item(item);

        if (!item.randomize() with {
                direction == P::AXI_READ;
                item.addr  == local::addr;
                item.len   == local::len;
                item.id    == local::id;
                item.size  == local::size;
                item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Randomization failed")

        finish_item(item);
        rdata = item.rdata;
        rresp = item.rresp;
        `uvm_info(`gtn, $sformatf("READ SEQ DONE %0s", item.convert2string()), UVM_MEDIUM)
    endtask

endclass : axi_read_seq


//------------------------------------------------------------------------------
// axi_write_read_seq
//------------------------------------------------------------------------------
class axi_write_read_seq #(type P = axi_params) extends axi_base_seq #(P);

    typedef axi_write_read_seq #(P) this_t;
    typedef axi_seq_item       #(P) item_t;

    `uvm_object_param_utils(axi_write_read_seq #(P))

    rand logic [P::ADDR_W-1:0]  addr       = '0;
    rand logic [P::LEN_W-1:0]   len        = 0;
    rand logic [P::ID_W-1:0]    id         = '0;
    rand P::axi_size_t           size       = P::AXI_SIZE_4B;
    rand P::axi_burst_t          burst      = P::AXI_BURST_INCR;
    bit                          check_data = 1;

    // Outputs
    P::axi_resp_t           wresp;
    logic [P::DATA_W-1:0]  rdata [];
    P::axi_resp_t           rresp [];

    function new(string name = "axi_write_read_seq");
        super.new(name);
    endfunction

    virtual task body();
        item_t wr_item = item_t::type_id::create("wr_item");
        item_t rd_item = item_t::type_id::create("rd_item");

        // ── Write ──────────────────────────────────────────────────────────
        start_item(wr_item);
        if (!wr_item.randomize() with {
                direction == P::AXI_WRITE;
                wr_item.addr  == local::addr;
                wr_item.len   == local::len;
                wr_item.id    == local::id;
                wr_item.size  == local::size;
                wr_item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Write randomization failed")
        finish_item(wr_item);
        wresp = wr_item.wresp;

        // ── Read-back ──────────────────────────────────────────────────────
        start_item(rd_item);
        if (!rd_item.randomize() with {
                direction == P::AXI_READ;
                rd_item.addr  == local::addr;
                rd_item.len   == local::len;
                rd_item.id    == local::id;
                rd_item.size  == local::size;
                rd_item.burst == local::burst;
            })
            `uvm_fatal(`gtn, "Read randomization failed")
        finish_item(rd_item);
        rdata = rd_item.rdata;
        rresp = rd_item.rresp;

        // ── Optional integrity check ───────────────────────────────────────
        if (check_data) begin
            foreach (wr_item.wdata[i]) begin
                if (rd_item.rdata[i] !== wr_item.wdata[i])
                    `uvm_error(`gtn, $sformatf(
                        "Mismatch beat %0d: wrote 0x%0h read 0x%0h",
                        i, wr_item.wdata[i], rd_item.rdata[i]))
                else
                    `uvm_info(`gtn, $sformatf(
                        "Beat %0d OK 0x%0h", i, rd_item.rdata[i]), UVM_HIGH)
            end
        end
    endtask

endclass : axi_write_read_seq


//------------------------------------------------------------------------------
// axi_rand_seq
//------------------------------------------------------------------------------
class axi_rand_seq #(type P = axi_params) extends axi_base_seq #(P);

    typedef axi_rand_seq  #(P) this_t;
    typedef axi_seq_item  #(P) item_t;

    `uvm_object_param_utils(axi_rand_seq #(P))

    function new(string name = "axi_rand_seq");
        super.new(name);
    endfunction

    virtual task body();
        item_t item;
        repeat (num_txns) begin
            item = item_t::type_id::create("rand_item");
            do_item(item);
        end
    endtask

endclass : axi_rand_seq
