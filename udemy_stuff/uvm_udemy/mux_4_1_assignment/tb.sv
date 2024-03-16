//                              -*- Mode: SystemVerilog -*-
// Filename        : tb.sv
// Description     : mux4to1_tb
// Author          : Vincent Gosselin
// Created On      : Fri Mar 15 20:20:24 2024
// Last Modified By: Vincent Gosselin
// Last Modified On: Fri Mar 15 20:20:24 2024
// Update Count    : 0
// Status          : WIP

      ////////////////////////// Testbench Code

`timescale 1ns / 1ps
     
     
      /////////////////////////Transaction
`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   //`uvm_object_utils(transaction)
   
   rand bit [3:0] abcd;
   rand bit [1:0] sel;
   bit 	  y;
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(abcd, UVM_DEFAULT)
      `uvm_field_int(sel, UVM_DEFAULT)
      `uvm_field_int(y, UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass


//////////////////////////////////////////////////////////////
class generator extends uvm_sequence #(transaction);
   `uvm_object_utils(generator)
   
   transaction t;
   integer 		      i;
   
   function new(input string path = "generator");
      super.new(path);
   endfunction
   
   
   virtual task body();
      t = transaction::type_id::create("t");
      repeat(10) 
        begin
           start_item(t);
           t.randomize();
           `uvm_info("GEN",$sformatf("Data send to Driver abcd :%0d , sel :%0d",t.abcd,t.sel), UVM_NONE);
           finish_item(t);
        end
   endtask
   
endclass



//interface

////////////////////////////////////////////////////////////
interface mux4_1_if();
   logic [3:0] 		      abcd;
   logic [1:0] 		      sel;
   logic  		      y;
endinterface



module tb();
   
/* -----\/----- EXCLUDED -----\/-----
   add_if aif();
   
   initial begin
      aif.clk = 0;
      aif.rst = 0;
   end  
 -----/\----- EXCLUDED -----/\----- */
   
   //always #10 aif.clk = ~aif.clk;
   
   
   //add dut (.a(aif.a), .b(aif.b), .y(aif.y), .clk(aif.clk), .rst(aif.rst));
   
/* -----\/----- EXCLUDED -----\/-----
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
 -----/\----- EXCLUDED -----/\----- */
   
   initial begin  
      //uvm_config_db #(virtual add_if)::set(null, "*", "aif", aif);
      //run_test("test");
   end
   
endmodule
