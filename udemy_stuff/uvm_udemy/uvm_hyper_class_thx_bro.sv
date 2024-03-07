
Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh" ///`uvm_info
      import uvm_pkg::*;



module tb;
   
   initial begin
      #50;
      `uvm_info("TB_TOP","Hello World", UVM_LOW); 
      $display("Hello World with Display");
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

module tb;
   
   int data = 56;
   
   initial begin
      `uvm_info("TB_TOP", $sformatf("Value of data : %0d",data), UVM_NONE);
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

module tb;
   
   initial begin
      uvm_top.set_report_verbosity_level(UVM_HIGH);
      $display("Default Verbosity level : %0d ", uvm_top.get_report_verbosity_level);
      `uvm_info("TB_TOP", "String", UVM_HIGH);
      
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   task run();
      `uvm_info("DRV1", "Executed Driver1 Code", UVM_HIGH);
      `uvm_info("DRV2", "Executed Driver2 Code", UVM_HIGH);
   endtask
   
endclass

////////////////////
     

module tb;
   
   driver drv;
   
   
   
   initial begin
      drv = new("DRV", null);
      drv.set_report_id_verbosity("DRV1",UVM_HIGH);
      drv.run();
      
      
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   task run();
      `uvm_info("DRV1", "Executed Driver1 Code", UVM_HIGH);
      `uvm_info("DRV2", "Executed Driver2 Code", UVM_HIGH);
   endtask
   
endclass

//////////////////////////////////////////////////
     
class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   task run();
      `uvm_info("ENV1", "Executed ENV1 Code", UVM_HIGH);
      `uvm_info("ENV2", "Executed ENV2 Code", UVM_HIGH);
   endtask
   
endclass
////////////////////
     

module tb;
   
   driver drv;
   env e;
   
   
   initial begin
      drv = new("DRV", null);
      e   = new("ENV", null);
      // e.set_report_verbosity_level(UVM_HIGH);
      drv.run();
      e.run();
      
   end
   
   
endmodule



Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   task run();
      `uvm_info("DRV", "Executed Driver Code", UVM_HIGH);
   endtask
   
endclass
///////////////////////////////////////////////////

class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   task run();
      `uvm_info("MON", "Executed Monitor Code", UVM_HIGH);
   endtask
   
endclass

//////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   driver drv;
   monitor mon;
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   
   task run();
      drv = new("DRV", this);
      mon = new("MON", this);
      drv.run();
      mon.run();
   endtask
   
endclass
////////////////////


module tb;
   
   
   env e;
   
   
   initial begin
      e  = new("ENV", null);
      e.set_report_verbosity_level_hier(UVM_HIGH);
      e.run(); 
   end
   
   
endmodule



Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   
   
   task run();
      `uvm_info("DRV", "Informational Message", UVM_NONE);
      `uvm_warning("DRV", "Potential Error");
      `uvm_error("DRV", "Real Error");
      #10;
      `uvm_fatal("DRV", "Simulation cannot continue");
   endtask
   
   
   
endclass

/////////////////////////////////////////////


module tb;
   driver d;
   
   initial begin
      d = new("DRV", null);
      d.run();
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   
   
   task run();
      `uvm_info("DRV", "Informational Message", UVM_NONE);
      `uvm_warning("DRV", "Potential Error");
      `uvm_error("DRV", "Real Error");
      #10;
      `uvm_fatal("DRV", "Simulation cannot continue DRV1");
      #10;
      `uvm_fatal("DRV1", "Simulation Cannot Continue DRV1");
   endtask
   
   
   
endclass

/////////////////////////////////////////////


module tb;
   driver d;
   
   initial begin
      d = new("DRV", null);
      // d.set_report_severity_override(UVM_FATAL, UVM_ERROR);
      d.set_report_severity_id_override(UVM_FATAL, "DRV", UVM_ERROR);
      d.run();
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   
   
   task run();
      `uvm_info("DRV", "Informational Message", UVM_NONE);
      `uvm_warning("DRV", "Potential Error");
      `uvm_error("DRV", "Real Error"); ///uvm_count
      `uvm_error("DRV", "Second Real Error");
      /*
       #10;
       `uvm_fatal("DRV", "Simulation cannot continue DRV1"); /// uvm_exit
       #10;
       `uvm_fatal("DRV1", "Simulation Cannot Continue DRV1");
       */
   endtask
   
   
   
endclass

/////////////////////////////////////////////


module tb;
   driver d;
   
   initial begin
      d = new("DRV", null);
      d.set_report_max_quit_count(3);
      
      
      
      d.run();
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

//////////////////////////////////////////////////
class driver extends uvm_driver;
   `uvm_component_utils(driver)
   
   function new(string path , uvm_component parent);
      super.new(path, parent);
   endfunction
   
   
   
   
   task run();
      `uvm_info("DRV", "Informational Message", UVM_NONE);
      `uvm_warning("DRV", "Potential Error");
      `uvm_error("DRV", "Real Error"); 
      `uvm_error("DRV", "Second Real Error");
   endtask
   
   
   
endclass

/////////////////////////////////////////////


module tb;
   driver d;
   int file;
   
   initial begin
      file = $fopen("log.txt", "w");
      d = new("DRV", null);
      //d.set_report_default_file(file);
      d.set_report_severity_file(UVM_ERROR, file);
      
      //  d.set_report_severity_action(UVM_INFO, UVM_DISPLAY|UVM_LOG);
      // d.set_report_severity_action(UVM_WARNING, UVM_DISPLAY|UVM_LOG);
      d.set_report_severity_action(UVM_ERROR, UVM_DISPLAY|UVM_LOG);
      
      
      d.run();
      
      #10;
      $fclose(file);
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class obj extends uvm_object;
   `uvm_object_utils(obj)
   
   function new(string path = "obj");
      super.new(path);
   endfunction
   
   rand bit [3:0] a;
   
endclass

module tb;
   obj o;
   
   initial begin
      o = new("obj");
      o.randomize();
      `uvm_info("TB_TOP", $sformatf("Value of a : %0d", o.a), UVM_NONE);
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class obj extends uvm_object;
   //  `uvm_object_utils(obj)
   
   function new(string path = "obj");
      super.new(path);
   endfunction
   
   rand bit [3:0] a;
   rand bit [7:0] b;
   
   `uvm_object_utils_begin(obj)
      `uvm_field_int(a, UVM_NOPRINT | UVM_BIN);
      `uvm_field_int(b, UVM_DEFAULT | UVM_DEC);
   `uvm_object_utils_end
   
   
endclass

module tb;
   obj o;
   
   initial begin
      o = new("obj");
      o.randomize();
      o.print(uvm_default_table_printer);
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;



class obj extends uvm_object;
   //  `uvm_object_utils(obj)
   
   typedef enum bit [1:0] {s0 , s1, s2, s3} state_type;
   rand state_type state;
   
   real 	temp = 12.34;
   string 	str = "UVM";
   
   function new(string path = "obj");
      super.new(path);
   endfunction
   
   
   `uvm_object_utils_begin(obj)
      `uvm_field_enum(state_type, state, UVM_DEFAULT);
      `uvm_field_string(str,UVM_DEFAULT);
      `uvm_field_real(temp, UVM_DEFAULT);
   `uvm_object_utils_end
   
   
endclass

module tb;
   obj o;
   
   initial begin
      o = new("obj");
      o.randomize();
      o.print(uvm_default_table_printer);
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class parent extends uvm_object;
   
   function new(string path = "parent");
      super.new(path);
   endfunction 
   
   rand bit [3:0] data;
   
   `uvm_object_utils_begin(parent)
      `uvm_field_int(data,UVM_DEFAULT);
   `uvm_object_utils_end
   
   
