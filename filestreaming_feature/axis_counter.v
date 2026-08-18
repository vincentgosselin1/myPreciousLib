// axis_counter.v
// 32-bit free-running counter with an AXI4-Stream master interface.
// Asserts TLAST every BURST_LEN samples to mark a DMA burst boundary.

module axis_counter #(
    parameter BURST_LEN = 256   // samples per TLAST (per DMA transfer)
)(
    input  wire        aclk,
    input  wire        aresetn,

    output reg  [31:0] m_axis_tdata,
    output reg          m_axis_tvalid,
    input  wire          m_axis_tready,
    output reg          m_axis_tlast
);
    reg [31:0] counter;
    reg [$clog2(BURST_LEN)-1:0] burst_cnt;

    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            counter       <= 32'd0;
            burst_cnt     <= 0;
            m_axis_tdata  <= 32'd0;
            m_axis_tvalid <= 1'b0;
            m_axis_tlast  <= 1'b0;
        end else begin
            m_axis_tvalid <= 1'b1; // always have data ready

            if (m_axis_tvalid && m_axis_tready) begin
                m_axis_tdata <= counter;
                counter      <= counter + 1;

                if (burst_cnt == BURST_LEN - 1) begin
                    burst_cnt    <= 0;
                    m_axis_tlast <= 1'b1;
                end else begin
                    burst_cnt    <= burst_cnt + 1;
                    m_axis_tlast <= 1'b0;
                end
            end else begin
                m_axis_tlast <= 1'b0;
            end
        end
    end
endmodule
