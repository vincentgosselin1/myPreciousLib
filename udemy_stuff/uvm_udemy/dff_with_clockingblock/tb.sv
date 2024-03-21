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
interface dff_if(input bit clk);
   //logic 		      clk;
   logic		      rst;
   logic		      din;
   logic		      ena;
   logic		      dout;

   //SIGNALS DIRECTIONS INSIDE A CLOCKING BLOCK
   //ARE WITH RESPECT TO THE TESTBENCH AND NOT
   //THE DUT
   clocking cb @(posedge clk);
      output		      #1  rst,din,ena;
      input		      #0  dout;
   endclocking // cb

   clocking cb2 @(posedge clk);
      input		      #0 rst,din,ena,dout;
   endclocking // cb

   modport cb_drv_mp (clocking cb);
   modport cb_mon_mp (clocking cb2);
   
endinterface

class transaction extends uvm_sequence_item;
   rand bit		      din;
   rand bit		      ena;
   bit			      dout;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(din, UVM_DEFAULT)
      `uvm_field_int(ena, UVM_DEFAULT)
      `uvm_field_int(dout, UVM_DEFAULT)
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
      repeat(9) 
        begin
           start_item(t);	   
           t.randomize();
           finish_item(t);
	   `uvm_info("GEN",$sformatf("Data send to Driver din :%0d , ena :%0d",t.din,t.ena), UVM_NONE);  
        end
      begin
         start_item(t);
	 t.ena = 1'b1;
	 t.din = 1'b1;	 
         finish_item(t);
	 `uvm_info("GEN",$sformatf("Forcing! Data send to Driver din :%0d , ena :%0d",t.din,t.ena), UVM_NONE);  
      end
   endtask
   
endclass


////////////////////////////////////////////////////////////////////
class driver extends uvm_driver #(transaction);
   `uvm_component_utils(driver)
   
   function new(input string path = "drive", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   transaction data;
   //   virtual dff_if.cb_drv_mp vif;
   virtual dff_if vif; 
   
   
   ///////////////////reset logic
   task reset_dut();
      vif.cb_drv_mp.cb.rst <= 1'b1;
      vif.cb_drv_mp.cb.din   <= 0;
      vif.cb_drv_mp.cb.ena   <= 0;
      //      repeat(5) @(posedge vif.clk);
      repeat(5) @(vif.cb);
      vif.cb_drv_mp.cb.rst <= 1'b0; 
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
         vif.cb_drv_mp.cb.din <= data.din;
         vif.cb_drv_mp.cb.ena <= data.ena;
         seq_item_port.item_done(); 
         `uvm_info("DRV", $sformatf("Trigger DUT din: %0d , ena :  %0d",data.din, data.ena), UVM_NONE);
	 repeat(2)@(vif.cb);
	 //         repeat(2) @(posedge vif.clk);
      end
      
   endtask
endclass

//////////////////////////////monitor
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)
   
   uvm_analysis_port #(transaction) send;
   transaction t;
   //virtual dff_if.cb_mon_mp vif;
   virtual dff_if vif;
   
   function new(input string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
      send = new("send", this);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("transaction");
      if(!uvm_config_db #(virtual dff_if)::get(this,"","vif",vif)) 
	`uvm_error("MON","Unable to access uvm_config_db");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      @(negedge vif.cb_mon_mp.cb2.rst);
      forever begin
	 //         repeat(2)@(posedge vif.clk);
	 repeat(1) @(vif.cb2);	
         t.din = vif.cb_mon_mp.cb2.din;
         t.ena = vif.cb_mon_mp.cb2.ena;
         t.dout = vif.cb_mon_mp.cb2.dout;
         `uvm_info("MON", $sformatf("Data send to Scoreboard din : %0d , ena : %0d and dout : %0d", t.din,t.ena,t.dout), UVM_NONE);
         send.write(t);
      end
   endtask
endclass

//////////////////////////////scoreboard
class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)
   
   uvm_analysis_imp #(transaction,scoreboard) imp;
   
   transaction data;
   
   function new(input string path = "scoreboard", uvm_component parent = null);
      super.new(path, parent);
      imp = new("imp", this);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      data = transaction::type_id::create("data");
   endfunction
   
   virtual function void write(input transaction t);
      data = t;
      `uvm_info("SCO",$sformatf("Data rcvd from Monitor din: %0d , ena : %0d and dout : %0d",t.din,t.ena,t.dout), UVM_NONE);
      
      //Data compare happens here!
      if(data.ena == 1'b1) begin
	 if(data.dout == data.din) begin
	    `uvm_info("SCO","Test Passed", UVM_NONE);	 
	 end else begin
	    `uvm_error("SCO","Test failed");
	 end
      end
      
      
      
      /* -----\/----- EXCLUDED -----\/-----
       if(data.y == data.a + data.b)
       `uvm_info("SCO","Test Passed", UVM_NONE)
       else
       `uvm_info("SCO","Test Failed", UVM_NONE);
       -----/\----- EXCLUDED -----/\----- */
   endfunction
endclass
////////////////////////////////////////////////


class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   
   function new(input string path = "agent", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   monitor m;
   driver d;
   uvm_sequencer #(transaction) seqr;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m = monitor::type_id::create("m",this);
      d = driver::type_id::create("d",this);
      seqr = uvm_sequencer #(transaction)::type_id::create("seqr",this);
   endfunction
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seqr.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   scoreboard s;
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      s = scoreboard::type_id::create("s",this);
      a = agent::type_id::create("a",this);
   endfunction
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      a.m.send.connect(s.imp);
   endfunction
   
endclass

////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   generator gen;
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      gen = generator::type_id::create("gen",this);
      e = env::type_id::create("env",this);
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      gen.start(e.a.seqr);
      #40;
      phase.drop_objection(this);
      
   endtask
endclass
//////////////////////////////////////




//////////////////////////////tb
module tb();
   

   reg clk;
   //, rstn;

   dff_if vif(clk);
   
      initial begin
	 clk = 0;      
	 forever #10 clk = ~clk;
      end
   
   //   initial rstn = 1;
  
   
   //   always #10 vif.clk = ~vif.clk;   
   /* -----\/----- EXCLUDED -----\/-----
    initial begin
    vif.clk = 0;
    vif.cb_drv_mp.rst = 0;
   end  
    
    always #10 vif.clk = ~vif.clk;
    
    -----/\----- EXCLUDED -----/\----- */
   
   //dff dut (.din(vif.cb_drv_mp.cb.din), .ena(vif.cb_drv_mp.cb.ena), .dout(vif.cb_mon_mp.cb2.dout), .clk(vif.clk), .rst(vif.cb_drv_mp.cb.rst));
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
