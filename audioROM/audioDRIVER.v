module audio_driver (
    input wire clk,
    input wire ena,
    output reg [7:0] audio_out
);

    reg [7:0] addr;
    wire [7:0] rom_data;

    // Instantiate the ROM
    rom audio_rom (
        .clk(clk),
        .addr(addr),
        .data(rom_data)
    );

    always @(posedge clk) begin
        if (ena) begin
            audio_out <= rom_data; // Drive the output with ROM data
            addr <= addr + 1;      // Increment address to read next sample
        end
    end

endmodule