endclass

class child extends uvm_object;
   
   parent p;
   
   function new(string path = "child");
      super.new(path);
      p = new("parent");
   endfunction 
   
   `uvm_object_utils_begin(child)
      `uvm_field_object(p,UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass

module tb;
   child c;
   
   initial begin
      c = new("child");
      c.p.randomize();
      c.print();
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class array extends uvm_object;
   
   ////////static array
   int arr1[3] = {1,2,3};
   
   ///////Dynamic array
   int arr2[];
   
   ///////Queue
   int arr3[$];
   
   ////////Associative array
   int arr4[int];
   
   
   
   function new(string path = "array");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(array)
      `uvm_field_sarray_int(arr1, UVM_DEFAULT);
      `uvm_field_array_int(arr2, UVM_DEFAULT);
      `uvm_field_queue_int(arr3, UVM_DEFAULT);
      `uvm_field_aa_int_int(arr4, UVM_DEFAULT);
   `uvm_object_utils_end
   
   task run();
      
      ///////////////////Dynamic array value update
      arr2 = new[3];
      arr2[0] = 2;
      arr2[1] = 2;
      arr2[2] = 2;
      
      ///////////////////Queue
      arr3.push_front(3);
      arr3.push_front(3);
      
      ////////////////////Associative arrays
      arr4[1] = 4;
      arr4[2] = 4;
      arr4[3] = 4;
      arr4[4] = 4;
      
   endtask
   
endclass

////////////////////////////////////////////

module tb;
   array a;
   
   initial begin
      a = new("array");
      a.run();
      a.print();
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class first extends uvm_object; 
   
   rand bit [3:0] data;
   
   function new(string path = "first");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first)
      `uvm_field_int(data, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass

////////////////////////////////////////////

module tb;
   first f;
   first s;
   /* 
    initial begin
    f = new("first");
    s = new("second");
    f.randomize();
    s.copy(f);
    f.print();
    s.print();
    
      end
    
    */
   
   initial begin
      f = new("first");
      f.randomize();
      $cast(s, f.clone());
      f.print();
      s.print();
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class first extends uvm_object; 
   
   rand bit [3:0] data;
   
   function new(string path = "first");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first)
      `uvm_field_int(data, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass

///////////////////////////////////////

class second extends uvm_object;
   
   first f;
   
   function new(string path = "second");
      super.new(path);
      f = new("first");
   endfunction 
   
   `uvm_object_utils_begin(second)
      `uvm_field_object(f, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass

////////////////////////////////////////////

module tb;
   
   second s1, s2; ///shallow
   
   initial begin
      s1 = new("s1");
      s2 = new("s2");
      s1.f.randomize();
      s1.print();
      s2 = s1;
      s2.print();
      
      s2.f.data = 12;
      s1.print();
      s2.print();
      
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class first extends uvm_object; 
   
   rand bit [3:0] data;
   
   function new(string path = "first");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first)
      `uvm_field_int(data, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass

///////////////////////////////////////

class second extends uvm_object;
   
   first f;
   
   function new(string path = "second");
      super.new(path);
      f = new("first");
   endfunction 
   
   `uvm_object_utils_begin(second)
      `uvm_field_object(f, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass

////////////////////////////////////////////

module tb;
   
   second s1, s2; ///shallow
   
   initial begin
      s1 = new("s1");
      // s2 = new("s2");
      
      s1.f.randomize();
      
      //s2.copy(s1);  ///deep copy
      
      $cast(s2,s1.clone()); ///deep copy
      s1.print();
      s2.print();
      
      s2.f.data = 12;
      s1.print();
      s2.print();
      
      
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class first extends uvm_object; 
   
   rand bit [3:0] data;
   
   function new(string path = "first");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first)
      `uvm_field_int(data, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass


////////////////////////////////////////////

module tb;
   
   first f1,f2;
   int status = 0;
   
   initial begin
      f1 = new("f1");
      f2 = new("f2");
      f1.randomize();
      f2.copy(f1);
      f1.print();
      f2.print();
      
      status = f1.compare(f2);
      $display("Value of status : %0d", status);
      
      
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class first extends uvm_object; 
   
   rand bit [3:0] data;
   
   function new(string path = "first");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first)
      `uvm_field_int(data, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass


////////////////////////////////////////////

module tb;
   
   first f1,f2;
   
   
   initial begin
      f1 = first::type_id::create("f1");
      f2 = first::type_id::create("f2");
      
      f1.randomize();
      f2.randomize();
      
      f1.print();
      f2.print();
      
      
   end
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class first extends uvm_object; 
   
   rand bit [3:0] data;
   
   function new(string path = "first");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first)
      `uvm_field_int(data, UVM_DEFAULT);
   `uvm_object_utils_end
   
endclass
/////////////////////////////////////
class first_mod extends first;
   rand bit 	  ack;
   
   function new(string path = "first_mod");
      super.new(path);
   endfunction 
   
   `uvm_object_utils_begin(first_mod)
      `uvm_field_int(ack, UVM_DEFAULT);
   `uvm_object_utils_end
   
   
endclass



////////////////////////////////////////////

class comp extends uvm_component;
   `uvm_component_utils(comp)
   
   first f;
   
   function new(string path = "second", uvm_component parent = null);
      super.new(path, parent);
      f = first::type_id::create("f");
      f.randomize();
      f.print();
   endfunction 
   
   
endclass


/////////////////////////////////////////////

module tb;
   
   comp c;
   
   initial begin
      c.set_type_override_by_type(first::get_type, first_mod::get_type); 
      c = comp::type_id::create("comp", null); 
   end
   
   
   
   
   
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class obj extends uvm_object;
   `uvm_object_utils(obj)
   
   function new(string path = "OBJ");
      super.new(path);
   endfunction
   
   bit [3:0] a = 4;
   string    b = "UVM";
   real      c   = 12.34;
   
   virtual function void do_print(uvm_printer printer);
      super.do_print(printer);
      
      printer.print_field_int("a", a, $bits(a), UVM_HEX);
      printer.print_string("b", b);
      printer.print_real("c", c);
      
   endfunction
   
   
endclass  


module tb;
   obj o;
   
   initial begin
      o = obj::type_id::create("o");
      o.print();
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class obj extends uvm_object;
   `uvm_object_utils(obj)
   
   function new(string path = "OBJ");
      super.new(path);
   endfunction
   
   bit [3:0] a = 4;
   string    b = "UVM";
   real      c   = 12.34;
   
   virtual function string convert2string();
      
      string s = super.convert2string(); 
      
      s = {s, $sformatf("a : %0d ", a)};
      s = {s, $sformatf("b : %0s ", b)};
      s = {s, $sformatf("c : %0f ", c)};
      ////a : 4 b : UVM c : 12.3400
      return s;
   endfunction
   
   
endclass  


module tb;
   obj o;
   
   initial begin
      o = obj::type_id::create("o");
      //$display("%0s", o.convert2string());
      `uvm_info("TB_TOP", $sformatf("%0s", o.convert2string()), UVM_NONE);
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class obj extends uvm_object;
   `uvm_object_utils(obj)
   
   function new(string path = "obj");
      super.new(path);
   endfunction
   
   rand bit [3:0] a;
   rand bit [4:0] b;
   
   virtual function void do_print(uvm_printer printer);
      super.do_print(printer);
      printer.print_field_int("a :", a, $bits(a), UVM_DEC);
      printer.print_field_int("b :", b, $bits(b), UVM_DEC);
   endfunction
   
   
   virtual function void do_copy(uvm_object rhs);
      obj temp;
      $cast(temp, rhs);
      super.do_copy(rhs);
      
      this.a = temp.a;
      this.b = temp.b;
      
   endfunction
   
   
endclass  


module tb;
   obj o1,o2;
   
   initial begin
      o1 = obj::type_id::create("o1");
      o2 = obj::type_id::create("o2");
      
      
      o1.randomize();
      o1.print();
      o2.copy(o1);
      o2.print();
      
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class comp extends uvm_component;
   `uvm_component_utils(comp)
   
   function new(string path = "comp", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("COMP", "Build phase of comp executed", UVM_NONE); 
   endfunction
   
endclass

module tb;
   
   comp c;
   
   initial begin
      c = comp::type_id::create("c", null);
      c.build_phase(null);
   end
   /*
    initial begin
    run_test("comp");
      end
    */
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;



////////////////////////////////////////////////////////////////////////

class a extends uvm_component;
   `uvm_component_utils(a)
   
   function new(string path = "a", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("a", "Class a executed", UVM_NONE);
   endfunction
   
endclass

////////////////////////////////////////////////////////////////
class b extends uvm_component;
   `uvm_component_utils(b)
   
   function new(string path = "b", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("a", "Class b executed", UVM_NONE);
   endfunction
   
endclass

//////////////////////////////////////////////////////////////////////


class c extends uvm_component;
   `uvm_component_utils(c)
   
   a a_inst;
   b b_inst;
   
   function new(string path = "c", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a_inst = a::type_id::create("a_inst",this);
      b_inst = b::type_id::create("b_inst",this);
   endfunction
   
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction
   
endclass
///////////////////////////////////////////////////////////////////////

module tb;
   
   initial begin
      run_test("c");    
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class env extends uvm_env;
   `uvm_component_utils(env)
   
   int data;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(uvm_config_db#(int):: get(null, "uvm_test_top", "data", data))
        `uvm_info("ENV", $sformatf("Value of data : %0d", data), UVM_NONE)
      else
        `uvm_error("ENV", "Unable to access the Value");
      
      
   endfunction
   
   
   
endclass
///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
      //////////////////////////////
      
      uvm_config_db#(int)::set(null,"uvm_test_top", "data", 12); ////context + instance name + key + value
      
   endfunction
   
endclass 

///////////////////////////

module tb;
   
   initial begin
      run_test("test");
      
   end
   
   
endmodule




Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      ///////////////////DUT and Interface

      module adder(
		   input [3:0] 	a,b,
		   output [4:0] y
		   );
   
   
   assign y = a + b;
   
endmodule



interface adder_if;
   logic [3:0] 			a;
   logic [3:0] 			b;
   logic [4:0] 			y;
   
endinterface





/////////////////////////Testbench Environment

//////////////////////////////////////////////////////

`include "uvm_macros.svh"
import uvm_pkg::*;


class drv extends uvm_driver;
   `uvm_component_utils(drv)
   
   virtual 			adder_if aif;
   
   function new(input string path = "drv", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual adder_if)::get(this,"","aif",aif))//uvm_test_top.env.agent.drv.aif
        `uvm_error("drv","Unable to access Interface");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      for(int i = 0; i< 10; i++)
        begin
           aif.a <= $urandom;
           aif.b <= $urandom;
           #10;
        end
      phase.drop_objection(this);
   endtask
   
endclass



/////////////////////////////////////////////////////////////////////////
	 
class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "agent", uvm_component c);
      super.new(inst,c);
   endfunction
   
   drv d;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = drv::type_id::create("drv",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////////////
	 
class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "env", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("agent",this);
   endfunction
   
endclass


//////////////////////////////////////////////////////////////////
	class test extends uvm_test;
	   `uvm_component_utils(test)
	   
	   function new(input string inst = "test", uvm_component c);
	      super.new(inst,c);
	   endfunction
	   
	   env e;
	   
	   virtual function void build_phase(uvm_phase phase);
	      super.build_phase(phase);
	      e = env::type_id::create("env",this);
	   endfunction
	   
	   
	endclass


////////////////////////////////////////////////////////////////////
	module tb;
   
   adder_if aif();
   
   adder dut (.a(aif.a), .b(aif.b), .y(aif.y));
   
   initial 
     begin
	uvm_config_db #(virtual adder_if)::set(null, "uvm_test_top.env.agent.drv", "aif", aif);
	run_test("test"); 
     end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
endmodule








Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   ////////////////////////////Construction Phases
	 
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      
      `uvm_info("test","Build Phase Executed", UVM_NONE);
   endfunction
   
   
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("test","Connect Phase Executed", UVM_NONE);
   endfunction
   
   
   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      `uvm_info("test","End of Elaboration Phase Executed", UVM_NONE);
   endfunction
   
   function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);
      `uvm_info("test","Start of Simulation Phase Executed", UVM_NONE);
   endfunction
   
   
   //////////////////////////////Main Phases
	 
   
   task run_phase(uvm_phase phase);
      `uvm_info("test", "Run Phase", UVM_NONE);   
   endtask
   
   
   //////////////////////////Cleanup Phases
	 
   function void extract_phase(uvm_phase phase);
      super.extract_phase(phase);
      `uvm_info("test", "Extract Phase", UVM_NONE); 
   endfunction
   
   
   function void check_phase(uvm_phase phase);
      super.check_phase(phase);
      `uvm_info("test", "Check Phase", UVM_NONE); 
   endfunction
   
   
   function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      `uvm_info("test", "Report Phase", UVM_NONE); 
   endfunction
   
   function void final_phase(uvm_phase phase);
      super.final_phase(phase);
      `uvm_info("test", "Final Phase", UVM_NONE); 
   endfunction
   
   
   
   
endclass


module tb;
   
   initial begin
      run_test("test");
   end
   
   
endmodule



Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;



class driver extends uvm_driver;
   `uvm_component_utils(driver) 
   
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("driver","Driver Build Phase Executed", UVM_NONE);  
   endfunction
   
endclass

///////////////////////////////////////////////////////////////
	 
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor) 
   
   
   function new(string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("monitor","Monitor Build Phase Executed", UVM_NONE); 
   endfunction
   
endclass

////////////////////////////////////////////////////////////////////////////////////
	 
class env extends uvm_env;
   `uvm_component_utils(env) 
   
   driver drv;
   monitor mon;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("env","Env Build Phase Executed", UVM_NONE);
      drv = driver::type_id::create("drv", this);
      mon = monitor::type_id::create("mon", this);
   endfunction
   
endclass



////////////////////////////////////////////////////////////////////////////////////////
	 
class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("test","Test Build Phase Executed", UVM_NONE);
      e = env::type_id::create("e", this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////////////////
	module tb;
   
   initial begin
      run_test("test");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;




///////////////////////////////////////////////////////////////
	 
class driver extends uvm_driver;
   `uvm_component_utils(driver) 
   
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("driver","Driver Connect Phase Executed", UVM_NONE);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////
	 
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor) 
   
   
   function new(string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("monitor","Monitor Connect Phase Executed", UVM_NONE);   
   endfunction
   
endclass

////////////////////////////////////////////////////////////////////////////////////
	 
class env extends uvm_env;
   `uvm_component_utils(env) 
   
   driver d;
   monitor m;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("d", this);
      m = monitor::type_id::create("m", this);
   endfunction
   
   
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("env","Env Connect Phase Executed", UVM_NONE);
   endfunction
   
endclass



////////////////////////////////////////////////////////////////////////////////////////
	 
class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e", this);
   endfunction
   
   
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("test","Test Connect Phase Executed", UVM_NONE);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////////////////
	module tb;
   
   initial begin
      run_test("test");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class comp extends uvm_component;
   `uvm_component_utils(comp)
   
   
   function new(string path = "comp", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("comp","Reset Started", UVM_NONE);
      #10;
      `uvm_info("comp","Reset Completed", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
endclass

///////////////////////////////////////////////////////////////////////////
	module tb;
   
   initial begin
      run_test("comp");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;


class comp extends uvm_component;
   `uvm_component_utils(comp)
   
   
   function new(string path = "comp", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("comp","Reset Started", UVM_NONE);
      #10;
      `uvm_info("comp","Reset Completed", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("mon", " Main Phase Started", UVM_NONE);
      #100;
      `uvm_info("mon", " Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   
endclass

///////////////////////////////////////////////////////////////////////////
	module tb;
   
   initial begin
      run_test("comp");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;




///////////////////////////////////////////////////////////////
	 
class driver extends uvm_driver;
   `uvm_component_utils(driver) 
   
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("drv", "Driver Reset Started", UVM_NONE);
      #100;
      `uvm_info("drv", "Driver Reset Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("drv", "Driver Main Phase Started", UVM_NONE);
      #100;
      `uvm_info("drv", "Driver Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   
   
endclass

///////////////////////////////////////////////////////////////
	 
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor) 
   
   
   function new(string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("mon", "Monitor Reset Started", UVM_NONE);
      #300;
      `uvm_info("mon", "Monitor Reset Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("mon", "Monitor Main Phase Started", UVM_NONE);
      #400;
      `uvm_info("mon", "Monitor Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
endclass

////////////////////////////////////////////////////////////////////////////////////
	 
class env extends uvm_env;
   `uvm_component_utils(env) 
   
   driver d;
   monitor m;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("d", this);
      m = monitor::type_id::create("m", this);
   endfunction
   
   
   
endclass



////////////////////////////////////////////////////////////////////////////////////////
	 
class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e", this);
   endfunction
   
   
endclass

///////////////////////////////////////////////////////////////////////////
	module tb;
   
   initial begin
      run_test("test");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;
///default : 9200sec


class comp extends uvm_component;
   `uvm_component_utils(comp)
   
   
   function new(string path = "comp", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("comp","Reset Started", UVM_NONE);
      #10;
      `uvm_info("comp","Reset Completed", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("mon", " Main Phase Started", UVM_NONE);
      #100;
      `uvm_info("mon", " Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase); 
   endfunction
   
   
endclass

///////////////////////////////////////////////////////////////////////////
module tb;
   
   initial begin
      
      uvm_top.set_timeout(100ns, 0);
      run_test("comp");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;
/////Default Timeout = 9200sec


class comp extends uvm_component;
   `uvm_component_utils(comp)
   
   
   function new(string path = "comp", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("comp","Reset Started", UVM_NONE);
      #10;
      `uvm_info("comp","Reset Completed", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   task main_phase(uvm_phase phase);
      phase.phase_done.set_drain_time(this,200);
      phase.raise_objection(this);
      `uvm_info("mon", " Main Phase Started", UVM_NONE);
      #100;
      `uvm_info("mon", " Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   task post_main_phase(uvm_phase phase);
      `uvm_info("mon", " Post-Main Phase Started", UVM_NONE);
   endtask
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase); 
   endfunction
   
   
endclass

///////////////////////////////////////////////////////////////////////////
module tb;
   
   initial begin
      // uvm_top.set_timeout(100ns, 0);
      
      run_test("comp");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;




///////////////////////////////////////////////////////////////

class driver extends uvm_driver;
   `uvm_component_utils(driver) 
   
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("drv", "Driver Reset Started", UVM_NONE);
      #100;
      `uvm_info("drv", "Driver Reset Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("drv", "Driver Main Phase Started", UVM_NONE);
      #100;
      `uvm_info("drv", "Driver Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   task post_main_phase(uvm_phase phase);
      `uvm_info("drv", "Driver Post-Main Phase Started", UVM_NONE);  
   endtask
   
   
   
endclass

///////////////////////////////////////////////////////////////

class monitor extends uvm_monitor;
   `uvm_component_utils(monitor) 
   
   
   function new(string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("mon", "Monitor Reset Started", UVM_NONE);
      #150;
      `uvm_info("mon", "Monitor Reset Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("mon", "Monitor Main Phase Started", UVM_NONE);
      #200;
      `uvm_info("mon", "Monitor Main Phase Ended", UVM_NONE);
      phase.drop_objection(this);
   endtask
   
   task post_main_phase(uvm_phase phase);
      `uvm_info("mon", "Monitor Post-Main Phase Started", UVM_NONE);  
   endtask
   
endclass

////////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env) 
   
   driver d;
   monitor m;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("d", this);
      m = monitor::type_id::create("m", this);
   endfunction
   
   
   
endclass



////////////////////////////////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e", this);
   endfunction
   
   function void end_of_elaboration_phase(uvm_phase phase);
      uvm_phase main_phase;
      super.end_of_elaboration_phase(phase);
      main_phase = phase.find_by_name("main", 0);
      main_phase.phase_done.set_drain_time(this, 100);
   endfunction
   
   
endclass

///////////////////////////////////////////////////////////////////////////
module tb;
   
   initial begin
      run_test("test");
   end
   
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   int data = 12;
   
   uvm_blocking_put_port #(int) send;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
      
      send  = new("send", this);
      
   endfunction
   
   
endclass
////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   
   uvm_blocking_put_export #(int) recv;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
      
      recv  = new("recv", this);
      
   endfunction
   
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p = producer::type_id::create("p",this);
      c = consumer::type_id::create("c", this);
   endfunction
   
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      
      p.send.connect(c.recv);
      
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule





Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   int data = 12;
   
   uvm_blocking_put_port #(int) send;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
      
      send  = new("send", this);
      
   endfunction
   
   
   task main_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      send.put(data);
      `uvm_info("PROD" , $sformatf("Data Sent : %0d", data), UVM_NONE);
      phase.drop_objection(this);
      
   endtask
   
   
   
endclass
////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   
   uvm_blocking_put_export #(int) recv;
   uvm_blocking_put_imp #(int, consumer) imp;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
      
      recv  = new("recv", this);
      imp   = new("imp" , this);
      
   endfunction
   
   task put(int datar);
      `uvm_info("CONS" , $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
   endtask
   
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p = producer::type_id::create("p",this);
      c = consumer::type_id::create("c", this);
   endfunction
   
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      
      p.send.connect(c.recv);
      c.recv.connect(c.imp); 
      
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule






Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   int data = 12;
   
   uvm_blocking_put_port #(int) send;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      send  = new("send", this);
   endfunction
   
   
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("PROD", $sformatf("Data Sent : %0d", data), UVM_NONE); 
      send.put(data);
      phase.drop_objection(this);
   endtask
   
   
endclass
////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   
   uvm_blocking_put_imp#(int, consumer) imp;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp  = new("imp", this);
   endfunction
   
   
   function void put(int datar);
      `uvm_info("Cons", $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
   endfunction
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string inst = "env", uvm_component c);
      super.new(inst, c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p = producer::type_id::create("p",this);
      c = consumer::type_id::create("c", this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p.send.connect(c.imp);
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string inst = "test", uvm_component c);
      super.new(inst, c);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule






Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;



class subproducer extends uvm_component;
   `uvm_component_utils(subproducer)
   
   int data = 12;
   
   uvm_blocking_put_port #(int) subport;
   
   function new(input string path = "subproducer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      subport  = new("subport", this);
   endfunction
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("SUBPROD", $sformatf("Data Sent : %0d", data), UVM_NONE); 
      subport.put(data);
      phase.drop_objection(this);
   endtask
   
   
endclass
////////////////////////////////////////////////


class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   subproducer s;
   
   uvm_blocking_put_port #(int) port;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      port  = new("port", this);
      s = subproducer::type_id::create("s", this);
   endfunction
   
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      s.subport.connect(port);
   endfunction
   
   
endclass
////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   
   uvm_blocking_put_imp#(int, consumer) imp;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp   = new("imp", this); 
   endfunction
   
   
   function void put(int datar);
      `uvm_info("Cons", $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
   endfunction
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p = producer::type_id::create("p",this);
      c = consumer::type_id::create("c", this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);  
      p.port.connect(c.imp);
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule






Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;



class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   int data = 12;
   
   uvm_blocking_put_port #(int) port;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      port  = new("port", this);
   endfunction
   
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("PROD", $sformatf("Data Sent : %0d", data), UVM_NONE); 
      port.put(data);
      phase.drop_objection(this);
   endtask
   
   
endclass
////////////////////////////////////////////////

////////////////////////////////////////////////

class subconsumer extends uvm_component;
   `uvm_component_utils(subconsumer)
   
   
   uvm_blocking_put_imp#(int, subconsumer) imp;
   
   function new(input string path = "subconsumer", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp   = new("imp", this);
   endfunction
   
   function void put(int datar);
      `uvm_info("SUBCONS", $sformatf("Data Rcvd : %0d", datar), UVM_NONE);
   endfunction
   
endclass




/////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   
   uvm_blocking_put_export#(int) expo;
   subconsumer s;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      expo  = new("expo", this);
      s = subconsumer::type_id::create("s", this);
   endfunction
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      expo.connect(s.imp);
   endfunction
   
   
   
endclass
//////////////////////////////////////////////////////////////////




//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p = producer::type_id::create("p",this);
      c = consumer::type_id::create("c", this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);  
      p.port.connect(c.expo);
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule





Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   uvm_blocking_get_port #(int) port;
   
   int data = 0;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      port   = new("port", this);
   endfunction
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      port.get(data);
      `uvm_info("PROD", $sformatf("Data Recv : %0d", data), UVM_NONE); 
      phase.drop_objection(this);
   endtask
   
   
endclass
////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   int data = 12;
   
   uvm_blocking_get_imp#(int, consumer) imp;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp  = new("imp", this);
   endfunction
   
   virtual task get(output int datar);
      `uvm_info("CONS", $sformatf("Data Sent : %0d", data), UVM_NONE); 
      datar = data;
   endtask
   
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      c = consumer::type_id::create("c", this);
      p = producer::type_id::create("p",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p.port.connect(c.imp);
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule





Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   uvm_blocking_transport_port #(int , int) port;
   
   int datas = 12;
   int datar = 0;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      port   = new("port", this);
   endfunction
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      
      port.transport(datas, datar);
      
      `uvm_info("PROD", $sformatf("Data Sent : %0d , Data Recv : %0d", datas, datar), UVM_NONE); 
      
      phase.drop_objection(this);
   endtask
   
   
endclass
////////////////////////////////////////////////

class consumer extends uvm_component;
   `uvm_component_utils(consumer)
   
   int datas = 13;
   int datar = 0;
   
   uvm_blocking_transport_imp#(int, int , consumer) imp;
   
   function new(input string path = "consumer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp  = new("imp", this);
   endfunction
   
   virtual task transport(input int datar , output int datas);
      datas = this.datas;
      `uvm_info("CONS", $sformatf("Data Sent : %0d , Data Recv : %0d", datas, datar), UVM_NONE); 
   endtask
   
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer c;
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      c = consumer::type_id::create("c", this);
      p = producer::type_id::create("p",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p.port.connect(c.imp);
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule




Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;

class producer extends uvm_component;
   `uvm_component_utils(producer)
   
   uvm_analysis_port #(int) port;
   
   int data = 12;
   
   function new(input string path = "producer", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      port   = new("port", this);
   endfunction
   
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("PROD", $sformatf("Data Broadcasted : %0d", data), UVM_NONE);
      port.write(data);
      phase.drop_objection(this);
   endtask
   
   
endclass
////////////////////////////////////////////////

class consumer1 extends uvm_component;
   `uvm_component_utils(consumer1)
   
   
   uvm_analysis_imp#(int, consumer1) imp;
   
   function new(input string path = "consumer1", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp  = new("imp", this);
   endfunction
   
   virtual function void write(int datar);
      `uvm_info("CONS1", $sformatf("Data Recv : %0d", datar), UVM_NONE); 
   endfunction
   
   
endclass

//////////////////////////////////////////////////////////////////////////////////

class consumer2 extends uvm_component;
   `uvm_component_utils(consumer2)
   
   
   uvm_analysis_imp#(int, consumer2) imp;
   
   function new(input string path = "consumer2", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp  = new("imp", this);
   endfunction
   
   virtual function void write(int datar);
      `uvm_info("CONS2", $sformatf("Data Recv : %0d", datar), UVM_NONE); 
   endfunction
   
   
endclass  




/////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   producer p;
   consumer1 c1;
   consumer2 c2;  
   
   
   function new(input string path = "env", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      c1 = consumer1::type_id::create("c1", this);
      c2 = consumer2::type_id::create("c2", this);
      p = producer::type_id::create("p",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p.port.connect(c1.imp);
      p.port.connect(c2.imp);
   endfunction
   
   
endclass

///////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path, parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
   endfunction
   
   
endclass

//////////////////////////////////////////////
module tb;
   
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule





Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

/////////////////////////////////////////////////////////////

class transaction extends uvm_sequence_item;
   
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string path = "transaction");
      super.new(path);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
////////////////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   
   function new(input string path = "sequence1");
      super.new(path);
   endfunction
   
   virtual task pre_body();
      `uvm_info("SEQ1", "PRE-BODY EXECUTED", UVM_NONE);
   endtask
   
   
   virtual task body();
      `uvm_info("SEQ1", "BODY EXECUTED", UVM_NONE);
   endtask
   
   
   
   virtual task post_body();
      `uvm_info("SEQ1", "POST-BODY EXECUTED", UVM_NONE);
   endtask
   
   
endclass

////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   
   
   function new(input string path = "DRV", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      t = transaction::type_id::create("t");
      
   endfunction
   
   
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         //////apply seq to DUT 
         seq_item_port.item_done();
      end
   endtask
   
endclass

//////////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string path = "agent", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seqr;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("d",this);
      seqr = uvm_sequencer #(transaction)::type_id::create("seqr",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seqr.seq_item_export);
   endfunction
endclass

////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string path = "env", uvm_component parent= null);
      super.new(path,parent);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("a",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string path = "test", uvm_component parent = null);
      super.new(path,parent);
   endfunction
   
   sequence1 seq1;
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e",this);
      seq1 = sequence1::type_id::create("seq1");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      
      seq1.start(e.a.seqr);
      
      phase.drop_objection(this);
   endtask
   
endclass

/////////////////////////////////////////////////////////

module ram_tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule






Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      ////////////////////////
/*
 SEQ_ARB_FIFO (DEF) first in first out ..priority won't work
 SEQ_ARB_WEIGHTED  
 SEQ_ARB_RANDOM  strictly random
 SEQ_ARB_STRICT_FIFO    support pri
 SEQ_ARB_STRICT_RANDOM  support pri
 SEQ_ARB_USER
     
 */
      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      `uvm_info("SEQ1", "Trans obj Created" , UVM_NONE); 
      
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ1", "Waiting for Grant from Driver" , UVM_NONE); 
      wait_for_grant();
      `uvm_info("SEQ1", "Rcvd Grant..Randomizing Data" , UVM_NONE);
      assert(trans.randomize()); 
      `uvm_info("SEQ1", "Randomization Done -> Sent Req to Drv" , UVM_NONE);
      send_request(trans);
      `uvm_info("SEQ1", "Waiting for Item Done Resp from Driver" , UVM_NONE);
      wait_for_item_done();
      `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////



class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
      if(!uvm_config_db#(virtual adder_if)::get(this,"","aif",aif))
	`uvm_info("DRV", "Unable to access Interface", UVM_NONE);
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         `uvm_info("Drv", "Sending Grant for Sequence" , UVM_NONE);  
         seq_item_port.get_next_item(t);
         `uvm_info("Drv", "Applying Seq to DUT" , UVM_NONE);
         `uvm_info("Drv", "Sending Item Done Resp for Sequence" , UVM_NONE);
         seq_item_port.item_done();
      end
      
   endtask
   
   
endclass



class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass


class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass


class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this); 
      s1.start(e.a.seq);
      phase.drop_objection(this);
   endtask
endclass


module ram_tb;
   
   adder_if aif();
   
   
   
   initial begin
      uvm_config_db #(virtual adder_if)::set(null, "*", "aif", aif);
      run_test("test");
   end
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
endmodule




Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;
////////////////////////////////////////////


class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass

////////////////////////////////////////////
class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   transaction trans;
   
   
   function new(string path = "sequence1");
      super.new(path);    
   endfunction
   
   
   virtual task body();
      repeat(5) begin
         `uvm_do(trans);
         `uvm_info("SEQ", $sformatf("a : %0d b:%0d", trans.a, trans.b), UVM_NONE);
      end
   endtask
   
   
   
endclass
///////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   transaction trans;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual task run_phase(uvm_phase phase); 
      trans = transaction::type_id::create("trans");
      forever begin
         seq_item_port.get_next_item(trans);
         `uvm_info("DRV", $sformatf("a : %0d b:%0d", trans.a, trans.b), UVM_NONE);
         seq_item_port.item_done();     
      end
      
   endtask
   
endclass


//////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   uvm_sequencer#(transaction) seqr;
   driver d;
   
   
   function new(string path = "agent", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seqr.seq_item_export);
   endfunction
   
endclass

//////////////////////////////////////////////////////
//////////////////////running sequence with start method approach 1

class env extends uvm_env;
   `uvm_component_utils(env)
   
   agent a;
   sequence1 s1;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("a", this);
      s1= sequence1::type_id::create("s1");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      s1.start(a.seqr);
      phase.drop_objection(this);
   endtask
   
   
endclass

///////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e", this);  
   endfunction
   
   
   
   
endclass

//////////////////////////////////////////////////////////////


module tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule




Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

`include "uvm_macros.svh"
      import uvm_pkg::*;
////////////////////////////////////////////


class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass

////////////////////////////////////////////
class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   transaction trans;
   
   
   function new(string path = "sequence1");
      super.new(path);    
   endfunction
   
   /*
    virtual task body();
    repeat(5) begin
    `uvm_do(trans);
    `uvm_info("SEQ", $sformatf("a : %0d b:%0d", trans.a, trans.b), UVM_NONE);
        end
      endtask
    */
   
   virtual task body();
      repeat(5) begin
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ", $sformatf("a : %0d b:%0d", trans.a, trans.b), UVM_NONE);
      end
      
      
      
      
   endtask
   
   
endclass
///////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   transaction trans;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual task run_phase(uvm_phase phase); 
      trans = transaction::type_id::create("trans");
      forever begin
         seq_item_port.get_next_item(trans);
         `uvm_info("DRV", $sformatf("a : %0d b:%0d", trans.a, trans.b), UVM_NONE);
         seq_item_port.item_done();     
      end
      
   endtask
   
endclass


//////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   uvm_sequencer#(transaction) seqr;
   driver d;
   
   
   function new(string path = "agent", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seqr.seq_item_export);
   endfunction
   
endclass

//////////////////////////////////////////////////////
//////////////////////running sequence with start method approach 1

class env extends uvm_env;
   `uvm_component_utils(env)
   
   agent a;
   sequence1 s1;
   
   function new(string path = "env", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("a", this);
      s1= sequence1::type_id::create("s1");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      s1.start(a.seqr);
      phase.drop_objection(this);
   endtask
   
   
endclass

///////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   env e;
   
   function new(string path = "test", uvm_component parent = null);
      super.new(path, parent); 
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("e", this);  
   endfunction
   
   
   
   
endclass

//////////////////////////////////////////////////////////////


module tb;
   
   
   initial begin
      run_test("test");
   end
   
   
endmodule



Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      ////////////////////////
/*
 SEQ_ARB_FIFO (DEF) first in first out ..priority won't work
 SEQ_ARB_WEIGHTED  
 SEQ_ARB_RANDOM  strictly random
 SEQ_ARB_STRICT_FIFO    support pri
 SEQ_ARB_STRICT_RANDOM  support pri
 SEQ_ARB_USER
     
 */
      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ1", "SEQ1 Started" , UVM_NONE); 
      start_item(trans);
      trans.randomize();
      finish_item(trans);
      `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////


class sequence2 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence2)
   
   transaction trans;
   
   function new(input string inst = "seq2");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ2", "SEQ2 Started" , UVM_NONE); 
      start_item(trans);
      trans.randomize();
      finish_item(trans);
      `uvm_info("SEQ2", "SEQ2 Ended" , UVM_NONE); 
   endtask
   
   
endclass


////////////////////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         seq_item_port.item_done();
      end    
   endtask
   
   
endclass

///////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   sequence2 s2;  
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
      s2 = sequence2::type_id::create("s2");  
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      
      // e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_RANDOM);  UVM_SEQ_ARB_FIFO 
      fork  
         s2.start(e.a.seq);
         s1.start(e.a.seq);
      join 
      
      phase.drop_objection(this);
   endtask
   
   
endclass

////////////////////////////////////////////////////////
module ram_tb;
   
   
   initial begin
      run_test("test");
   end
   
endmodule







Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      ////////////////////////
/*
 SEQ_ARB_FIFO (DEF) first in first out ..priority won't work --priority do not effect
 SEQ_ARB_WEIGHTED  : weight is use for priority
 SEQ_ARB_RANDOM  strictly random --priority do not effect
 SEQ_ARB_STRICT_FIFO    support pri
 SEQ_ARB_STRICT_RANDOM  support pri
 SEQ_ARB_USER
     
 */
      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ1", "SEQ1 Started" , UVM_NONE); 
      start_item(trans);
      trans.randomize();
      finish_item(trans);
      `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////


class sequence2 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence2)
   
   transaction trans;
   
   function new(input string inst = "seq2");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ2", "SEQ2 Started" , UVM_NONE); 
      start_item(trans);
      trans.randomize();
      finish_item(trans);
      `uvm_info("SEQ2", "SEQ2 Ended" , UVM_NONE); 
   endtask
   
   
endclass


////////////////////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         seq_item_port.item_done();
      end    
   endtask
   
   
endclass

///////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   sequence2 s2;  
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
      s2 = sequence2::type_id::create("s2");  
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      
      e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_RANDOM); 
      fork  
         repeat(5) s2.start(e.a.seq, null, 100); ///sequencer, parent sequence, priority, call_pre_post 
         repeat(5) s1.start(e.a.seq, null, 100); //300 threshold 250 ...(0-300)
      join 
      
      phase.drop_objection(this);
   endtask
   
   
endclass

////////////////////////////////////////////////////////
module ram_tb;
   
   
   initial begin
      run_test("test");
   end
   
endmodule





Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      repeat(3) begin
	 
	 `uvm_info("SEQ1", "SEQ1 Started" , UVM_NONE); 
	 trans = transaction::type_id::create("trans");
	 start_item(trans);
	 assert(trans.randomize);
	 finish_item(trans);
	 `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
	 
      end
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////


class sequence2 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence2)
   
   transaction trans;
   
   function new(input string inst = "seq2");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      repeat(3) begin
         
         `uvm_info("SEQ2", "SEQ2 Started" , UVM_NONE); 
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ2", "SEQ2 Ended" , UVM_NONE);
         
      end  
   endtask
   
   
endclass


////////////////////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         seq_item_port.item_done();
      end    
   endtask
   
   
endclass

///////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   sequence2 s2;  
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
      s2 = sequence2::type_id::create("s2");  
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      //e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
      
      
      fork  
         s1.start(e.a.seq, null, 100);
         s2.start(e.a.seq, null, 200);  
      join  
      
      
      phase.drop_objection(this);
   endtask
endclass

////////////////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
endmodule




Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      repeat(3) begin
	 
	 `uvm_info("SEQ1", "SEQ1 Started" , UVM_NONE); 
	 trans = transaction::type_id::create("trans");
	 start_item(trans);
	 assert(trans.randomize);
	 finish_item(trans);
	 `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
	 
      end
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////


class sequence2 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence2)
   
   transaction trans;
   
   function new(input string inst = "seq2");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      repeat(3) begin
         
         `uvm_info("SEQ2", "SEQ2 Started" , UVM_NONE); 
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ2", "SEQ2 Ended" , UVM_NONE);
         
      end  
   endtask
   
   
endclass


////////////////////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         seq_item_port.item_done();
      end    
   endtask
   
   
endclass

///////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   sequence2 s2;  
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
      s2 = sequence2::type_id::create("s2");  
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
      
      
      fork  
         s1.start(e.a.seq, null, 100);
         s2.start(e.a.seq, null, 200);  
      join  
      
      
      phase.drop_objection(this);
   endtask
endclass

////////////////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
endmodule




Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      
      lock(m_sequencer);
      
      repeat(3) begin
	 
         `uvm_info("SEQ1", "SEQ1 Started" , UVM_NONE); 
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
	 
      end
      
      unlock(m_sequencer);
      
      
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////


class sequence2 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence2)
   
   transaction trans;
   
   function new(input string inst = "seq2");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      
      lock(m_sequencer);
      
      repeat(3) begin
         
         `uvm_info("SEQ2", "SEQ2 Started" , UVM_NONE); 
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ2", "SEQ2 Ended" , UVM_NONE);
         
      end  
      
      unlock(m_sequencer);
      
   endtask
   
   
endclass


////////////////////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         seq_item_port.item_done();
      end    
   endtask
   
   
endclass

///////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   sequence2 s2;  
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
      s2 = sequence2::type_id::create("s2");  
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      // e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
      
      
      fork  
         s2.start(e.a.seq, null, 200);
         s1.start(e.a.seq, null, 100);  
      join  
      
      
      phase.drop_objection(this);
   endtask
endclass

////////////////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
endmodule







Udemy
  UVM for Verification Part 1 : Fundamentals
    Code

      //////////////////////////////////////////////////////

`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a,UVM_DEFAULT)
      `uvm_field_int(b,UVM_DEFAULT)
      `uvm_field_int(y,UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass
//////////////////////////////////////////////////////

class sequence1 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence1)
   
   transaction trans;
   
   function new(input string inst = "seq1");
      super.new(inst);
   endfunction
   
   virtual task body();
      
      
      repeat(3) begin
	 
         `uvm_info("SEQ1", "SEQ1 Started" , UVM_NONE); 
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ1", "SEQ1 Ended" , UVM_NONE); 
	 
      end
      
      
      
      
   endtask
   
   
   
endclass
////////////////////////////////////////////////////////////////


class sequence2 extends uvm_sequence#(transaction);
   `uvm_object_utils(sequence2)
   
   transaction trans;
   
   function new(input string inst = "seq2");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      
      grab(m_sequencer);
      
      repeat(3) begin
         
         `uvm_info("SEQ2", "SEQ2 Started" , UVM_NONE); 
         trans = transaction::type_id::create("trans");
         start_item(trans);
         assert(trans.randomize);
         finish_item(trans);
         `uvm_info("SEQ2", "SEQ2 Ended" , UVM_NONE);
         
      end  
      
      ungrab(m_sequencer);
      
   endtask
   
   
endclass


////////////////////////////////////////////////////////////////////

class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)
   
   transaction t;
   virtual adder_if aif;
   
   function new(input string inst = "DRV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(t);
         seq_item_port.item_done();
      end    
   endtask
   
   
endclass

///////////////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst,c);
   endfunction
   
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("seq",this);
   endfunction
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst,c);
   endfunction
   
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
endclass

///////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst,c);
   endfunction
   
   sequence1 s1;
   sequence2 s2;  
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e = env::type_id::create("ENV",this);
      s1 = sequence1::type_id::create("s1");
      s2 = sequence2::type_id::create("s2");  
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      
      phase.raise_objection(this);
      // e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
      
      
      fork  
         s1.start(e.a.seq, null, 100); 
         s2.start(e.a.seq, null, 200); 
      join  
      
      
      phase.drop_objection(this);
   endtask
endclass

////////////////////////////////////////////////////////
module tb;
   
   
   initial begin
      run_test("test");
   end
   
endmodule





Udemy
  UVM for Verification Part 1 : Fundamentals
    DUT + Interface

      module add(
		 input [3:0]  a,b,
		 output [4:0] y
		 );
   
   assign y = a + b;  
   
endmodule

////////////////////////////////////////////////////////////
interface add_if();
   logic [3:0] 		      a;
   logic [3:0] 		      b;
   logic [4:0] 		      y;
endinterface


Udemy
  UVM for Verification Part 1 : Fundamentals
    Testbench

      ////////////////////////// Testbench Code

`timescale 1ns / 1ps
     
     
      /////////////////////////Transaction
`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] 	      a;
   rand bit [3:0] 	      b;
   bit [4:0] 		      y;
   
   function new(input string path = "transaction");
      super.new(path);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a, UVM_DEFAULT)
      `uvm_field_int(b, UVM_DEFAULT)
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
           `uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.a,t.b), UVM_NONE);
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
   
   transaction tc;
   virtual add_if aif;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tc = transaction::type_id::create("tc");
      
      if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
        `uvm_error("DRV","Unable to access uvm_config_db");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         
         seq_item_port.get_next_item(tc);
         aif.a <= tc.a;
         aif.b <= tc.b;
         `uvm_info("DRV", $sformatf("Trigger DUT a: %0d ,b :  %0d",tc.a, tc.b), UVM_NONE); 
         seq_item_port.item_done();
         #10;  
         
      end
   endtask
endclass

////////////////////////////////////////////////////////////////////////
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)
   
   uvm_analysis_port #(transaction) send;
   
   function new(input string path = "monitor", uvm_component parent = null);
      super.new(path, parent);
      send = new("send", this);
   endfunction
   
   transaction t;
   virtual add_if aif;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("t");
      
      if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
	`uvm_error("MON","Unable to access uvm_config_db");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      forever begin
         #10;
         t.a = aif.a;
         t.b = aif.b;
         t.y = aif.y;
         `uvm_info("MON", $sformatf("Data send to Scoreboard a : %0d , b : %0d and y : %0d", t.a,t.b,t.y), UVM_NONE);
         send.write(t);
      end
   endtask
endclass

///////////////////////////////////////////////////////////////////////
class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)
   
   uvm_analysis_imp #(transaction,scoreboard) recv;
   
   transaction tr;
   
   function new(input string path = "scoreboard", uvm_component parent = null);
      super.new(path, parent);
      recv = new("recv", this);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tr = transaction::type_id::create("tr");
   endfunction
   
   virtual function void write(input transaction t);
      tr = t;
      `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0d , b : %0d and y : %0d",tr.a,tr.b,tr.y), UVM_NONE);
      
      if(tr.y == tr.a + tr.b)
        `uvm_info("SCO","Test Passed", UVM_NONE)
      else
        `uvm_info("SCO","Test Failed", UVM_NONE);
   endfunction
   
   
   
endclass
////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst, c);
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
   
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst, c);
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
      a.m.send.connect(s.recv);
   endfunction
   
endclass

////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst, c);
   endfunction
   
   generator gen;
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      gen = generator::type_id::create("gen");
      e = env::type_id::create("e",this);
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      gen.start(e.a.seqr);
      #50;
      phase.drop_objection(this);
   endtask
endclass
//////////////////////////////////////

module add_tb();
   
   add_if aif();
   
   add dut (.a(aif.a), .b(aif.b), .y(aif.y));
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   initial begin  
      uvm_config_db #(virtual add_if)::set(null, "uvm_test_top.e.a*", "aif", aif);
      run_test("test");
   end
   
endmodule


Udemy
  UVM for Verification Part 1 : Fundamentals
    DUT + Interface

      module add(
		 input 		  clk,rst,
		 input [3:0] 	  a,b,
		 output reg [4:0] y
		 );
   
   always@(posedge clk)
     begin
        if(rst)
          y <= 5'b00000;
        else
          y <= a + b; 
     end
   
endmodule

////////////////////////////////////////////////////////////
interface add_if();
   logic clk;
   logic rst;
   logic [3:0] a;
   logic [3:0] b;
   logic [4:0] y;
endinterface


Udemy
  UVM for Verification Part 1 : Fundamentals
    Testbench

      ////////////////////////// Testbench Code

`timescale 1ns / 1ps
     
     
      /////////////////////////Transaction
`include "uvm_macros.svh"
      import uvm_pkg::*;

class transaction extends uvm_sequence_item;
   rand bit [3:0] a;
   rand bit [3:0] b;
   bit [4:0] 	  y;
   
   function new(input string inst = "transaction");
      super.new(inst);
   endfunction
   
   `uvm_object_utils_begin(transaction)
      `uvm_field_int(a, UVM_DEFAULT)
      `uvm_field_int(b, UVM_DEFAULT)
      `uvm_field_int(y, UVM_DEFAULT)
   `uvm_object_utils_end
   
endclass

//////////////////////////////////////////////////////////////
class generator extends uvm_sequence #(transaction);
   `uvm_object_utils(generator)
   
   transaction t;
   
   
   function new(input string inst = "GEN");
      super.new(inst);
   endfunction
   
   
   virtual task body();
      t = transaction::type_id::create("t");
      repeat(10) 
        begin
           start_item(t);
           t.randomize();
           finish_item(t);
	   `uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.a,t.b), UVM_NONE);  
        end
   endtask
   
endclass

////////////////////////////////////////////////////////////////////
class driver extends uvm_driver #(transaction);
   `uvm_component_utils(driver)
   
   function new(input string inst = " DRV", uvm_component c);
      super.new(inst, c);
   endfunction
   
   transaction data;
   virtual add_if aif;
   
   
   
   ///////////////////reset logic
   task reset_dut();
      aif.rst <= 1'b1;
      aif.a   <= 0;
      aif.b   <= 0;
      repeat(5) @(posedge aif.clk);
      aif.rst <= 1'b0; 
      `uvm_info("DRV", "Reset Done", UVM_NONE);
   endtask
   
   
   
   ////////////////////////////////////////////////////
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      data = transaction::type_id::create("data");
      
      if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
	`uvm_error("DRV","Unable to access uvm_config_db");
   endfunction
   
   
   
   virtual task run_phase(uvm_phase phase);
      reset_dut();
      forever begin 
         seq_item_port.get_next_item(data);
         aif.a <= data.a;
         aif.b <= data.b;
         seq_item_port.item_done(); 
         `uvm_info("DRV", $sformatf("Trigger DUT a: %0d ,b :  %0d",data.a, data.b), UVM_NONE); 
         @(posedge aif.clk);
         @(posedge aif.clk);
      end
      
   endtask
endclass

////////////////////////////////////////////////////////////////////////
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)
   
   uvm_analysis_port #(transaction) send;
   
   function new(input string inst = "MON", uvm_component c);
      super.new(inst, c);
      send = new("Write", this);
   endfunction
   
   transaction t;
   virtual add_if aif;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS");
      if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
	`uvm_error("MON","Unable to access uvm_config_db");
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      @(negedge aif.rst);
      forever begin
         repeat(2)@(posedge aif.clk);
         t.a = aif.a;
         t.b = aif.b;
         t.y = aif.y;
         `uvm_info("MON", $sformatf("Data send to Scoreboard a : %0d , b : %0d and y : %0d", t.a,t.b,t.y), UVM_NONE);
         send.write(t);
      end
   endtask
endclass

///////////////////////////////////////////////////////////////////////
class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)
   
   
   
   uvm_analysis_imp #(transaction,scoreboard) recv;
   
   transaction data;
   
   function new(input string inst = "SCO", uvm_component c);
      super.new(inst, c);
      recv = new("Read", this);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      data = transaction::type_id::create("TRANS");
   endfunction
   
   virtual function void write(input transaction t);
      data = t;
      `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0d , b : %0d and y : %0d",t.a,t.b,t.y), UVM_NONE);
      if(data.y == data.a + data.b)
	`uvm_info("SCO","Test Passed", UVM_NONE)
      else
	`uvm_info("SCO","Test Failed", UVM_NONE);
   endfunction
endclass
////////////////////////////////////////////////

class agent extends uvm_agent;
   `uvm_component_utils(agent)
   
   
   function new(input string inst = "AGENT", uvm_component c);
      super.new(inst, c);
   endfunction
   
   monitor m;
   driver d;
   uvm_sequencer #(transaction) seq;
   
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m = monitor::type_id::create("MON",this);
      d = driver::type_id::create("DRV",this);
      seq = uvm_sequencer #(transaction)::type_id::create("SEQ",this);
   endfunction
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      d.seq_item_port.connect(seq.seq_item_export);
   endfunction
endclass

/////////////////////////////////////////////////////

class env extends uvm_env;
   `uvm_component_utils(env)
   
   
   function new(input string inst = "ENV", uvm_component c);
      super.new(inst, c);
   endfunction
   
   scoreboard s;
   agent a;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      s = scoreboard::type_id::create("SCO",this);
      a = agent::type_id::create("AGENT",this);
   endfunction
   
   
   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      a.m.send.connect(s.recv);
   endfunction
   
endclass

////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   
   function new(input string inst = "TEST", uvm_component c);
      super.new(inst, c);
   endfunction
   
   generator gen;
   env e;
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      gen = generator::type_id::create("GEN",this);
      e = env::type_id::create("ENV",this);
   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      gen.start(e.a.seq);
      #60;
      phase.drop_objection(this);
      
   endtask
endclass
//////////////////////////////////////

module add_tb();
   
   add_if aif();
   
   initial begin
      aif.clk = 0;
      aif.rst = 0;
   end  
   
   always #10 aif.clk = ~aif.clk;
   
   
   add dut (.a(aif.a), .b(aif.b), .y(aif.y), .clk(aif.clk), .rst(aif.rst));
   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end
   
   initial begin  
      uvm_config_db #(virtual add_if)::set(null, "*", "aif", aif);
      run_test("test");
   end
   
endmodule


















































































