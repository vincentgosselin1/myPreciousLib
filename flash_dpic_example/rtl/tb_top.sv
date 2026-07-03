//=============================================================================
// tb_top.sv
//
// Top-level testbench. Wires the SPI master BFM (spi_bfm.sv) to the
// behavioral flash slave (spi_flash_model.sv), then hands control to the
// C DPI-C driver by calling the imported task c_flash_test_main().
// All flash command sequencing lives in C (c/flash_driver.c); all pin
// wiggling lives in SV (rtl/spi_bfm.sv).
//=============================================================================
module tb_top;

  timeunit 1ns;
  timeprecision 100ps;

  logic sclk;
  logic cs_n;
  logic mosi;
  logic miso;

  spi_bfm u_bfm (
      .sclk (sclk),
      .cs_n (cs_n),
      .mosi (mosi),
      .miso (miso)
  );

  spi_flash_model #(
      .MEM_SIZE   (65536),
      .SECTOR_SIZE(4096)
  ) u_flash (
      .sclk (sclk),
      .cs_n (cs_n),
      .mosi (mosi),
      .miso (miso)
  );

  // Implemented in c/flash_driver.c, exported "DPI-C" from C.
  import "DPI-C" task c_flash_test_main();

  initial begin
    cs_n = 1'b1;
    #100;
    $display("[TB] Starting DPI-C flash driver test...");
    c_flash_test_main();
    $display("[TB] c_flash_test_main() returned.");
    #100;
    $finish;
  end

endmodule
