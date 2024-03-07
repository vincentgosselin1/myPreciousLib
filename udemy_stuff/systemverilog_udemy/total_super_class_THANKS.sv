class first;
   bit x = 1'b1;
endclass


module tb();

   first f1; // Name of the Instance

   initial begin
      f1 = new();
      $display("-------------------------------");
      $display("The value of the x is %0b",f1.x);
      $display("-------------------------------");
   end

endmodule

class temp;
   bit [3:0] a = 4'b1101;
endclass


module tb;

   temp t; ///create handler

   initial begin
      t = new();
      $display("value of a :: %b", t.a);
   end

endmodule // tb

class temp;
   
   function bit [8:0] add (input bit [7:0] a,input bit [7:0] b);
      return a + b;
   endfunction
   
   
endclass

module tb;
   
   temp t;
   bit [8:0] result;
   
   initial begin
      t = new();
      result = t.add(8'h12 , 8'h23);
      #10;
      $display("Result : %0d",result);
   end
   
   
   
   
   
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class temp;
	 
	 bit [7:0] data;
	 
	 function void read(input bit [7:0] data);
            this.data = data;   
	 endfunction
	 
      endclass


module tb;
   
   temp t;
   
   initial begin
      t = new();
      t.read(8'b11111111);
      #10;
      $display("Value of data member : %0b",t.data);
   end
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class parent;
	 int x =23;
      endclass

class derived extends parent;
   int 	     y =34;
endclass

module tb();
   derived d1;
   
   initial begin
      d1 = new();
      $display("The value x and y inside derived class is %0d and %0d respectively ", d1.x,d1.y);
   end
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class temp;
	 
	 rand  bit [3:0] d1;
	 rand  bit [3:0] d2;
	 rand  bit [31:0] d3;
	 
      endclass


module tb;
   
   temp t;
   integer i;
   
   initial begin
      t = new();
      for( i = 0; i<20; i++)begin
         t.randomize();
         $display("Value d1 : %0d, d2: %0d and d3 : %0d",t.d1,t.d2,t.d3);  
         #10;
      end
   end
   
   
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class temp;
	 
	 rand  bit [3:0] d1;
	 rand  bit [3:0] d2;
	 rand  bit [31:0] d3;
	 
      endclass


module tb;
   
   temp t;
   integer i;
   
   initial begin
      t = new();
      for( i = 0; i<20; i++)begin
         t.randomize();
         $display("Value d1 : %0d, d2: %0d and d3 : %0d",t.d1,t.d2,t.d3);  
         #10;
      end
   end
   
   
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code





      //////////////////////////////External Constraint Example


      class temp;
	 randc bit [3:0] d;
	 
	 extern constraint d_constraint;
	 
      endclass


constraint temp::d_constraint {d > 10; d < 15;}; 

module tb;
   
   temp t;
   integer i;
   
   initial begin
      t = new();
      for(i =0; i<5;i++) begin
         t.randomize();
         $display("value of d:%0d",t.d);
         #10;
      end
   end
   
   
endmodule


///////////////////////////Internal Constraint Example //////////////////////////////


class temp;
   randc bit [3:0] d;
   
   constraint d_constraint {d > 10; d < 15;}; 
   
endclass



module tb;
   
   temp t;
   integer i;
   
   initial begin
      t = new();
      for(i =0; i<5;i++) begin
         t.randomize();
         $display("value of d:%0d",t.d);
         #10;
      end
   end
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      ////////////////////////Method 1//////////////////////////////////////////


      class temp;
	 
	 randc bit [3:0] a;
	 
	 constraint a_constraint {a > 11; a <11;};
	 
      endclass

module tb;
   temp t;
   integer i;
   
   initial begin
      t = new();
      for(i = 0; i <10; i++) begin
         assert(t.randomize())
           else $fatal("[GEN] : Randomization fails");
         
         $display("Value of a :%0d",t.a);
         #10;
         
      end
      
   end
   
   
   
endmodule


///////////////////////Method 2/////////////////////////////////


class temp;
   
   randc bit [3:0] a;
   
   constraint a_constraint {a > 11; a <11;};
   
endclass

module tb;
   temp t;
   integer i;
   
   initial begin
      t = new();
      for(i = 0; i <10; i++) begin
         if(!t.randomize() ) begin
            $fatal("[GEN] : Randomization fails");
         end
         $display("Value of a :%0d",t.a);
         #10;
         
      end
      
   end
   
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class temp;
	 randc bit [3:0] d;
	 
	 constraint d_constraint {d > 10; d < 15;}; 
	 
	 function void post_randomize();
            $display("[TEMP] : value of a : %0d",d);   
	 endfunction
	 
      endclass



module tb;
   
   temp t;
   integer i;
   
   initial begin
      t = new();
      for(i =0; i<5;i++) begin
         t.randomize();
         $display("value of d:%0d",t.d);
         #10;
      end
   end
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class process1;
	 
	 task run();
            #6;
            $display("Process 1 complete at %0t",$time);
	 endtask
	 
	 
      endclass


class process2;
   
   task run();
      #3; 
      $display("Process 2 complete at %0t",$time);
   endtask
   
   
endclass


module tb;
   
   process1 p1;
   process2 p2;
   
   initial begin
      p1 = new();
      p2 = new();
      
      fork
         p1.run();
         p2.run();
      join_none
      
      
      $display("All processes completed at %0t",$time);
      
   end
   
   
   
   
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      module tb;
   
   event a;
   
   
   initial begin
      
      
      fork
	 
	 begin
	    #20;
	    -> a;
	 end
	 
	 
	 begin
            @(a.triggered); //@() , wait
            $display("Event Triggered at %0t",$time);
	    
	 end
	 
	 
      join
      
      
   end
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      module tb;
   
   mailbox mbx;
   integer i;
   integer data;
   
   initial begin
      mbx = new();
      
      
      fork
         
         begin
            
            for(i =0; i <20; i++) begin
               mbx.put(i);
               $display("Data Send : %0d",i);
               #10;
            end
            
         end
         
         begin
            
            forever begin
               mbx.get(data);
               $display("Value rcvd : %0d",data);
               #10;
            end
            
         end
	 
	 
      join
      
      
   end
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class transaction;
	 randc bit [3:0] a;
	 randc bit [3:0] b;
      endclass




class generator;
   transaction t;
   mailbox mbx;
   event   done;
   integer i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task main();
      for(i = 0; i <10; i++)begin
	 t = new();
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] :  Send Data to Driver");
	 #1;
      end
      ->done;
   endtask
