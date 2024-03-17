//                              -*- Mode: Verilog -*-
// Filename        : design.sv<dff_assignment>
// Description     : Data Flip-flop (DFF). The most basic logic component ever!!!
// Author          : Vincent Gosselin
// Created On      : Sun Mar 17 18:22:30 2024
// Last Modified By: Vincent Gosselin
// Last Modified On: Sun Mar 17 18:22:30 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module dff
  (
   input      clk, rst, din, ena, ////din - data input, rst, ena - active high synchronus
   output reg dout ////dout - data output
   );
   
   always@(posedge clk)
     begin
	if(rst == 1'b1) 
          dout <= 1'b0;
	else begin
           if(ena == 1'b1) begin
	      dout <= din;
	   end
	end	
     end
   
endmodule
