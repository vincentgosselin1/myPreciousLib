//=============================================================================
// tb_top.sv
//
// Top-level testbench.
//
// Layering:
//   c_led_test_main() [C]          LED_ON()/LED_OFF()/LED_BLINK()/
//        |                         LED_DEVICE_ID() command layer
//        v
//   sv_wb_write()/sv_wb_read()     Wishbone register pokes, exported
//        |                         "DPI-C" tasks implemented right here
//        v                         in tb_top.sv (the "Wishbone agent")
//   Wishbone B4 classic bus (wb_adr_i/wb_dat_i/wb_dat_o/wb_we_i/wb_cyc_i/
//        |                    wb_stb_i/wb_ack_o)
//        v
//   wb_led_blinker.sv              the RTL LED blinker peripheral (DUT)
//        |
//        v
//   led_o                          observed here via a simple SV monitor
//
// The Wishbone master ("Wishbone agent") is implemented directly in this
// top module, not in a separate BFM file.
//=============================================================================
module tb_top;

  timeunit 1ns;
  timeprecision 100ps;

  //---------------------------------------------------------------------
  // Wishbone B4 classic signals
  //---------------------------------------------------------------------
  logic        wb_clk_i;
  logic        wb_rst_i;
  logic [31:0] wb_adr_i;
  logic [31:0] wb_dat_i;
  logic [31:0] wb_dat_o;
  logic        wb_we_i;
  logic [3:0]  wb_sel_i;
  logic        wb_cyc_i;
  logic        wb_stb_i;
  logic        wb_ack_o;

  logic        led_o;

  // 50 MHz wb_clk_i (20ns period). Must match WB_CLK_FREQ_HZ in
  // c/led_driver.h, since the driver converts milliseconds to cycles.
  initial wb_clk_i = 1'b0;
  always #10 wb_clk_i = ~wb_clk_i;

  initial begin
    wb_rst_i = 1'b1;
    wb_adr_i = 32'h0;
    wb_dat_i = 32'h0;
    wb_we_i  = 1'b0;
    wb_sel_i = 4'hF;
    wb_cyc_i = 1'b0;
    wb_stb_i = 1'b0;
    repeat (5) @(posedge wb_clk_i);
    wb_rst_i = 1'b0;
  end

  //---------------------------------------------------------------------
  // DUT: LED blinker peripheral
  //---------------------------------------------------------------------
  wb_led_blinker #(
      .DEVICE_ID(32'hCAFEDEAD)
  ) u_led (
      .wb_clk_i(wb_clk_i),
      .wb_rst_i(wb_rst_i),
      .wb_adr_i(wb_adr_i),
      .wb_dat_i(wb_dat_i),
      .wb_dat_o(wb_dat_o),
      .wb_we_i (wb_we_i),
      .wb_sel_i(wb_sel_i),
      .wb_cyc_i(wb_cyc_i),
      .wb_stb_i(wb_stb_i),
      .wb_ack_o(wb_ack_o),
      .led_o   (led_o)
  );

  // Simple observability: log every LED toggle.
  always @(led_o) begin
    $display("[TB] time=%0t ns : led_o = %0b", $time, led_o);
  end

  //---------------------------------------------------------------------
  // Wishbone agent: basic single-transfer Wishbone B4 classic master,
  // exported to C.
  //---------------------------------------------------------------------
  export "DPI-C" task sv_wb_write;
  export "DPI-C" task sv_wb_read;
  export "DPI-C" task sv_wait_cycles;

  task automatic sv_wb_write(input int addr, input int data);
    @(posedge wb_clk_i);
    wb_adr_i <= addr[31:0];
    wb_dat_i <= data[31:0];
    wb_we_i  <= 1'b1;
    wb_sel_i <= 4'hF;
    wb_cyc_i <= 1'b1;
    wb_stb_i <= 1'b1;
    do begin
      @(posedge wb_clk_i);
    end while (!wb_ack_o);
    wb_cyc_i <= 1'b0;
    wb_stb_i <= 1'b0;
    wb_we_i  <= 1'b0;
  endtask

  task automatic sv_wb_read(input int addr, output int data);
    @(posedge wb_clk_i);
    wb_adr_i <= addr[31:0];
    wb_we_i  <= 1'b0;
    wb_sel_i <= 4'hF;
    wb_cyc_i <= 1'b1;
    wb_stb_i <= 1'b1;
    do begin
      @(posedge wb_clk_i);
    end while (!wb_ack_o);
    data = int'(wb_dat_o);
    wb_cyc_i <= 1'b0;
    wb_stb_i <= 1'b0;
  endtask

  // Lets the C driver advance simulation time (e.g. "hold the LED on for
  // 2ms") without needing any notion of simulation time itself.
  task automatic sv_wait_cycles(input int n);
    repeat (n) @(posedge wb_clk_i);
  endtask

  //---------------------------------------------------------------------
  // Entry point implemented in c/led_driver.c, exported "DPI-C" from C.
  //---------------------------------------------------------------------
  import "DPI-C" task c_led_test_main();

  initial begin
    @(negedge wb_rst_i);
    repeat (2) @(posedge wb_clk_i);
    $display("[TB] Starting DPI-C LED driver test...");
    c_led_test_main();
    $display("[TB] c_led_test_main() returned.");
    repeat (10) @(posedge wb_clk_i);
    $finish;
  end

endmodule
