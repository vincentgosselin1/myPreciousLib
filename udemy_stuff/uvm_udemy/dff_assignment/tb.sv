//                              -*- Mode: Verilog -*-
// Filename        : tb.sv<dff_assignment>
// Description     : Data flip-flop tb, yes the one and only!!!
// Author          : Vincent Gosselin
// Created On      : Sun Mar 17 18:21:10 2024
// Last Modified By: Vincent Gosselin
// Last Modified On: Sun Mar 17 18:21:10 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!



`timescale 1ns / 1ps


/////////////////////////Transaction
`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////////////////interface
interface dff_if();
   logic 		      clk;
   logic		      rst;
   logic		      din;
   logic		      ena;
   logic		      dout;
endinterface

class transaction extends uvm_sequence_item;
   rand bit		      din;
   rand bit		      ena;
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(din, UVM_DEFAULT)
      `uvm_field_int(ena, UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass


//////////////////////////////////////////////////////////////
class generator extends uvm_sequence #(transaction);
   `uvm_object_utils(generator)
   
   transaction t;
   
   
   function new(input string path = "generator");
      super.new(path);
   endfunction
   
   
   virtual task body();
      t = transaction::type_id::create("t");
      repeat(10) 
        begin
           start_item(t);
           t.randomize();
           finish_item(t);
	   `uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.din,t.ena), UVM_NONE);  
        end
   endtask
   
endclass


////////////////////////////////////////////////////////////////////
class driver extends uvm_driver #(transaction);
   `uvm_component_utils(driver)
   
   function new(input string path = "drive", uvm_component parent);
      super.new(path, parent);
   endfunction
   
   transaction data;
   virtual dff_if vif;
   
   
   
   ///////////////////reset logic
   task reset_dut();
      vif.rst <= 1'b1;
      vif.din   <= 0;
      vif.ena   <= 0;
      repeat(5) @(posedge vif.clk);
      vif.rst <= 1'b0; 
      `uvm_info("DRV", "Reset Done", UVM_NONE);
   endtask
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      data = transaction::type_id::create("data");
      
      if(!uvm_config_db #(virtual dff_if)::get(this,"","vif",vif)) 
	`uvm_error("DRV","Unable to access uvm_config_db");
   endfunction
   
   
   
   virtual task run_phase(uvm_phase phase);
      reset_dut();
      forever begin 
         seq_item_port.get_next_item(data);
         vif.din <= data.din;
         vif.ena <= data.ena;
         seq_item_port.item_done(); 
         `uvm_info("DRV", $sformatf("Trigger DUT ena: %0d , din :  %0d",data.ena, data.din), UVM_NONE); 
         repeat(2) @(posedge vif.clk);
      end
      
   endtask
endclass




//////////////////////////////tb
module tb();
   

   dff_if vif();
   
   initial begin
      vif.clk = 0;
      vif.rst = 0;
   end  
   
   always #10 vif.clk = ~vif.clk;
   
   
   dff dut (.din(vif.din), .ena(vif.ena), .dout(vif.dout), .clk(vif.clk), .rst(vif.rst));
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   initial begin  
      uvm_config_db #(virtual dff_if)::set(null, "*", "vif", vif);
      run_test("test");
   end
   
endmodule
