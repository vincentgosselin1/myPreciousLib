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
`include "uvm_macros.svh"
import uvm_pkg::*;


//////////////////////////////////////////////////transaction
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

////////////////////////////////////////////////////////////////////

class driver extends uvm_driver #(transaction);
   `uvm_component_utils(driver)
   
   function new(input string path = "driver", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   transaction t;
   virtual mux_if vif;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("t");
      if(!uvm_config_db #(virtual mux_if)::get(this,"","vif",vif)) 
        `uvm_error("DRV","Unable to access uvm_config_db");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         vif.abcd <= t.abcd;
         vif.sel  <= t.sel;
         `uvm_info("DRV", $sformatf("Trigger DUT abcd: %0d , sel :  %0d",t.abcd, t.sel), UVM_NONE); 
         seq_item_port.item_done();
         #10;  
      end
   endtask
endclass


class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)
   
   uvm_analysis_port #(transaction) send;
   transaction t;
   virtual mux_if vif;
   
   function new(input string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
      send = new("send", this);
   endfunction
      
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("t");      
      if(!uvm_config_db #(virtual mux_if)::get(this,"","vif",vif)) 
	`uvm_error("MON","Unable to access uvm_config_db");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         #10;
         t.abcd = vif.abcd;
         t.sel = vif.sel;
         t.y = vif.y;
         `uvm_info("MON", $sformatf("Data send to Scoreboard abcd : %0d , sel : %0d and y : %0d", t.abcd,t.sel,t.y), UVM_NONE);
         send.write(t);
      end
   endtask
endclass

//////////////////////////////////////////////////scoreboard
class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)
   
   uvm_analysis_imp #(transaction,scoreboard) imp;
   transaction tr;
   
   function new(input string path = "scoreboard", uvm_component parent = null);
      super.new(path, parent);
      imp = new("imp", this);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tr = transaction::type_id::create("tr");
   endfunction
   
   virtual function void write(input transaction t);
      tr = t;
      `uvm_info("SCO",$sformatf("Data rcvd from Monitor abcd: %0d , sel : %0d and y : %0d",tr.abcd,tr.sel,tr.y), UVM_NONE);      

      //todo later
/* -----\/----- EXCLUDED -----\/-----
      if(tr.sel == tr.a + tr.b)
        `uvm_info("SCO","Test Passed", UVM_NONE)
      else
        `uvm_info("SCO","Test Failed", UVM_NONE);
 -----/\----- EXCLUDED -----/\----- */
   endfunction // write

   //if (tr.sel = "00" and tr.abcd = "0001")
      //begin
      //if(y = '1')
   //test pass
   //else
   //test fail
   
   
   
endclass


//////////////////////////////////////////////////////////////interface
interface mux_if();
   logic [3:0] 		      abcd;
   logic [1:0] 		      sel;
   logic  		      y;
endinterface

//////////////////////////////testbench top

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
