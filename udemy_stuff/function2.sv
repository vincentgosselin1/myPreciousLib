//function2.sv

class temp;

   bit [7:0] data;


   function void read(input bit [7:0] data);
      this.data = data;
   endfunction // read

endclass // temp

module tb;

   temp t;

  initial begin
     t = new();
     t.read(8'b11111111);
     #10;
     $display("Value of data member : %0b", t.data);
  end
   
