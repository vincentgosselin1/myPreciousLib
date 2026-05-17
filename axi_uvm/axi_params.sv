//==============================================================================
// axi_params.sv
//
// Parameter container class.
// All AXI UVM components are parameterized with a single class handle of this
// type, so adding or changing a parameter only requires touching one place.
//
// Usage
// ─────
//   // 1. Declare a specialisation typedef (once per unique bus configuration)
//   typedef axi_params #(.ADDR_W(32), .DATA_W(64)) axi64_params_t;
//
//   // 2. Use it everywhere
//   axi_agent  #(axi64_params_t) agent;
//   axi_seq_item #(axi64_params_t) item;
//==============================================================================

//------------------------------------------------------------------------------
// axi_if – parameterized virtual interface
// Defined here (before the classes) so every component can reference it.
//------------------------------------------------------------------------------
interface axi_if #(
    parameter int ADDR_W   = 32,
    parameter int DATA_W   = 32,
    parameter int ID_W     = 1,
    parameter int USER_W   = 1
) (
    input logic aclk,
    input logic aresetn
);
    // Derived widths
    localparam int STRB_W   = DATA_W / 8;
    localparam int LEN_W    = 8;
    localparam int SIZE_W   = 3;
    localparam int BURST_W  = 2;
    localparam int CACHE_W  = 4;
    localparam int PROT_W   = 3;
    localparam int REGION_W = 4;
    localparam int QOS_W    = 4;
    localparam int RESP_W   = 2;

    // Write address channel
    logic [ID_W-1:0]     awid;
    logic [ADDR_W-1:0]   awaddr;
    logic [LEN_W-1:0]    awlen;
    logic [SIZE_W-1:0]   awsize;
    logic [BURST_W-1:0]  awburst;
    logic                awlock;
    logic [CACHE_W-1:0]  awcache;
    logic [PROT_W-1:0]   awprot;
    logic [REGION_W-1:0] awregion;
    logic [QOS_W-1:0]    awqos;
    logic [USER_W-1:0]   awuser;
    logic                awvalid;
    logic                awready;

    // Write data channel
    logic [DATA_W-1:0]   wdata;
    logic [STRB_W-1:0]   wstrb;
    logic                wlast;
    logic [USER_W-1:0]   wuser;
    logic                wvalid;
    logic                wready;

    // Write response channel
    logic [ID_W-1:0]     bid;
    logic [RESP_W-1:0]   bresp;
    logic [USER_W-1:0]   buser;
    logic                bvalid;
    logic                bready;

    // Read address channel
    logic [ID_W-1:0]     arid;
    logic [ADDR_W-1:0]   araddr;
    logic [LEN_W-1:0]    arlen;
    logic [SIZE_W-1:0]   arsize;
    logic [BURST_W-1:0]  arburst;
    logic                arlock;
    logic [CACHE_W-1:0]  arcache;
    logic [PROT_W-1:0]   arprot;
    logic [REGION_W-1:0] arregion;
    logic [QOS_W-1:0]    arqos;
    logic [USER_W-1:0]   aruser;
    logic                arvalid;
    logic                arready;

    // Read data channel
    logic [ID_W-1:0]     rid;
    logic [DATA_W-1:0]   rdata;
    logic [RESP_W-1:0]   rresp;
    logic                rlast;
    logic [USER_W-1:0]   ruser;
    logic                rvalid;
    logic                rready;

endinterface : axi_if


//------------------------------------------------------------------------------
// axi_params
// Virtual class – never instantiated, used only as a parameter type.
// All widths and AXI enum definitions live here.
//------------------------------------------------------------------------------
virtual class axi_params #(
    parameter int ADDR_W  = 32,
    parameter int DATA_W  = 32,
    parameter int ID_W    = 1,
    parameter int USER_W  = 1
);
    //------------------------------------------------------------------
    // Derived widths (accessible as e.g. P::STRB_W)
    //------------------------------------------------------------------
    localparam int STRB_W   = DATA_W / 8;
    localparam int LEN_W    = 8;
    localparam int SIZE_W   = 3;
    localparam int BURST_W  = 2;
    localparam int CACHE_W  = 4;
    localparam int PROT_W   = 3;
    localparam int REGION_W = 4;
    localparam int QOS_W    = 4;
    localparam int RESP_W   = 2;

    // Maximum beats per burst (AXI4)
    localparam int BEATS_MAX = 256;

    // Xilinx VIP flat data-array depth (4096 bytes)
    localparam int VIP_DATA_DEPTH = 4096 / (DATA_W / 8);

    //------------------------------------------------------------------
    // AXI enum types (scoped as P::axi_burst_t etc.)
    //------------------------------------------------------------------
    typedef enum logic [1:0] {
        AXI_BURST_FIXED = 2'b00,
        AXI_BURST_INCR  = 2'b01,
        AXI_BURST_WRAP  = 2'b10,
        AXI_BURST_RSVD  = 2'b11
    } axi_burst_t;

    typedef enum logic [1:0] {
        AXI_RESP_OKAY   = 2'b00,
        AXI_RESP_EXOKAY = 2'b01,
        AXI_RESP_SLVERR = 2'b10,
        AXI_RESP_DECERR = 2'b11
    } axi_resp_t;

    typedef enum logic [2:0] {
        AXI_SIZE_1B   = 3'b000,
        AXI_SIZE_2B   = 3'b001,
        AXI_SIZE_4B   = 3'b010,
        AXI_SIZE_8B   = 3'b011,
        AXI_SIZE_16B  = 3'b100,
        AXI_SIZE_32B  = 3'b101,
        AXI_SIZE_64B  = 3'b110,
        AXI_SIZE_128B = 3'b111
    } axi_size_t;

    typedef enum logic {
        AXI_WRITE = 1'b0,
        AXI_READ  = 1'b1
    } axi_dir_t;

    //------------------------------------------------------------------
    // Virtual interface type alias (convenience)
    //------------------------------------------------------------------
    typedef virtual axi_if #(
        .ADDR_W  (ADDR_W),
        .DATA_W  (DATA_W),
        .ID_W    (ID_W),
        .USER_W  (USER_W)
    ) vif_t;

endclass : axi_params
