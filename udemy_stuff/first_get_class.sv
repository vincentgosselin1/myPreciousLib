class first;
   local int x = 25;

   function int get();
      return x;
   endfunction // get

endclass // first

module tb();
   first f1;
   int value;

   initial begin
      f1 = first.new();
      value = f1.get();
      $display("The value written is %0d", value);
   end
endmodule // tb

