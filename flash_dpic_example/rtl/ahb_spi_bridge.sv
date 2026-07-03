//=============================================================================
// ahb_spi_bridge.sv
//
// Behavioral stand-in for an "SPI flash controller" peripheral: an AHB-Lite
// slave register interface on one side, a bit-banged SPI master on the
// other. This is the module you would eventually replace with your real
// synthesizable AHB-to-SPI controller RTL (or its netlist) -- the AHB
// master in tb_top.sv and the SPI flash model do not need to change.
//
// Register map (word-aligned, byte offsets from this slave's base):
//   0x00  REG_CS      [0]    R/W  1 = assert CS (drive low), 0 = deassert
//   0x04  REG_TXRX    [7:0]  W: byte to transmit, triggers one SPI byte
//                             exchange (8 SCLK pulses) while CS is held.
//                            R: last received byte (valid once BUSY==0).
//   0x08  REG_STATUS  [0]    R    BUSY: 1 while a TXRX byte exchange is
//                                 in flight.
//
// Typical software sequence (see c/flash_driver.c):
//   write REG_CS    = 1                 // assert CS
//   write REG_TXRX  = opcode            // e.g. 0x9F (RDID)
//   poll  REG_STATUS until BUSY == 0
//   read  REG_TXRX                      // (ignored on a command byte)
//   ... repeat write/poll/read REG_TXRX for each additional byte ...
//   write REG_CS    = 0                 // deassert CS
//
// This is a single-slave AHB-Lite subsystem (no interconnect/address
// decoder): HSEL is expected to be tied high by the top level, and only
// the low byte offsets above are decoded.
//=============================================================================
module ahb_spi_bridge (
    // AHB-Lite slave interface
    input  logic        HCLK,
    input  logic        HRESETn,
    input  logic [31:0] HADDR,
    input  logic [31:0] HWDATA,
    output logic [31:0] HRDATA,
    input  logic        HWRITE,
    input  logic [2:0]  HSIZE,
    input  logic [1:0]  HTRANS,
    input  logic        HSEL,
    output logic        HREADY,
    output logic        HRESP,

    // SPI bus (to spi_flash_model.sv / real flash)
    output logic sclk,
    output logic cs_n,
    output logic mosi,
    input  logic miso
);

  timeunit 1ns;
  timeprecision 100ps;

  localparam logic [7:0] REG_CS     = 8'h00;
  localparam logic [7:0] REG_TXRX   = 8'h04;
  localparam logic [7:0] REG_STATUS = 8'h08;

  localparam logic [1:0] HTRANS_IDLE   = 2'b00;

  // SPI bit-bang timing (behavioral model of the SPI master engine).
  parameter time SCLK_HALF_PERIOD = 10ns;

  // AHB is zero-wait-state in this example (HREADY tied high). See README
  // for how to add wait states on a real controller.
  assign HREADY = 1'b1;
  assign HRESP  = 1'b0; // always OKAY

  // ---- Address-phase capture (AHB pipeline: addr phase -> data phase) ---
  logic       sel_q;
  logic       write_q;
  logic [7:0] addr_q;

  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
      sel_q   <= 1'b0;
      write_q <= 1'b0;
      addr_q  <= 8'h00;
    end else begin
      sel_q   <= HSEL && (HTRANS != HTRANS_IDLE);
      write_q <= HWRITE;
      addr_q  <= HADDR[7:0];
    end
  end

  // ---- SPI engine state, shared between the AHB data-phase logic and
  //      the independent SPI bit-bang process below.
  logic       busy;
  logic [7:0] rx_byte_q;
  logic [7:0] tx_byte_reg;
  logic       start_pulse;

  initial begin
    cs_n        = 1'b1;
    sclk        = 1'b0;
    mosi        = 1'b0;
    busy        = 1'b0;
    rx_byte_q   = 8'h00;
    tx_byte_reg = 8'h00;
    start_pulse = 1'b0;
  end

  // ---- Data phase: register reads/writes ----
  always_ff @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
      HRDATA      <= 32'h0;
      start_pulse <= 1'b0;
    end else begin
      start_pulse <= 1'b0; // default: single-cycle pulse

      if (sel_q) begin
        if (write_q) begin
          unique case (addr_q)
            REG_CS: cs_n <= ~HWDATA[0]; // 1 => assert (cs_n=0)
            REG_TXRX: begin
              if (!busy) begin
                tx_byte_reg <= HWDATA[7:0];
                start_pulse <= 1'b1;
              end
            end
            default: ;
          endcase
        end else begin
          unique case (addr_q)
            REG_CS:     HRDATA <= {31'b0, ~cs_n};
            REG_TXRX:   HRDATA <= {24'b0, rx_byte_q};
            REG_STATUS: HRDATA <= {31'b0, busy};
            default:    HRDATA <= 32'h0;
          endcase
        end
      end
    end
  end

  // ---- SPI bit-bang engine: runs independently of the AHB clock domain,
  //      triggered by start_pulse. Mode 0 (CPOL=0, CPHA=0), MSB first --
  //      identical protocol to the original spi_bfm.sv master task.
  always @(posedge start_pulse) begin
    byte rx;
    busy = 1'b1;
    rx = 8'h00;
    for (int i = 7; i >= 0; i--) begin
      mosi = tx_byte_reg[i];
      #(SCLK_HALF_PERIOD);
      sclk = 1'b1;
      rx[i] = miso;
      #(SCLK_HALF_PERIOD);
      sclk = 1'b0;
    end
    rx_byte_q = rx;
    busy = 1'b0;
  end

endmodule
