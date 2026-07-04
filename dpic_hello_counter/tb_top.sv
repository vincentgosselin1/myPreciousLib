//=============================================================================
// tb_top.sv
//
// Minimal DPI-C example:
//   1. SV passes a byte of data to a C function.
//   2. The C function increments a static counter and returns its value.
//   3. SV prints "HelloWorld, here is the value of the counter %0d".
//=============================================================================
module tb_top;

  // Implemented in counter.c
  import "DPI-C" function int increment_counter(input byte data);

  byte data;
  int  count;

  initial begin
    data = 8'hAA;

    // Call it a few times to show the counter incrementing across calls.
    count = increment_counter(data);
    $display("HelloWorld, here is the value of the counter %0d", count);

    data = 8'h01;
    count = increment_counter(data);
    $display("HelloWorld, here is the value of the counter %0d", count);

    data = 8'hFF;
    count = increment_counter(data);
    $display("HelloWorld, here is the value of the counter %0d", count);

    $finish;
  end

endmodule
