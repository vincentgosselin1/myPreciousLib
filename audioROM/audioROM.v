module rom (
    input wire clk,
    input wire [7:0] addr,
    output reg [7:0] data
);

    reg [7:0] rom_data [0:255]; // 256 x 8-bit ROM

    initial begin
        // Initialize ROM with sample data
        $readmemh("audio_samples.mem", rom_data); // Assuming hex data stored in "audio_samples.mem"
    end

    always @(posedge clk) begin
        data <= rom_data[addr];
    end
endmodule
