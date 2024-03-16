//                              -*- Mode: Verilog -*-
// Filename        : design.sv
// Description     : Mux4to1, input is 4bit wide : a,b,c,d. Selection is 2 bit wide, y is the output.
// Author          : Vincent Gosselin
// Created On      : Fri Mar 15 22:46:16 2024
// Last Modified By: Vincent Gosselin
// Last Modified On: Fri Mar 15 22:46:16 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module mux
  (
   input [3:0] abcd, ////input data port have size of 4-bit
   input [1:0] sel, ////control port have size of 2-bit
   output reg  y 
   );
   
   always@(*)
     begin
        case(sel)
          2'b00: y = abcd[0];
          2'b01: y = abcd[1];
          2'b10: y = abcd[2];
          2'b11: y = abcd[3];
        endcase
     end
   
   
endmodule
