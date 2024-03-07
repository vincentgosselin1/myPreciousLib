[quote="SARTH21, post:5, topic:36857"]
Hello sir ,
Now the clock falls in the interface .That issue was solved. I didn’t instantiated properly . Now I have another issue with clk_sequence .

Following is from clk_sequence code .

```
  task body();
    REQ req; 
  begin
    req = trans::type_id::create("req");
    start_item(req);
    req.period =      20 ;
    req.phase_shift = '0 ;
    req.init_rst =    '0 ;
    req.init_clk =    '0 ;
    finish_item(req);
  end
endtask

```

Here I am just giving an initial value for clock and reset . Following is driver code

```
  task run_phase (uvm_phase phase);
    REQ req ;
   begin
    seq_item_port.get_next_item(req);
    drive_rst(req);
    drive_clk(req);
    seq_item_port.item_done(req);
  end
endtask

//Drive clk task 
task drive_clk(REQ req);
begin
 fork
  logic init_clk_value ;
  logic phase_shift    ;
  logic half_period    ;

  init_clk_value = req.init_clk    ;
  phase_shift    = req.phase_shift ;
  half_period    = req.period/2  ;

  if(phase_shift)begin
    #phase_shift;
  end 
  vif.clk = init_clk_value ;
  forever begin
    vif.clk = #half_period ~vif.clk ;
  end
join_none
end


//Drive rst task
task drive_rst(REQ req);
begin
  fork
  begin
    logic rst_val ;
    logic init_clk_value ;

    init_clk_value = req.init_clk ;
    rst_val        = req.init_rst ;

    @(posedge vif.clk)
    #1step;
    vif.rst = rst_val ;
  end
join_none
end
endtask


```

Now I know forever loop is causing following errors
//Iteration limit reached 10000 at time 0 ns ;
Is there any other way to drive clk and rst properly throughout the simulation ?
But keeping a separate agent for now is necessary.
[/quote]



  Thank you .The solution was changing Data types from

    logic to int
    Running the test in hdl_top itself.
