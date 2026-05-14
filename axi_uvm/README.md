# AXI UVM VIP Wrapper

A UVM agent that wraps the Xilinx AXI VIP master, providing a clean
sequence-based API for AXI4 write and read burst transactions.

---

## File structure

```
axi_uvm_pkg.sv       ← top-level package; `include`s everything below
  axi_seq_item.sv    ← transaction object (rand fields + response fields)
  axi_driver.sv      ← UVM driver; calls Xilinx VIP AXI4_WRITE/READ_BURST
  axi_monitor.sv     ← UVM monitor + axi_if virtual interface definition
  axi_agent.sv       ← bundles sequencer, driver, monitor; forwards ap_write/ap_read
  axi_sequences.sv   ← axi_base_seq, axi_write_seq, axi_read_seq,
                        axi_write_read_seq, axi_rand_seq
tb_uvm.sv            ← updated top-level testbench + example tests
```

---

## Integration steps

### 1 – Compile order

```
axi_vip_pkg          (Xilinx, from IP catalog)
axi_vip_master_pkg   (Xilinx, from IP catalog)
uvm_pkg              (simulator built-in)
axi_uvm_pkg.sv       (this repo – pulls in all sub-files via `include)
tb_uvm.sv
```

### 2 – Virtual interface

`axi_if` is defined at the top of `axi_monitor.sv`.
Instantiate it in `tb_uvm` (already done) and connect every signal to the
flat bus wires that feed both the Xilinx VIP and the DUT.

### 3 – VIP agent handle

The UVM driver delegates bus cycles to the Xilinx VIP.
Pass the handle via `uvm_config_db` **before** `run_test()`:

```systemverilog
axi_mst_agent_t h = new("h", axi_mst.inst.IF);
h.start_master();
uvm_config_db #(axi_mst_agent_t)::set(null, "uvm_test_top.*", "vip_agent", h);
run_test();
```

Alternatively, assign it directly on the agent object after creation:

```systemverilog
agent.vip_agent = h;
```

### 4 – Running a test

```
vsim tb_uvm +UVM_TESTNAME=axi_write_read_test
vsim tb_uvm +UVM_TESTNAME=axi_rand_test
```

---

## Sequence API quick-reference

| Sequence               | Key fields to set                         | Outputs              |
|------------------------|-------------------------------------------|----------------------|
| `axi_write_seq`        | `addr`, `len`, `size`, `burst`, `data[]`  | `wresp`              |
| `axi_read_seq`         | `addr`, `len`, `size`, `burst`            | `rdata[]`, `rresp[]` |
| `axi_write_read_seq`   | `addr`, `len`, `size`, `burst`, `check_data` | `wresp`, `rdata[]`, `rresp[]` |
| `axi_rand_seq`         | `num_txns`                                | —                    |

### Example: directed write then read

```systemverilog
task run_sequences();
    axi_write_seq wr = axi_write_seq::type_id::create("wr");
    axi_read_seq  rd = axi_read_seq ::type_id::create("rd");

    wr.addr = 32'h0000_1000;
    wr.len  = 3;                      // 4 beats
    wr.data = new[4];
    wr.data = '{32'hAABBCCDD, 32'h11223344, 32'hDEADBEEF, 32'hC0DECAFE};
    wr.start(agent.sequencer);

    rd.addr = 32'h0000_1000;
    rd.len  = 3;
    rd.start(agent.sequencer);

    foreach (rd.rdata[i])
        `uvm_info("TEST", $sformatf("beat[%0d] = 0x%08h resp=%0s",
            i, rd.rdata[i], rd.rresp[i].name()), UVM_MEDIUM)
endtask
```

---

## Analysis ports

Both `axi_agent.ap_write` and `axi_agent.ap_read` broadcast completed
`axi_seq_item` transactions.  Connect a scoreboard or coverage collector:

```systemverilog
agent.ap_write.connect(scoreboard.analysis_export);
agent.ap_read .connect(coverage.analysis_export);
```

---

## Extending

* **Add an ID field** – extend `axi_seq_item` with `rand logic [ID_W-1:0] id`
  and pass it through driver calls.
* **Passive snooping** – set `is_active = UVM_PASSIVE` on a second agent
  instance; only the monitor is created, no driver or sequencer.
* **Out-of-order IDs** – add a TLM FIFO per ID in the monitor's write path
  to handle interleaved B-channel responses.