endclass


class driver;
   mailbox mbx;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task main();
      forever begin
	 t = new();
	 mbx.get(t);
	 $display("[DRV] : Rcvd Data from Generator");
	 #1;
      end
   endtask
   
   
endclass





module tb();
   
   transaction t;
   generator gen;
   driver drv;
   mailbox mbx;
   
   initial begin
      mbx = new();
      gen = new(mbx);
      drv = new(mbx);
      
      fork
	 gen.main();
	 drv.main();
      join_any
      wait(gen.done.triggered);
   end
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      interface add_intf();
   logic [7:0] a;
   logic [7:0] b;
   logic [8:0] sum;
endinterface


module tb;
   
   add_intf vif();
   
   initial begin
      vif.a = $urandom;
      vif.b = $urandom;
      $display("Value of a :%0d and b : %0d",vif.a, vif.b);
   end
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////////Design Code /////////////////////////////////

      module mux (
		  input [3:0] 	   a,b,c,d,
		  input [1:0] 	   sel,
		  output reg [3:0] y
		  );
   
   always@(*)
     begin
        case(sel)
          2'b00: y = a;
          2'b01: y = b;  
          2'b10: y = c;
          2'b11: y = d;
          default:y = a;
        endcase
     end
   
   
endmodule


////////////////////Testbench Code/////////////////////////////////////////

interface mux_intf();
   logic [3:0] a,b,c,d;
   logic [1:0] sel;
   logic [3:0] y;
endinterface


module tb;
   
   mux_intf vif();
   
   mux dut (.a(vif.a), .b(vif.b), .c(vif.c), .d(vif.d), .sel(vif.sel), .y(vif.y));
   
   initial begin
      vif.a = 0;
      vif.b = 0;
      vif.c = 0;
      vif.d = 0; 
      vif.sel = 0; 
   end
   
   always #5 vif.a = ~vif.a;
   always #10 vif.b = ~vif.b;
   always #15 vif.c = ~vif.c;
   always #20 vif.d = ~vif.d;
   
   
   integer i;
   initial begin
      for(i = 0; i <25; i++) begin
         vif.sel = $urandom;
         #10;
      end
      
   end
   
   initial begin
      #300;
      $finish;
   end
   
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd"); 
   end
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      ///////////////////////Design Code /////////////////////////////

      module mul(
		 input [7:0]   a,b,
		 output [15:0] y
		 );
   
   assign y = a * b;  
   
endmodule


////////////////////////////////Testbench Code////////////////////////////

interface mul_intf();
   logic [7:0] 		       a;
   logic [7:0] 		       b;
   logic [15:0] 	       y;
endinterface


