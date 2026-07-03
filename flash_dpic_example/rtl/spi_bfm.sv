//=============================================================================
// spi_bfm.sv
//
// Simple SPI master Bus Functional Model (mode 0: CPOL=0, CPHA=0).
// Exposes three DPI-C exported tasks that the C "driver" code calls to
// drive the physical SPI pins one byte (or CS control) at a time:
//
//   sv_spi_cs_assert()                        - assert CS_N (active low)
//   sv_spi_cs_deassert()                      - deassert CS_N
//   sv_spi_xfer_byte(tx_byte, rx_byte)        - full-duplex byte transfer
//
// This keeps all clock/pin toggling inside SystemVerilog (where it belongs
// for timing accuracy) while letting the C code express flash *commands*
// (WREN, PP, READ, SE, RDID, ...) in plain, readable, portable C.
//=============================================================================
module spi_bfm (
    output logic sclk,
    output logic cs_n,
    output logic mosi,
    input  logic miso
);

  timeunit 1ns;
  timeprecision 100ps;

  // Half-period of SCLK. Adjust to taste / to match target timing.
  parameter time HALF_PERIOD = 10ns; // -> 20ns period -> 50 MHz SCLK

  initial begin
    sclk = 1'b0;
    cs_n = 1'b1;
    mosi = 1'b0;
  end

  export "DPI-C" task sv_spi_cs_assert;
  export "DPI-C" task sv_spi_cs_deassert;
  export "DPI-C" task sv_spi_xfer_byte;

  // Assert chip select and give the slave a half period to see it before
  // the first clock edge.
  task automatic sv_spi_cs_assert();
    cs_n = 1'b0;
    #(HALF_PERIOD);
  endtask

  // Deassert chip select, with a settling half period first.
  task automatic sv_spi_cs_deassert();
    #(HALF_PERIOD);
    cs_n = 1'b1;
    #(HALF_PERIOD);
  endtask

  // Full-duplex, MSB-first, 8-bit SPI transfer (mode 0).
  //   - MOSI is updated while SCLK is low (setup time before rising edge)
  //   - Data is sampled by both sides on the SCLK rising edge
  task automatic sv_spi_xfer_byte(input byte tx_byte, output byte rx_byte);
    byte rx;
    rx = 8'h00;
    for (int i = 7; i >= 0; i--) begin
      mosi = tx_byte[i];
      #(HALF_PERIOD);
      sclk = 1'b1;
      rx[i] = miso;
      #(HALF_PERIOD);
      sclk = 1'b0;
    end
    rx_byte = rx;
  endtask

endmodule
