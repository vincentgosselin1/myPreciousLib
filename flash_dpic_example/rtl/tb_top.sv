//=============================================================================
// tb_top.sv
//
// Top-level testbench.
//
// Layering (top to bottom):
//   c_flash_test_main() [C]         flash command sequencing (RDID, PP,
//        |                          SE, READ, ...)
//        v
//   sv_ahb_write()/sv_ahb_read()    AHB-Lite register pokes, exported
//        |                         "DPI-C" tasks implemented right here
//        v                          in tb_top.sv (the "AHB agent")
//   AHB-Lite bus (HADDR/HWDATA/HRDATA/HWRITE/HTRANS/HREADY/HRESP)
//        |
//        v
//   ahb_spi_bridge.sv               AHB slave register file that
//        |                          translates register pokes into SPI
//        v                          byte transactions (the "DUT")
//   SPI bus (sclk/cs_n/mosi/miso)
//        |
//        v
//   spi_flash_model.sv              behavioral Micron-style SPI NOR flash
//
// The AHB master ("AHB agent") is intentionally implemented directly in
// this top module rather than in a separate BFM file, per the project
// requirement -- its two exported tasks are the only things the C code
// calls into.
//=============================================================================
module tb_top;

  timeunit 1ns;
  timeprecision 100ps;

  //---------------------------------------------------------------------
  // AHB-Lite signals
  //---------------------------------------------------------------------
  logic        HCLK;
  logic        HRESETn;
  logic [31:0] HADDR;
  logic [31:0] HWDATA;
  logic [31:0] HRDATA;
  logic        HWRITE;
  logic [2:0]  HSIZE;
  logic [1:0]  HTRANS;
  logic        HSEL;
  logic        HREADY;
  logic        HRESP;

  localparam logic [1:0] HTRANS_IDLE   = 2'b00;
  localparam logic [1:0] HTRANS_NONSEQ = 2'b10;
  localparam logic [2:0] HSIZE_WORD    = 3'b010;

  // 100 MHz HCLK
  initial HCLK = 1'b0;
  always #5 HCLK = ~HCLK;

  initial begin
    HRESETn = 1'b0;
    HADDR   = 32'h0;
    HWDATA  = 32'h0;
    HWRITE  = 1'b0;
    HSIZE   = HSIZE_WORD;
    HTRANS  = HTRANS_IDLE;
    HSEL    = 1'b1; // single-slave subsystem, always selected
    repeat (5) @(posedge HCLK);
    HRESETn = 1'b1;
  end

  //---------------------------------------------------------------------
  // SPI bus (bridge <-> flash model)
  //---------------------------------------------------------------------
  logic sclk;
  logic cs_n;
  logic mosi;
  logic miso;

  //---------------------------------------------------------------------
  // DUT: AHB-Lite slave / SPI master bridge
  //---------------------------------------------------------------------
  ahb_spi_bridge u_bridge (
      .HCLK   (HCLK),
      .HRESETn(HRESETn),
      .HADDR  (HADDR),
      .HWDATA (HWDATA),
      .HRDATA (HRDATA),
      .HWRITE (HWRITE),
      .HSIZE  (HSIZE),
      .HTRANS (HTRANS),
      .HSEL   (HSEL),
      .HREADY (HREADY),
      .HRESP  (HRESP),

      .sclk(sclk),
      .cs_n(cs_n),
      .mosi(mosi),
      .miso(miso)
  );

  //---------------------------------------------------------------------
  // SPI NOR flash behavioral model
  //---------------------------------------------------------------------
  spi_flash_model #(
      .MEM_SIZE   (65536),
      .SECTOR_SIZE(4096)
  ) u_flash (
      .sclk(sclk),
      .cs_n(cs_n),
      .mosi(mosi),
      .miso(miso)
  );

  //---------------------------------------------------------------------
  // AHB agent: basic single-transfer AHB-Lite master, exported to C.
  //
  // Each transaction uses the standard two-phase AHB-Lite pipeline
  // (address phase, then data phase) and honors HREADY wait states,
  // even though ahb_spi_bridge never inserts any in this example.
  //---------------------------------------------------------------------
  export "DPI-C" task sv_ahb_write;
  export "DPI-C" task sv_ahb_read;

  task automatic sv_ahb_write(input int addr, input int data);
    // Address phase
    @(posedge HCLK);
    HADDR  <= addr[31:0];
    HWRITE <= 1'b1;
    HSIZE  <= HSIZE_WORD;
    HTRANS <= HTRANS_NONSEQ;
    @(posedge HCLK);
    while (!HREADY) @(posedge HCLK);

    // Data phase
    HWDATA <= data[31:0];
    HTRANS <= HTRANS_IDLE;
    @(posedge HCLK);
    while (!HREADY) @(posedge HCLK);
  endtask

  task automatic sv_ahb_read(input int addr, output int data);
    // Address phase
    @(posedge HCLK);
    HADDR  <= addr[31:0];
    HWRITE <= 1'b0;
    HSIZE  <= HSIZE_WORD;
    HTRANS <= HTRANS_NONSEQ;
    @(posedge HCLK);
    while (!HREADY) @(posedge HCLK);

    // Data phase
    HTRANS <= HTRANS_IDLE;
    @(posedge HCLK);
    while (!HREADY) @(posedge HCLK);

    data = int'(HRDATA);
  endtask

  //---------------------------------------------------------------------
  // Entry point implemented in c/flash_driver.c, exported "DPI-C" from C.
  //---------------------------------------------------------------------
  import "DPI-C" task c_flash_test_main();

  initial begin
    @(posedge HRESETn);
    repeat (2) @(posedge HCLK);
    $display("[TB] Starting DPI-C flash driver test (AHB -> SPI bridge)...");
    c_flash_test_main();
    $display("[TB] c_flash_test_main() returned.");
    repeat (10) @(posedge HCLK);
    $finish;
  end

endmodule