module tb;
   
   mul_intf vif();
   
   mul dut (vif.a,vif.b,vif.y);
   
   integer i;
   
   initial begin
      for(i = 0; i < 20; i++) begin  
         vif.a = $urandom;
         vif.b = $urandom;
         #10;
      end
   end
   
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");  
   end
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////////////////Design Code ///////////////////////////

      module counter(
		     input 	      clk,rst,up,
		     output reg [3:0] dout
		     );
   
   always@(posedge clk)
     begin
        if(rst == 1'b1)
          dout <= 4'b0000;
        else begin
           if(up == 1'b1)
             dout <= dout + 1;
           else
             dout <= dout -1;
        end
	
     end
endmodule


/////////////////////////Testbench Code/////////////////////////////////////////

interface counter_intf();
   
   logic clk,rst,up;
   logic [3:0] dout;
   
endinterface

module tb;
   
   counter_intf vif();
   
   counter dut (vif.clk, vif.rst, vif.up, vif.dout);
   
   initial begin
      vif.clk = 0;
      vif.up = 0;
      vif.rst = 0;  
   end
   
   always #5 vif.clk = ~vif.clk;
   
   initial begin
      vif.rst = 1;
      #30;
      vif.rst = 0;
      #200;
      vif.rst = 1;
      #100;
      vif.rst = 0;
   end
   
   integer i;
   initial begin
      for(i=0;i<50;i++)begin
         vif.up = $urandom;
         @(posedge vif.clk);
      end
   end
   
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");    
   end
   
   initial begin
      #500;
      $finish;
   end
   
   
   
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      ////////////////////////////Design Code//////////////////////////////////

      module or4(
		 input [3:0]  a,b,
		 output [3:0] y
      
		 );
   
   assign y = a | b;
   
endmodule

///////////////////////////Testbench Code ////////////////////////////////

class driver;
   
   virtual 		      or4_intf vif;
   integer 		      i;
   
   
   task run();
      for(i = 0; i < 50; i++) begin
         vif.a = $urandom;
         vif.b = $urandom;
         #10;
      end  
   endtask
   
   
   
endclass

interface or4_intf();
   logic [3:0] a;
   logic [3:0] b;
   logic [3:0] y;
endinterface

module tb;
   
   or4_intf vif();
   driver drv;
   
   or4 dut (vif.a,vif.b,vif.y);
   
   initial begin
      drv = new();
      drv.vif = vif;
      drv.run(); 
   end
   
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      //////////////////////////////Design Code

      module xor4(
		  input [3:0]  a,b,
		  output [3:0] y
      
		  );
   
   assign y = a ^ b;
   
   
endmodule


////////////////Testbench Code////////////////////////

class transaction;
   randc bit [3:0] a;
   randc bit [3:0] b;
   bit [3:0] 		       y;
endclass

class generator;
   transaction t;
   mailbox 		       mbx;
   event 		       done;
   integer 		       i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 25; i++) begin
         t.randomize();
         mbx.put(t);
         $display("[GEN] : Data send to Driver");
         #10;
      end
      -> done;
   endtask
   
endclass


interface xor4_intf();
   logic [3:0] a;
   logic [3:0] b;
   logic [3:0] y;
   
endinterface


class driver;
   
   transaction t;
   mailbox     mbx;
   
   virtual     xor4_intf vif;
   
   
   function new(mailbox mbx);
      this.mbx = mbx;    
   endfunction
   
   task run();
      t = new();
      forever begin
         mbx.get(t);
         vif.a = t.a;
         vif.b = t.b;
         $display("[DRV] : Trigger Interface");
         #10;
      end
   endtask
   
endclass

module tb;
   
   generator gen;
   driver drv;
   mailbox gdmbx;
   
   xor4_intf vif();
   
   xor4 dut (vif.a,vif.b, vif.y);
   
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
   
   
   initial begin 
      gdmbx = new();
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      drv.vif = vif;
      
      fork
         gen.run();
         drv.run();
      join_any
      wait(gen.done.triggered);
   end
   
endmodule




Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class monitor;
	 
	 mailbox mbx;
	 integer data = 12;
	 
	 function new(mailbox mbx);
            this.mbx  = mbx; 
	 endfunction
	 
	 task run();
            mbx.put(data);
            $display("[MON] : Data send to Scoreboard : %0d",data);
            #10;    
	 endtask
	 
      endclass

class scoreboard;
   
   mailbox mbx;
   integer c;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
         mbx.get(c);
         $display("[SCO] :  Value rcvd : %0d",c);
     	 #10;	   
      end
   endtask
endclass

module tb;
   
   monitor mon;
   scoreboard sco;
   mailbox msmbx;
   
   initial begin
      msmbx = new();
      mon = new(msmbx);
      sco = new(msmbx);
      
      fork 
         mon.run(); 
         sco.run();
      join  
      
      
      
   end   
   
   
   
endmodule




Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      class transaction;
	 bit [3:0] a;
	 bit [3:0] b;
	 bit [3:0] y;
	 
      endclass

interface top_intf();
   logic [3:0] 	   a;
   logic [3:0] 	   b;
   logic [3:0] 	   y;
endinterface

class monitor;
   transaction t;
   mailbox 	   mbx;
   
   virtual 	   top_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      t.a = vif.a;
      t.b = vif.b;
      t.y = vif.y;
      mbx.put(t);
      $display("[MON] : data send to Scoreboard");
      #10;
   endtask
   
endclass


class scoreboard;
   transaction t;
   mailbox mbx;
   bit [3:0] temp;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
         mbx.get(t);
         temp = t.a & t.b;
         if(t.y == temp)
           begin
              $display("[SCO] : Test Passed");
              $display("[SCO] : a : %b and b : %b gives temp : %b and y : %b ",t.a, t.b, temp, t.y);
           end
         else
           begin
              $display("[SCO] : Test Failed");
           end
         #10;
      end
   endtask
   
endclass






module tb;
   
   top_intf vif();
   monitor mon;
   scoreboard sco;
   mailbox msmbx;
   
   
   top dut (.a(vif.a), .b(vif.b), .y(vif.y));
   
   initial begin
      vif.a = $random();
      vif.b = $random();
   end
   
   initial begin
      msmbx = new();
      mon = new(msmbx);
      sco = new(msmbx);
      
      mon.vif = vif;
      
      fork 
         mon.run();  
         sco.run();
      join
      
   end
   
   
   
   
endmodule


Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      module andt (
		   input [7:0] 	a,b,
		   output [7:0] y
		   );
   
   assign y = a & b;
   
endmodule

class transaction;
   randc bit [7:0] a;
   randc bit [7:0] b;
   bit [7:0] 			y;
endclass

class generator;
   transaction t;
   mailbox 			mbx;
   event 			done;
   integer 			i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i =0; i< 20; i++) begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN]: Data send to driver");
	 @(done);
	 #10;
      end
   endtask
endclass

interface andt_intf();
   logic [7:0] a;
   logic [7:0] b;
   logic [7:0] y;
endinterface

class driver;
   mailbox     mbx;
   transaction t;
   event       done;
   
   virtual     andt_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   
   task run();
      t= new();
      forever begin
	 mbx.get(t);
	 vif.a = t.a;
	 vif.b = t.b;
	 $display("[DRV] : Trigger Interface");
	 ->done; 
	 #10;
      end
   endtask
   
   
endclass

class monitor;
   virtual andt_intf vif;
   mailbox mbx;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 t.a = vif.a;
	 t.b = vif.b;
	 t.y = vif.y;
	 mbx.put(t);
	 $display("[MON] : Data send to Scoreboard");
	 #10;
      end
   endtask
endclass   

class scoreboard;
   mailbox mbx;
   transaction t;
   bit [7:0] temp; 
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 temp = t.a & t.b;
	 if(t.y == temp)
	   begin
	      $display("[SCO] : Test Passed");
	   end
	 else 
	   begin
	      $display("[SCO] : Test Failed");
	   end
	 #10;
      end
   endtask
endclass  

class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual andt_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass

module tb();
   
   environment env;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   andt_intf vif();
   
   andt dut (vif.a, vif.b,vif.y);
   
   initial begin
      gdmbx = new();
      msmbx = new();
      env = new(gdmbx, msmbx);
      env.vif = vif;
      env.run();
      #200;
      $finish;
   end
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

