//=============================================================================
// spi_flash_model.sv
//
// Small behavioral model of a Micron-style SPI NOR flash (e.g. N25Q/MT25Q
// family command set). This is NOT a cycle-accurate/timing-accurate model
// of a real part -- it exists so this example is fully self-contained and
// runs end-to-end in simulation without a vendor netlist.
//
// In a real project you would replace this module's instance in tb_top.sv
// with your actual DUT (RTL SPI controller + real/vendor flash model, or
// silicon in an emulation flow) -- the DPI-C driver and spi_bfm.sv master
// do not need to change.
//
// Supported opcodes:
//   0x06 WREN        Write Enable
//   0x04 WRDI        Write Disable
//   0x05 RDSR        Read Status Register
//   0x9F RDID        Read Identification (3 bytes: manuf/type/capacity)
//   0x03 READ        Read Data (3-byte address, low speed)
//   0x0B FAST_READ    (treated identically to READ in this simple model)
//   0x02 PP          Page Program (3-byte address + data)
//   0x20 SE          Sector Erase (3-byte address, 4KB sectors)
//   0xC7 CE          Chip Erase
//=============================================================================
module spi_flash_model #(
    parameter int unsigned MEM_SIZE   = 65536, // 64KB for simulation speed
    parameter int unsigned SECTOR_SIZE = 4096,
    parameter byte         MANUF_ID   = 8'h20, // Micron manufacturer ID (example)
    parameter byte         MEM_TYPE   = 8'hBA, // example device type
    parameter byte         MEM_CAP    = 8'h18  // example capacity code
)(
    input  logic sclk,
    input  logic cs_n,
    input  logic mosi,
    output logic miso
);

  timeunit 1ns;
  timeprecision 100ps;

  localparam byte CMD_WREN      = 8'h06;
  localparam byte CMD_WRDI      = 8'h04;
  localparam byte CMD_RDSR      = 8'h05;
  localparam byte CMD_READ      = 8'h03;
  localparam byte CMD_FAST_READ = 8'h0B;
  localparam byte CMD_PP        = 8'h02;
  localparam byte CMD_SE        = 8'h20;
  localparam byte CMD_CE        = 8'hC7;
  localparam byte CMD_RDID      = 8'h9F;

  localparam int ADDR_BITS = $clog2(MEM_SIZE);

  byte mem [0:MEM_SIZE-1];

  bit  write_enable_latch;
  byte status_reg;

  byte         cmd;
  byte         shift_in;
  byte         shift_out;
  int          bit_cnt;
  int          byte_cnt;
  logic [23:0] addr;
  bit          have_cmd;

  initial begin
    foreach (mem[i]) mem[i] = 8'hFF;
    write_enable_latch = 1'b0;
    miso = 1'bz;
  end

  assign status_reg = {6'b0, write_enable_latch, 1'b0}; // bit0 = WIP (always 0 here)

  // Reset per-transaction state whenever CS is asserted (falling edge).
  always @(negedge cs_n) begin
    have_cmd = 1'b0;
    byte_cnt = 0;
    bit_cnt  = 0;
    shift_in = 8'h00;
    addr     = 24'h0;
  end

  // Shift MOSI bits in, MSB first, dispatch a byte every 8 clocks.
  always @(posedge sclk) begin
    if (!cs_n) begin
      shift_in = {shift_in[6:0], mosi};
      bit_cnt++;
      if (bit_cnt == 8) begin
        bit_cnt = 0;
        handle_byte(shift_in);
        byte_cnt++;
      end
    end
  end

  // Drive MISO on the falling edge so it is stable well before the next
  // rising edge, matching mode 0 timing used by spi_bfm.sv.
  always @(negedge sclk or negedge cs_n) begin
    if (cs_n)
      miso <= 1'bz;
    else
      miso <= shift_out[7];
  end

  task automatic handle_byte(input byte b);
    int sector_base;
    int i;

    if (!have_cmd) begin
      cmd      = b;
      have_cmd = 1'b1;
      unique case (cmd)
        CMD_RDSR: shift_out = status_reg;
        CMD_RDID: shift_out = MANUF_ID;
        default:  shift_out = 8'h00;
      endcase
    end else begin
      case (cmd)
        CMD_WREN: write_enable_latch = 1'b1;
        CMD_WRDI: write_enable_latch = 1'b0;

        CMD_RDSR: shift_out = status_reg;

        CMD_RDID: begin
          if (byte_cnt == 1)      shift_out = MEM_TYPE;
          else if (byte_cnt == 2) shift_out = MEM_CAP;
          else                    shift_out = 8'h00;
        end

        CMD_READ, CMD_FAST_READ: begin
          if (byte_cnt < 3) begin
            addr = {addr[15:0], b};
          end else begin
            shift_out = mem[addr[ADDR_BITS-1:0]];
            addr = addr + 24'd1;
          end
        end

        CMD_PP: begin
          if (byte_cnt < 3) begin
            addr = {addr[15:0], b};
          end else if (write_enable_latch) begin
            // Real NOR flash program can only clear bits (1->0).
            mem[addr[ADDR_BITS-1:0]] = mem[addr[ADDR_BITS-1:0]] & b;
            addr = addr + 24'd1;
          end
        end

        CMD_SE: begin
          if (byte_cnt < 3) begin
            addr = {addr[15:0], b};
            if (byte_cnt == 2 && write_enable_latch) begin
              sector_base = int'(addr[ADDR_BITS-1:0]) & ~(SECTOR_SIZE - 1);
              for (i = 0; i < SECTOR_SIZE; i++)
                mem[sector_base + i] = 8'hFF;
            end
          end
        end

        CMD_CE: begin
          if (write_enable_latch) begin
            for (i = 0; i < MEM_SIZE; i++) mem[i] = 8'hFF;
          end
        end

        default: ; // ignore unsupported opcodes in this simple model
      endcase
    end
  endtask

endmodule
