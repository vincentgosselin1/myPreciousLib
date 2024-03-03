class parent;
   int x = 23;
endclass // parent

class derived extends parent;
   int y = 66;
endclass // derived

module tb();
   derived d1;

   initial begin
      d1 = new();
      $display("The value of x and y inside derived class is %0d and %0d", d1.x, d1.y);
   end
endmodule // tb