`timescale 1ns/1ps
     
      module add(
		 input [7:0]  a,b,
		 output [8:0] sum 
		 );
   
   assign sum = a + b;
   
endmodule

class transaction;
   randc bit [7:0] a;
   randc bit [7:0] b;
   bit [8:0] 		      sum;
endclass

class generator;
   mailbox 		      mbx;
   event 		      done;
   transaction t;
   integer 		      i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task main();
      t = new();
      for(i = 0; i < 25; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to Driver");
	 @(done);
	 #10;
      end
   endtask
endclass

interface add_intf();
   logic [7:0] a;
   logic [7:0] b;
   logic [8:0] sum;
endinterface

class driver;
   mailbox     mbx;
   transaction t;
   event       done;
   virtual     add_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task main();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.a = t.a;
	 vif.b = t.b;
	 $display("[DRV] : Interface is triggered");
	 -> done;
	 #10;
      end
   endtask
   
endclass  


class monitor;
   virtual add_intf vif;
   mailbox mbx;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task main();
      t = new();
      forever begin
	 t.a = vif.a;
	 t.b = vif.b;
	 t.sum = vif.sum;
	 mbx.put(t);
	 $display("[MON] : Data send to Scoreboard");
	 #10;
      end
   endtask
   
endclass


class scoreboard;
   mailbox mbx;
   transaction t;
   bit [8:0] temp;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task main();
      t = new();
      forever begin
	 mbx.get(t);
	 temp = t.a + t.b;
	 if(t.sum == temp)
	   begin
	      $display("[SCO] :Test Passed");
	   end
	 else
	   begin
	      $display("[SCO] :Test Failed");
	   end
	 #10;
      end
   endtask
endclass

class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   mailbox gdmbx, msmbx;
   
   virtual add_intf vif;
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      gen = new(gdmbx);
      drv = new(gdmbx);
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task main();
      drv.vif = vif;
      mon.vif = vif;
      
      gen.done = gddone;
      drv.done = gddone;
      
      fork
	 gen.main();
	 drv.main();
	 mon.main();
	 sco.main();
      join_any
      
   endtask
endclass

module tb();
   environment e;
   mailbox gdmbx, msmbx;
   
   add_intf vif();
   
   add dut (vif.a, vif.b, vif.sum);
   
   initial begin
      gdmbx = new();
      msmbx = new();
      e = new(gdmbx,msmbx);
      e.vif = vif;
      e.main();
      #500;
      $finish;
   end
   
   
   
endmodule




Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      module andt (
		   input 	    clk, rst, up, load,
		   input [7:0] 	    loadin,
		   output reg [7:0] y
		   );
   
   always@(posedge clk)
     begin
	if(rst == 1'b1)
	  y <= 8'b00000000;
	else if (load == 1'b1)
	  y <= loadin;
	else begin
	   if(up == 1'b1)
	     y <= y + 1;
	   else
	     y <= y - 1;
	end
     end
endmodule

class transaction;
   randc bit [7:0] loadin;
   bit [7:0] y;
endclass

class generator;
   transaction t;
   mailbox   mbx;
   event     done;
   integer   i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      t.randomize();
      mbx.put(t);
      $display("[GEN]: Data send to driver");
      @(done);
   endtask
endclass

interface andt_intf();
   logic clk,rst, up, load;
   logic [7:0] loadin;
   logic [7:0] y;
endinterface

class driver;
   mailbox     mbx;
   transaction t;
   event       done;
   
   virtual     andt_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   
   task run();
      t= new();
      forever begin
	 mbx.get(t);
	 vif.loadin = t.loadin;
	 $display("[DRV] : Trigger Interface");
	 ->done; 
	 @(posedge vif.clk);
      end
   endtask
   
   
endclass

class monitor;
   virtual andt_intf vif;
   mailbox mbx;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 t.loadin = vif.loadin;
	 t.y = vif.y;
	 mbx.put(t);
	 $display("[MON] : Data send to Scoreboard");
	 @(posedge vif.clk);
      end
   endtask
endclass   

class scoreboard;
   mailbox mbx;
   transaction t;
   bit [7:0] temp; 
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
      end
   endtask
endclass  

class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual andt_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass

module tb();
   
   environment env;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   andt_intf vif();
   
   andt dut ( vif.clk, vif.rst, vif.up, vif.load,  vif.loadin, vif.y );
   
   always #5 vif.clk = ~vif.clk;
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      vif.up = 0;
      vif.load = 0;
      #20;
      vif.load = 1;
      #50;
      vif.load =0;
      #100;
      vif.rst = 0;
      #100;
      vif.up = 1;
      #100;
      vif.up =0;
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      env = new(gdmbx, msmbx);
      env.vif = vif;
      env.run();
      #500;
      $finish;
   end
   
endmodule




Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      module ram(
		 input 		  clk, rst, wr,
		 input [7:0] 	  din, addr,
		 output reg [7:0] dout
		 );
   reg [7:0] 			  mem [256];
   integer 			  i;
   
   always@(posedge clk)
     begin
	if(rst == 1'b1) begin
	   for( i = 0; i < 256; i++)
	     begin
		mem[i] <= 0;
	     end
	end
	else if(wr == 1'b1)
	  mem[addr] <= din;
	else
	  dout <= mem[addr];
     end
endmodule


class transaction;
   rand bit [7:0] din;
   rand bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
endclass

class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver");
	 @(done);
      end
   endtask
endclass


interface counter_intf();
   logic clk,rst, wr;
   logic [7:0] din, addr;
   logic [7:0] dout;
endinterface

class driver;
   mailbox     mbx;
   event       done;
   transaction t;
   virtual     counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger");
	 ->done;
	 @(posedge vif.clk);
      end
   endtask
endclass  

class monitor;
   mailbox mbx;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 t.din = vif.din;
	 t.addr = vif.addr;
	 t.dout = vif.dout;
	 t.wr = vif.wr;
	 mbx.put(t);
	 $display("[MON] : data send to Scoreboard");
	 @(posedge vif.clk);
      end
   endtask
endclass

class scoreboard;
   mailbox mbx;
   transaction tarr[256];
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 
	 if(t.wr == 1'b1) begin
	    if(tarr[t.addr] == null) begin
               tarr[t.addr] = new();
               tarr[t.addr] = t;
               $display("[SCO] : Data stored");
            end
         end
	 else begin
	    if(tarr[t.addr] == null) begin
               if(t.dout == 0) 
		 $display("[SCO] : Data read Test Passed");
               else
		 $display("[SCO] : Data read Test Failed"); 
            end
            else begin
               if(t.dout == tarr[t.addr].din)
		 $display("[SCO] : Data read Test Passed");
               else
		 $display("[SCO] : Data read Test Failed"); 
            end
         end
      end
   endtask
endclass

class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass

module tb;
   
   environment env;
   counter_intf vif();
   mailbox gdmbx, msmbx;
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   always #5 vif.clk = ~vif.clk;
   
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      vif.wr = 1;
      #50;
      vif.wr = 1;
      vif.rst = 0;
      #300;
      vif.wr = 0;
      #200
	vif.rst = 0;
      #50;
      
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      
      env = new(gdmbx,msmbx);
      env.vif = vif;
      env.run();
      #600;
      $finish;
   end
   
   
   
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      ////////////////////Top Module


      module ram(

		 input 		  clk, rst, wr,

		 input [7:0] 	  din, addr,

		 output reg [7:0] dout

		 );

   reg [7:0] 			  mem [256];

   integer 			  i;


   always@(posedge clk)

     begin

	if(rst == 1'b1) begin

	   for( i = 0; i < 256; i++)

	     begin

		mem[i] <= 0;

	     end

	end

	else if(wr == 1'b1)

	  mem[addr] <= din;

	else

	  dout <= mem[addr];

     end

endmodule


///////////////////////////////////////////////////Interface


interface counter_intf();

   logic clk,rst, wr;

   logic [7:0] din, addr;

   logic [7:0] dout;

endinterface












/////////////////////Transaction

class transaction;

   rand bit [7:0] din;

   randc bit [7:0] addr;

   bit 		  wr;

   bit [7:0] 	  dout;

   

   constraint addr_c {addr > 10; addr < 18;}; 

endclass



/////////////////////Generator

class generator;

   mailbox 	  mbx;

   transaction t;

   event 	  done;

   integer 	  i;


   function new(mailbox mbx);

      this.mbx = mbx;

   endfunction


   task run();

      t = new();

      for(i = 0; i < 100; i++)begin

	 t.randomize();

	 mbx.put(t);

	 $display("[GEN] : Data send to driver");

	 @(done);

      end

   endtask

endclass


////////////////////Driver


class driver;

   mailbox mbx;

   event   done;

   transaction t;

   virtual counter_intf vif;


   function new(mailbox mbx);

      this.mbx = mbx;

   endfunction


   task run();

      t = new();

      forever begin

	 mbx.get(t);

	 vif.din = t.din;

	 vif.addr = t.addr;

	 $display("[DRV] : Interface Trigger");

	 ->done;

	 @(posedge vif.clk);

      end

   endtask

endclass 



////////////////////Monitor

class monitor;

   mailbox mbx;

   virtual counter_intf vif;

   transaction t;


   function new(mailbox mbx);

      this.mbx = mbx;

   endfunction


   task run();

      t = new();

      forever begin

	 t.din = vif.din;

	 t.addr = vif.addr;

	 t.dout = vif.dout;

	 t.wr = vif.wr;

	 mbx.put(t);

	 $display("[MON] : data send to Scoreboard");

	 @(posedge vif.clk);

      end

   endtask

endclass



////////////////Scoreboard

class scoreboard;

   mailbox mbx;

   transaction tarr[256];

   transaction t;


   function new(mailbox mbx);

      this.mbx = mbx;

   endfunction


   task run();

      forever begin

	 mbx.get(t);


	 if(t.wr == 1'b1) begin

	    if(tarr[t.addr] == null) begin

	       tarr[t.addr] = new();

	       tarr[t.addr] = t;

	       $display("[SCO] : Data stored");

	    end

	 end

	 else begin

	    if(tarr[t.addr] == null) begin

	       if(t.dout == 0)

		 $display("[SCO] : Data read Test Passed");

	       else

		 $display("[SCO] : Data read Test Failed");

	    end

	    else begin

	       if(t.dout == tarr[t.addr].din)

		 $display("[SCO] : Data read Test Passed");

	       else

		 $display("[SCO] : Data read Test Failed");

	    end

	 end

      end

   endtask

endclass



//////////////////////Env

class environment;

   generator gen;

   driver drv;

   monitor mon;

   scoreboard sco;


   virtual counter_intf vif;


   mailbox gdmbx;

   mailbox msmbx;


   event   gddone;


   function new(mailbox gdmbx, mailbox msmbx);

      this.gdmbx = gdmbx;

      this.msmbx = msmbx;

      gen = new(gdmbx);

      drv = new(gdmbx);


      mon = new(msmbx);

      sco = new(msmbx);

   endfunction


   task run();

      gen.done = gddone;

      drv.done = gddone;


      drv.vif = vif;

      mon.vif = vif;


      fork

	 gen.run();

	 drv.run();

	 mon.run();

	 sco.run();

      join_any


   endtask


endclass



////////////////////Testbench Top

module tb;


   environment env;

   counter_intf vif();

   mailbox gdmbx, msmbx;


   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);


   always #5 vif.clk = ~vif.clk;



   initial begin

      vif.clk = 0;

      vif.rst = 1;

      #50;

      vif.wr = 1;

      vif.rst = 0;

      #250;

      vif.wr = 0;

   end


   initial begin

      gdmbx = new();

      msmbx = new();


      env = new(gdmbx,msmbx);

      env.vif = vif;

      #50; 

      env.run();

      #600;

      $finish;

   end


   initial begin

      $dumpfile("dump.vcd");

      $dumpvars;

   end




endmodule





Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////Transaction
class transaction;
   rand bit [7:0] din;
   randc bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
   
   constraint addr_c {addr > 10; addr < 18;};  
endclass


/////////////////////Generator
class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver din : %0d and addr : %0d",t.din, t.addr);
	 @(done);
      end
   endtask
endclass

////////////////////Driver

class driver;
   mailbox mbx;
   event   done;
   transaction t;
   virtual counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger wr : %0b addr : %0d din : %0d",vif.wr, t.addr, t.din);
	 @(posedge vif.clk);
	 ->done;
	 
      end
   endtask
endclass  


////////////////////Monitor
class monitor;
   mailbox mbx;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 t.din = vif.din;
	 t.addr = vif.addr;
	 t.dout = vif.dout;
	 t.wr = vif.wr;
	 mbx.put(t);
	 $display("[MON] : data send to SCO wr :%0b din : %0d addr : %0d dout : %0d ", t.wr,t.din,t.addr,t.dout);
	 @(posedge vif.clk);
      end
   endtask
endclass


////////////////Scoreboard
class scoreboard;
   mailbox mbx;
   transaction tarr[256];
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 $display("[SCO] : Data stored wr :%0b din : %0d addr : %0d dout : %0d ", t.wr,t.din,t.addr,t.dout);
	 
	 /*
	  if(t.wr == 1'b1) begin
	  if(tarr[t.addr] == null) begin
          tarr[t.addr] = new();
          tarr[t.addr] = t;
          $display("[SCO] : Data stored");
         end
        end
	  else begin
	  if(tarr[t.addr] == null) begin
          if(t.dout == 0) 
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
          else begin
          if(t.dout == tarr[t.addr].din)
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
        end
	  */   
      end
   endtask
endclass


//////////////////////Env
class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass


////////////////////Testbench Top
module tb;
   
   environment env;
   counter_intf vif();
   mailbox gdmbx, msmbx;
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   always #5 vif.clk = ~vif.clk;
   
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      #50;
      vif.wr = 1;
      vif.rst = 0;
      #250;
      vif.wr = 0;
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      
      env = new(gdmbx,msmbx);
      env.vif = vif;
      #50;  
      env.run();
      #600;
      $finish;
   end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   
   
endmodule




Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////Transaction
class transaction;
   rand bit [7:0] din;
   randc bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
   
   constraint addr_c {addr > 10; addr < 18;};  
endclass


/////////////////////Generator
class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver din : %0d and addr : %0d",t.din, t.addr);
	 @(done);
      end
   endtask
endclass

////////////////////Driver

class driver;
   mailbox mbx;
   event   done;
   transaction t;
   virtual counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger wr : %0b addr : %0d din : %0d",vif.wr, t.addr, t.din);
	 @(posedge vif.clk);
	 
	 
	 if(vif.wr == 1'b0) begin
            @(posedge vif.clk);
	 end
	 
	 ->done;
	 
	 
	 
      end
   endtask
endclass  


////////////////////Monitor
class monitor;
   mailbox mbx;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 @(posedge vif.clk);
	 
	 if(t.wr == 1'b1) begin  
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = 0;
	    t.wr = vif.wr;
	 end
	 
	 if(t.wr == 1'b0) begin 
	    @(posedge vif.clk); 
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = vif.dout;
	    t.wr = vif.wr; 
	 end  
	 
         
	 mbx.put(t);
	 $display("[MON] : data send to SCO wr :%0b din : %0d addr : %0d dout : %0d ", t.wr,t.din,t.addr,t.dout); 
      end
   endtask
endclass


////////////////Scoreboard
class scoreboard;
   mailbox mbx;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 
	 
	 
	 
	 
	 
	 
	 /*
	  if(t.wr == 1'b1) begin
	  if(tarr[t.addr] == null) begin
          tarr[t.addr] = new();
          tarr[t.addr] = t;
          $display("[SCO] : Data stored");
         end
        end
	  else begin
	  if(tarr[t.addr] == null) begin
          if(t.dout == 0) 
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
          else begin
          if(t.dout == tarr[t.addr].din)
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
        end
	  */   
      end
   endtask
endclass


//////////////////////Env
class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass


////////////////////Testbench Top
module tb;
   
   environment env;
   counter_intf vif();
   mailbox gdmbx, msmbx;
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   always #5 vif.clk = ~vif.clk;
   
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      #50;
      vif.wr = 1;
      vif.rst = 0;
      #250; 
      vif.wr = 0;
      #200;  
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      
      env = new(gdmbx,msmbx);
      env.vif = vif;
      #50;  
      env.run();
      #600;
      $finish;
   end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////Transaction
class transaction;
   rand bit [7:0] din;
   randc bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
   
   constraint addr_c {addr > 10; addr < 18;};  
endclass


/////////////////////Generator
class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver din : %0d and addr : %0d",t.din, t.addr);
	 @(done);
      end
   endtask
endclass

////////////////////Driver

class driver;
   mailbox mbx;
   event   done;
   transaction t;
   virtual counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger wr : %0b addr : %0d din : %0d",vif.wr, t.addr, t.din);
	 @(posedge vif.clk);
	 
	 
	 if(vif.wr == 1'b0) begin
            @(posedge vif.clk);
	 end
	 
	 ->done;
	 
	 
	 
      end
   endtask
endclass  


////////////////////Monitor
class monitor;
   mailbox mbx;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 @(posedge vif.clk);
	 
	 if(t.wr == 1'b1) begin  
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = 0;
	    t.wr = vif.wr;
	 end
	 
	 if(t.wr == 1'b0) begin 
	    @(posedge vif.clk); 
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = vif.dout;
	    t.wr = vif.wr; 
	 end  
	 
         
	 mbx.put(t);
	 $display("[MON] : data send to SCO wr :%0b din : %0d addr : %0d dout : %0d ", t.wr,t.din,t.addr,t.dout); 
      end
   endtask
endclass


////////////////Scoreboard
class scoreboard;
   mailbox mbx;
   //transaction tarr[256];
   
   reg [7:0] tarr[256] = '{default:0}; 
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 
	 
	 if(t.wr == 1'b1) begin
            tarr[t.addr] = t.din;
            $display("[SCO] : Data stored din : %0d addr : %0d ", t.din,t.addr);
	 end
	 
	 if(t.wr == 1'b0) begin
            if(t.dout == 0)
              $display("[SCO] : No Data Written at this Location Test Passed");
            else if (t.dout == tarr[t.addr])
              $display("[SCO] : Valid Data found Test Passed");
            else
              $display("[SCO] : Test Failed");   
	 end
	 
	 
	 
	 
	 
	 
	 /*
	  if(t.wr == 1'b1) begin
	  if(tarr[t.addr] == null) begin
          tarr[t.addr] = new();
          tarr[t.addr] = t;
          $display("[SCO] : Data stored");
         end
        end
	  else begin
	  if(tarr[t.addr] == null) begin
          if(t.dout == 0) 
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
          else begin
          if(t.dout == tarr[t.addr].din)
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
        end
	  */   
      end
   endtask
endclass


//////////////////////Env
class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass


////////////////////Testbench Top
module tb;
   
   environment env;
   counter_intf vif();
   mailbox gdmbx, msmbx;
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   always #5 vif.clk = ~vif.clk;
   
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      #50;
      $display("[TOP] : System Reset Done");
      $display("[TOP] : Starting Write Transaction");  
      vif.wr = 1;
      vif.rst = 0;
      #250;
      $display("[TOP] : Starting Read Transaction");   
      vif.wr = 0;
      #200;  
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      
      env = new(gdmbx,msmbx);
      env.vif = vif;
      #50;  
      env.run();
      #600;
      $finish;
   end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////Transaction
class transaction;
   rand bit [7:0] din;
   randc bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
   
   constraint addr_c {addr > 10; addr < 18;};  
endclass


/////////////////////Generator
class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver din : %0d and addr : %0d",t.din, t.addr);
	 @(done);
      end
   endtask
endclass

////////////////////Driver

class driver;
   mailbox mbx;
   event   done;
   transaction t;
   virtual counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger wr : %0b addr : %0d din : %0d",vif.wr, t.addr, t.din);
	 @(posedge vif.clk);
	 
	 
	 if(vif.wr == 1'b0) begin
            @(posedge vif.clk);
	 end
	 
	 ->done;
	 
	 
	 
      end
   endtask
endclass  


////////////////////Monitor
class monitor;
   mailbox mbx;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 @(posedge vif.clk);
	 
	 if(t.wr == 1'b1) begin  
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = 0;
	    t.wr = vif.wr;
	 end
	 
	 if(t.wr == 1'b0) begin 
	    @(posedge vif.clk); 
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = vif.dout;
	    t.wr = vif.wr; 
	 end  
	 
         
	 mbx.put(t);
	 $display("[MON] : data send to SCO wr :%0b din : %0d addr : %0d dout : %0d ", t.wr,t.din,t.addr,t.dout); 
      end
   endtask
endclass


////////////////Scoreboard
class scoreboard;
   mailbox mbx;
   //transaction tarr[256];
   
   reg [7:0] tarr[256] = '{default:0}; 
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 
	 
	 if(t.wr == 1'b1) begin
            tarr[t.addr] = t.din;
            $display("[SCO] : Data stored din : %0d addr : %0d ", t.din,t.addr);
	 end
	 
	 if(t.wr == 1'b0) begin
            if(t.dout == 0)
              $display("[SCO] : No Data Written at this Location Test Passed");
            else if (t.dout == tarr[t.addr])
              $display("[SCO] : Valid Data found Test Passed");
            else
              $display("[SCO] : Test Failed");   
	 end
	 
	 
	 
	 
	 
	 
	 /*
	  if(t.wr == 1'b1) begin
	  if(tarr[t.addr] == null) begin
          tarr[t.addr] = new();
          tarr[t.addr] = t;
          $display("[SCO] : Data stored");
         end
        end
	  else begin
	  if(tarr[t.addr] == null) begin
          if(t.dout == 0) 
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
          else begin
          if(t.dout == tarr[t.addr].din)
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
        end
	  */   
      end
   endtask
endclass


//////////////////////Env
class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass


////////////////////Testbench Top
module tb;
   
   environment env;
   counter_intf vif();
   mailbox gdmbx, msmbx;
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   always #5 vif.clk = ~vif.clk;
   
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      #50;
      $display("[TOP] : System Reset Done");
      $display("[TOP] : Starting Write Transaction");  
      vif.wr = 1;
      vif.rst = 0;
      #250;
      $display("[TOP] : Starting Read Transaction");   
      vif.wr = 0;
      #200;  
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      
      env = new(gdmbx,msmbx);
      env.vif = vif;
      #50;  
      env.run();
      #600;
      $finish;
   end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Complete Code

      //////////////////////////////////////RTL Module
module ram(
	   input 	    clk, rst, wr,
	   input [7:0] 	    din, addr,
	   output reg [7:0] dout
	   );
   reg [7:0] 		    mem [256];
   integer 		    i;
   
   always@(posedge clk)
     begin
	if(rst == 1'b1) begin
	   for( i = 0; i < 256; i++)
	     begin
		mem[i] <= 0;
	     end
	end
	else if(wr == 1'b1)
	  mem[addr] <= din;
	else
	  dout <= mem[addr];
     end
endmodule

/////////////////////////////////////////////////// Interface

interface counter_intf();
   logic clk,rst, wr;
   logic [7:0] din, addr;
   logic [7:0] dout;
endinterface

/////////////////////Transaction
class transaction;
   rand bit [7:0] din;
   randc bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
   
   constraint addr_c {addr > 10; addr < 18;};  
endclass


/////////////////////Generator
class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver din : %0d and addr : %0d",t.din, t.addr);
	 @(done);
      end
   endtask
endclass

////////////////////Driver

class driver;
   mailbox mbx;
   event   done;
   transaction t;
   virtual counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger wr : %0b addr : %0d din : %0d",vif.wr, t.addr, t.din);
	 @(posedge vif.clk);
	 
	 
	 if(vif.wr == 1'b0) begin
            @(posedge vif.clk);
	 end
	 
	 ->done;
	 
	 
	 
      end
   endtask
endclass  


////////////////////Monitor
class monitor;
   mailbox mbx;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 @(posedge vif.clk);
	 
	 if(t.wr == 1'b1) begin  
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = 0;
	    t.wr = vif.wr;
	 end
	 
	 if(t.wr == 1'b0) begin 
	    @(posedge vif.clk); 
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = vif.dout;
	    t.wr = vif.wr; 
	 end  
	 
         
	 mbx.put(t);
	 $display("[MON] : data send to SCO wr :%0b din : %0d addr : %0d dout : %0d ", t.wr,t.din,t.addr,t.dout); 
      end
   endtask
endclass


////////////////Scoreboard
class scoreboard;
   mailbox mbx;
   //transaction tarr[256];
   
   reg [7:0] tarr[256] = '{default:0}; 
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 
	 
	 if(t.wr == 1'b1) begin
            tarr[t.addr] = t.din;
            $display("[SCO] : Data stored din : %0d addr : %0d ", t.din,t.addr);
	 end
	 
	 if(t.wr == 1'b0) begin
            if(t.dout == 0)
              $display("[SCO] : No Data Written at this Location Test Passed");
            else if (t.dout == tarr[t.addr])
              $display("[SCO] : Valid Data found Test Passed");
            else
              $display("[SCO] : Test Failed");   
	 end
	 
	 
	 
	 
	 
	 
	 /*
	  if(t.wr == 1'b1) begin
	  if(tarr[t.addr] == null) begin
          tarr[t.addr] = new();
          tarr[t.addr] = t;
          $display("[SCO] : Data stored");
         end
        end
	  else begin
	  if(tarr[t.addr] == null) begin
          if(t.dout == 0) 
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
          else begin
          if(t.dout == tarr[t.addr].din)
          $display("[SCO] : Data read Test Passed");
          else
          $display("[SCO] : Data read Test Failed"); 
        end
        end
	  */   
      end
   endtask
endclass


//////////////////////Env
class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   
   function new(mailbox gdmbx, mailbox msmbx);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass


////////////////////Testbench Top
module tb;
   
   environment env;
   counter_intf vif();
   mailbox gdmbx, msmbx;
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   always #5 vif.clk = ~vif.clk;
   
   
   initial begin
      vif.clk = 0;
      vif.rst = 1;
      #50;
      $display("[TOP] : System Reset Done");
      $display("[TOP] : Starting Write Transaction");  
      vif.wr = 1;
      vif.rst = 0;
      #250;
      $display("[TOP] : Starting Read Transaction");   
      vif.wr = 0;
      #200;  
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      
      env = new(gdmbx,msmbx);
      env.vif = vif;
      #50;  
      env.run();
      #600;
      $finish;
   end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   
   
endmodule



Udemy
  Writing SystemVerilog Testbenches for Newbie
    Code

      /////////////////////Design Code


      module ram(
		 input 		  clk, rst, wr,
		 input [7:0] 	  din, addr,
		 output reg [7:0] dout
		 );
   reg [7:0] 			  mem [256];
   integer 			  i;
   
   always@(posedge clk)
     begin
	if(rst == 1'b1) begin
	   for( i = 0; i < 256; i++)
	     begin
		mem[i] <= 0;
	     end
	end
	else if(wr == 1'b1)
	  mem[addr] <= din;
	else
	  dout <= mem[addr];
     end
endmodule



///////////////////////////////Testbench Code


class transaction;
   rand bit [7:0] din;
   randc bit [7:0] addr;
   bit 		  wr;
   bit [7:0] 	  dout;
   
   constraint addr_c {addr > 10; addr < 20;};
endclass

class generator;
   mailbox 	  mbx;
   transaction t;
   event 	  done;
   integer 	  i;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      for(i = 0; i < 100; i++)begin
	 t.randomize();
	 mbx.put(t);
	 $display("[GEN] : Data send to driver din : %0d addr : %0d", t.din, t.addr);
	 @(done);
      end
   endtask
endclass


interface counter_intf();
   logic clk,rst, wr;
   logic [7:0] din, addr;
   logic [7:0] dout;
endinterface

class driver;
   mailbox     mbx;
   event       done;
   transaction t;
   virtual     counter_intf vif;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 mbx.get(t);
	 vif.din = t.din;
	 vif.addr = t.addr;
	 $display("[DRV] : Interface Trigger wr: %0b din : %0d addr : %0d", vif.wr , t.din, t.addr);
	 @(posedge vif.clk);
	 
	 if(vif.wr == 1'b1)
	   begin
	      @(posedge vif.clk);
	   end
	 
	 if(vif.wr == 1'b0)
	   begin
	      @(posedge vif.clk);
	   end
	 
	 ->done;
      end
   endtask
endclass  

class monitor;
   mailbox mbx;
   event   done;
   virtual counter_intf vif;
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      t = new();
      forever begin
	 @(posedge vif.clk);
	 
	 if(vif.wr == 1'b1) begin
	    @(posedge vif.clk);
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = 0;
	    t.wr = vif.wr;
	 end
	 
	 if(vif.wr == 1'b0) begin
	    @(posedge vif.clk);
	    t.din = vif.din;
	    t.addr = vif.addr;
	    t.dout = vif.dout;
	    t.wr = vif.wr;
	 end
	 
	 mbx.put(t);
	 $display("[MON] : data send to Scoreboard wr :%0b din : %0d addr: %0d dout:%0d", t.wr, t.din, t.addr, t.dout);
	 -> done;  
      end
   endtask
endclass

class scoreboard;
   mailbox mbx;
   event   done;
   reg [7:0] tarr[256] = '{default:0};
   transaction t;
   
   function new(mailbox mbx);
      this.mbx = mbx;
   endfunction
   
   task run();
      forever begin
	 mbx.get(t);
	 
	 
	 if(t.wr == 1'b1) begin
	    tarr[t.addr] = t.din;
	    $display("[SCO] : Data Stored din : %0d addr: %0d",  t.din, t.addr);
	    $display("[SCO] : Data rcvd wr :%0b din : %0d addr: %0d dout:%0d", t.wr, t.din, t.addr, t.dout);
	 end
	 
	 if(t.wr == 1'b0) begin  
	    
	    if(t.dout == 0)
	      $display("[SCO]: Not Written any data at this location on RAM Test Passed");
	    else if (t.dout == tarr[t.addr])
              $display("[SCO] : Data Match");
	    else
              $display("[SCO]: Test Failed");
	    $display("[SCO] : Data rcvd wr :%0b din : %0d addr: %0d dout:%0d", t.wr, t.din, t.addr, t.dout);
	 end
	 
	 @(done);   
      end
      
   endtask
endclass

class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
   
   virtual counter_intf vif;
   
   mailbox gdmbx;
   mailbox msmbx;
   
   event   gddone;
   event   msdone;
   
   function new(mailbox gdmbx, mailbox msmbx,virtual  counter_intf vif);
      this.gdmbx = gdmbx;
      this.msmbx = msmbx;
      this.vif = vif;
      
      
      gen = new(gdmbx);
      drv = new(gdmbx);
      
      mon = new(msmbx);
      sco = new(msmbx);
   endfunction
   
   task run();
      gen.done = gddone;
      drv.done = gddone;
      mon.done = msdone;
      sco.done = msdone;  
      
      drv.vif = vif;
      mon.vif = vif;
      
      fork 
	 gen.run();
	 drv.run();
	 mon.run();
	 sco.run();
      join_any
      
   endtask
   
endclass



program temp_p (counter_intf vif);
   
   environment env;
   mailbox gdmbx, msmbx;
   
   
   initial begin
      vif.rst <= 1;
      #50;
      vif.wr <= 1;
      vif.rst <= 0;
      #300;
      vif.wr <= 0;
      #300;
   end
   
   initial begin
      gdmbx = new();
      msmbx = new();
      env = new(gdmbx,msmbx,vif);
      #50;
      env.run();
      #600;
      $finish;
   end
   
endprogram
   
   
   
   
module tb;
   
   temp_p t1(vif);    
   counter_intf vif();
   
   
   ram dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);
   
   initial begin
      vif.clk = 0;
   end
   
   always #5 vif.clk = ~vif.clk;
   
endmodule




















