//=============================================================================
// wb_led_blinker.sv
//
// LED blinker peripheral with a Wishbone B4 classic (single-cycle) slave
// interface. This is the "RTL" side of the design -- the C driver never
// sees these signals directly, only the register map below.
//
// Register map (word-aligned, byte offsets):
//   0x00  REG_CTRL          [0] LED_EN     R/W  solid-on when BLINK_EN=0
//                           [1] BLINK_EN   R/W  1 = blink mode
//   0x04  REG_PERIOD_CYCLES        R/W  half-period of the blink, in
//                                        wb_clk_i cycles (see note below)
//   0x08  REG_DEVICE_ID            R    fixed ID, 0xCAFEDEAD
//
// Note on REG_PERIOD_CYCLES: real hardware would take a period in real
// time; because the clock frequency is a property of the SoC, the C
// driver (c/led_driver.c) is responsible for converting the caller's
// requested milliseconds into wb_clk_i cycles using a known WB_CLK_FREQ_HZ,
// exactly like a real embedded driver would convert to a hardware timer's
// tick count.
//=============================================================================
module wb_led_blinker #(
    parameter logic [31:0] DEVICE_ID = 32'hCAFEDEAD
)(
    input  logic        wb_clk_i,
    input  logic        wb_rst_i,   // active-high, synchronous

    input  logic [31:0] wb_adr_i,
    input  logic [31:0] wb_dat_i,
    output logic [31:0] wb_dat_o,
    input  logic        wb_we_i,
    input  logic [3:0]  wb_sel_i,
    input  logic        wb_cyc_i,
    input  logic        wb_stb_i,
    output logic        wb_ack_o,

    output logic led_o
);

  localparam logic [7:0] REG_CTRL          = 8'h00;
  localparam logic [7:0] REG_PERIOD_CYCLES = 8'h04;
  localparam logic [7:0] REG_DEVICE_ID     = 8'h08;

  logic        ctrl_led_en;
  logic        ctrl_blink_en;
  logic [31:0] period_cycles;
  logic [31:0] cyc_cnt;

  // Zero-wait-state slave: ack combinationally whenever selected.
  wire access = wb_cyc_i && wb_stb_i;
  assign wb_ack_o = access;

  //-------------------------------------------------------------------
  // Register writes
  //-------------------------------------------------------------------
  always_ff @(posedge wb_clk_i) begin
    if (wb_rst_i) begin
      ctrl_led_en   <= 1'b0;
      ctrl_blink_en <= 1'b0;
      period_cycles <= 32'd0;
    end else if (access && wb_we_i) begin
      unique case (wb_adr_i[7:0])
        REG_CTRL: begin
          ctrl_led_en   <= wb_dat_i[0];
          ctrl_blink_en <= wb_dat_i[1];
        end
        REG_PERIOD_CYCLES: period_cycles <= wb_dat_i;
        default: ; // REG_DEVICE_ID is read-only, writes ignored
      endcase
    end
  end

  //-------------------------------------------------------------------
  // Register reads (combinational, valid same cycle as wb_ack_o)
  //-------------------------------------------------------------------
  always_comb begin
    wb_dat_o = 32'h0;
    if (access && !wb_we_i) begin
      unique case (wb_adr_i[7:0])
        REG_CTRL:          wb_dat_o = {30'b0, ctrl_blink_en, ctrl_led_en};
        REG_PERIOD_CYCLES: wb_dat_o = period_cycles;
        REG_DEVICE_ID:     wb_dat_o = DEVICE_ID;
        default:           wb_dat_o = 32'h0;
      endcase
    end
  end

  //-------------------------------------------------------------------
  // LED state machine
  //-------------------------------------------------------------------
  always_ff @(posedge wb_clk_i) begin
    if (wb_rst_i) begin
      cyc_cnt <= 32'd0;
      led_o   <= 1'b0;
    end else if (ctrl_blink_en) begin
      if (period_cycles == 32'd0) begin
        // Avoid a hang if software forgets to program the period.
        led_o <= led_o;
      end else if (cyc_cnt >= period_cycles - 32'd1) begin
        cyc_cnt <= 32'd0;
        led_o   <= ~led_o;
      end else begin
        cyc_cnt <= cyc_cnt + 32'd1;
      end
    end else begin
      cyc_cnt <= 32'd0;
      led_o   <= ctrl_led_en;
    end
  end

endmodule
