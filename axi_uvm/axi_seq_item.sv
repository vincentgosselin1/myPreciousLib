//==============================================================================
// axi_seq_item.sv
//
// Parameterized UVM sequence item.
// P must be a specialisation of axi_params.
//
// Example
// ───────
//   typedef axi_params #(.ADDR_W(32),.DATA_W(64)) cfg64_t;
//   axi_seq_item #(cfg64_t) item;
//==============================================================================

class axi_seq_item #(type P = axi_params) extends uvm_sequence_item;

    // Shorten type name for factory registration.
    // Each specialisation gets its own factory entry.
    typedef axi_seq_item #(P) this_t;
    `uvm_object_param_utils(axi_seq_item #(P))

    //--------------------------------------------------------------------------
    // Convenience aliases into P
    //--------------------------------------------------------------------------
    typedef P::axi_dir_t   axi_dir_t;
    typedef P::axi_burst_t axi_burst_t;
    typedef P::axi_resp_t  axi_resp_t;
    typedef P::axi_size_t  axi_size_t;

    //--------------------------------------------------------------------------
    // Request fields
    //--------------------------------------------------------------------------
    rand axi_dir_t  direction;

    rand logic [P::ADDR_W-1:0]   addr;
    rand logic [P::ID_W-1:0]     id;
    rand logic [P::LEN_W-1:0]    len;      // beats - 1 (AXI encoding)
    rand axi_size_t               size;
    rand axi_burst_t              burst;
    rand logic                    lock;
    rand logic [P::CACHE_W-1:0]  cache;
    rand logic [P::PROT_W-1:0]   prot;
    rand logic [P::REGION_W-1:0] region;
    rand logic [P::QOS_W-1:0]    qos;
    rand logic [P::USER_W-1:0]   awuser;
    rand logic [P::USER_W-1:0]   aruser;

    rand logic [P::DATA_W-1:0]   wdata [];
    rand logic [P::STRB_W-1:0]   wstrb [];
    rand logic [P::USER_W-1:0]   wuser [];

    //--------------------------------------------------------------------------
    // Response fields (populated by driver)
    //--------------------------------------------------------------------------
    logic [P::DATA_W-1:0]   rdata [];
    axi_resp_t               wresp;
    axi_resp_t               rresp [];
    logic [P::USER_W-1:0]   ruser [];
    logic [P::USER_W-1:0]   buser;

    //--------------------------------------------------------------------------
    // Constraints
    //--------------------------------------------------------------------------
    constraint c_len_range {
        len inside {[0:15]};                // keep random bursts short
    }

    constraint c_arrays_match_len {
        wdata.size() == len + 1;
        wstrb.size() == len + 1;
        wuser.size() == len + 1;
    }

    constraint c_burst_legal {
        burst inside {P::AXI_BURST_INCR, P::AXI_BURST_WRAP};
    }

    // Transfer must not cross a 4 KB page
    constraint c_4kb_boundary {
        (addr & ~({P::ADDR_W{1'b1}} << 12)) + ((len + 1) << size) <= 4096;
    }

    constraint c_full_strobe {
        foreach (wstrb[i]) wstrb[i] == {P::STRB_W{1'b1}};
    }

    // Size cannot exceed bus width
    constraint c_size_max {
        (1 << size) <= P::STRB_W;
    }

    //--------------------------------------------------------------------------
    // UVM standard methods
    //--------------------------------------------------------------------------
    function new(string name = "axi_seq_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        this_t rhs_;
        if (!$cast(rhs_, rhs))
            `uvm_fatal(`gtn, "Cast failed in do_copy")
        super.do_copy(rhs);
        direction = rhs_.direction;
        addr      = rhs_.addr;
        id        = rhs_.id;
        len       = rhs_.len;
        size      = rhs_.size;
        burst     = rhs_.burst;
        lock      = rhs_.lock;
        cache     = rhs_.cache;
        prot      = rhs_.prot;
        region    = rhs_.region;
        qos       = rhs_.qos;
        awuser    = rhs_.awuser;
        aruser    = rhs_.aruser;
        wdata     = rhs_.wdata;
        wstrb     = rhs_.wstrb;
        wuser     = rhs_.wuser;
        rdata     = rhs_.rdata;
        wresp     = rhs_.wresp;
        rresp     = rhs_.rresp;
        ruser     = rhs_.ruser;
        buser     = rhs_.buser;
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        this_t rhs_;
        if (!$cast(rhs_, rhs)) return 0;
        return super.do_compare(rhs, comparer)
            && (direction === rhs_.direction)
            && (addr      === rhs_.addr)
            && (id        === rhs_.id)
            && (len       === rhs_.len)
            && (size      === rhs_.size)
            && (burst     === rhs_.burst);
    endfunction

    function string convert2string();
        string s;
        s = $sformatf("[%s] id=%0h addr=0x%0h len=%0d size=%0s burst=%0s",
            direction.name(), id, addr, len, size.name(), burst.name());
        if (direction == P::AXI_WRITE) begin
            foreach (wdata[i])
                s = {s, $sformatf("\n  wdata[%0d]=0x%0h strb=0x%0h",
                                  i, wdata[i], wstrb[i])};
            s = {s, $sformatf("\n  wresp=%0s", wresp.name())};
        end else begin
            foreach (rdata[i])
                s = {s, $sformatf("\n  rdata[%0d]=0x%0h resp=%0s",
                                  i, rdata[i], rresp[i].name())};
        end
        return s;
    endfunction

endclass : axi_seq_item
