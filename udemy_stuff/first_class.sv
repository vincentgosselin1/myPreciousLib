class first;
   bit x = 1'b1;
endclass;

module tb();

   first f1;// Name of the instance

   initial begin
      f1 = new();
      $display("----------");
      $display("The value of the x is %0b", f1.x);
      $display("----------");
   end

endmodule
