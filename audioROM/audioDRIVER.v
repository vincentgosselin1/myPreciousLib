module audio_driver (
    input  wire        clk,
    input  wire        ena,
    output reg  [7:0]  audio_out
);

    reg [7:0] address;
    wire [7:0] rom_data;

    // Instantiate the ROM
    audio_rom rom_inst (
        .address(address),
        .data(rom_data)
    );

    always @(posedge clk) begin
        if (ena) begin
            audio_out <= rom_data;
            address <= address + 1;
        end
    end

    initial begin
        address = 0;
    end

endmodule
