//clock_divider_v1.v taken from fpga4student.com
module clock_divider_v1(clock_in, clock_out);

input clock_in; 
output clock_out;
reg[27:0] counter = 28'd0;
parameter DIVISOR = 28'd2;

always @ (posedge clock_in)
begin
	counter <= counter + 28'd1;
	if(counter>=(DIVISOR-1))
		counter <= 28'd0;
end

assign clock_out = (counter<DIVISOR/2) ? 1'b0:1'b1;
endmodule

