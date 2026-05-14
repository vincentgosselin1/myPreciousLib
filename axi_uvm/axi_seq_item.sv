//==============================================================================
// axi_seq_item.sv
//
// UVM sequence item for AXI4 transactions.
// Encapsulates a complete AXI write or read burst transaction.
//==============================================================================

class axi_seq_item extends uvm_sequence_item;
    `uvm_object_utils(axi_seq_item)

    //--------------------------------------------------------------------------
    // Transaction kind
    //--------------------------------------------------------------------------
    typedef enum logic { AXI_WRITE = 1'b0, AXI_READ = 1'b1 } axi_dir_t;

    //--------------------------------------------------------------------------
    // Request fields (driven by sequences / driver)
    //--------------------------------------------------------------------------
    rand axi_dir_t    direction;

    rand logic [AXI_ADDR_W-1:0]   addr;
    rand logic [AXI_LEN_W-1:0]    len;      // beats - 1  (AXI encoding)
    rand axi_size_t                size;
    rand axi_burst_t               burst;
    rand logic                     lock;
    rand logic [AXI_CACHE_W-1:0]  cache;
    rand logic [AXI_PROT_W-1:0]   prot;
    rand logic [AXI_REGION_W-1:0] region;
    rand logic [AXI_QOS_W-1:0]    qos;

    // Write data / strobe per beat (array size must equal len+1)
    rand logic [AXI_DATA_W-1:0]   wdata [];
    rand logic [AXI_STRB_W-1:0]   wstrb [];

    //--------------------------------------------------------------------------
    // Response fields (filled by driver after transaction completes)
    //--------------------------------------------------------------------------
    logic [AXI_DATA_W-1:0]  rdata [];   // valid for READ
    axi_resp_t               wresp;     // write response
    axi_resp_t               rresp [];  // per-beat read response

    //--------------------------------------------------------------------------
    // Constraints
    //--------------------------------------------------------------------------
    // Keep burst length reasonable for random tests
    constraint c_len_range {
        len inside {[0:15]};
    }

    // Data/strobe arrays must match burst length
    constraint c_data_size {
        wdata.size() == len + 1;
        wstrb.size() == len + 1;
    }

    // Default to incrementing or wrapping bursts
    constraint c_burst_legal {
        burst inside {AXI_BURST_INCR, AXI_BURST_WRAP};
    }

    // 4-KB boundary: total transfer must not cross a 4 KB page
    constraint c_4kb_boundary {
        (addr & ~({AXI_ADDR_W{1'b1}} << 12)) + ((len + 1) << size) <= 4096;
    }

    // Full-word strobes by default (override per test for byte-enables)
    constraint c_full_strobe {
        foreach (wstrb[i]) wstrb[i] == {AXI_STRB_W{1'b1}};
    }

    //--------------------------------------------------------------------------
    // UVM standard methods
    //--------------------------------------------------------------------------
    function new(string name = "axi_seq_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        axi_seq_item rhs_;
        if (!$cast(rhs_, rhs))
            `uvm_fatal(`gtn, "Cast failed in do_copy")
        super.do_copy(rhs);
        direction = rhs_.direction;
        addr      = rhs_.addr;
        len       = rhs_.len;
        size      = rhs_.size;
        burst     = rhs_.burst;
        lock      = rhs_.lock;
        cache     = rhs_.cache;
        prot      = rhs_.prot;
        region    = rhs_.region;
        qos       = rhs_.qos;
        wdata     = rhs_.wdata;
        wstrb     = rhs_.wstrb;
        rdata     = rhs_.rdata;
        wresp     = rhs_.wresp;
        rresp     = rhs_.rresp;
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        axi_seq_item rhs_;
        if (!$cast(rhs_, rhs)) return 0;
        return super.do_compare(rhs, comparer)
            && (direction === rhs_.direction)
            && (addr      === rhs_.addr)
            && (len       === rhs_.len)
            && (size      === rhs_.size)
            && (burst     === rhs_.burst);
    endfunction

    function string convert2string();
        string s;
        s = $sformatf("[%s] addr=0x%0h len=%0d size=%0s burst=%0s",
            direction.name(), addr, len, size.name(), burst.name());
        if (direction == AXI_WRITE) begin
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
