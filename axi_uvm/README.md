# AXI UVM VIP – Parameterized Multi-Agent

A fully parameterized UVM AXI4 agent library.  A single set of source
files supports any number of AXI buses with different widths coexisting
in the same testbench.

---

## Key design decision: why a parameter class instead of `#(int ADDR_W, ...)`?

SystemVerilog packages cannot be parameterized.  The classic workaround
is to parameterize every class individually, but that means every
instantiation must repeat all width values and they can easily get out
of sync.

The solution here is a **parameter container class** (`axi_params`).
Each bus configuration is a single typedef:

```systemverilog
typedef axi_params #(.ADDR_W(32), .DATA_W(64), .ID_W(1), .USER_W(1))
    hp_params_t;
```

Every component is then parameterized with that one type:

```systemverilog
axi_agent    #(hp_params_t) hp_agent;
axi_seq_item #(hp_params_t) item;
axi_write_seq#(hp_params_t) seq;
```

All widths and enum types are accessed through the parameter type as
`P::DATA_W`, `P::AXI_SIZE_4B`, `P::axi_resp_t`, etc.

---

## File structure

```
axi_params.sv       ← virtual class axi_params + axi_if interface definition
axi_uvm_pkg.sv      ← package; `include`s the files below
  axi_seq_item.sv   ← parameterized transaction object
  axi_driver.sv     ← parameterized driver (calls Xilinx VIP)
  axi_monitor.sv    ← parameterized monitor
  axi_agent.sv      ← parameterized agent (sequencer + driver + monitor)
  axi_sequences.sv  ← parameterized sequence library
tb_multi_agent.sv   ← example TB with two agents + env + tests
```

> **Note:** `axi_params.sv` is compiled outside the package because
> `axi_if` (an `interface`) cannot be declared inside a `package`.

---

## Compilation order

```
1. axi_vip_pkg              (Xilinx)
2. axi_vip_master_pkg       (Xilinx, one per VIP instance variant)
3. uvm_pkg                  (simulator built-in)
4. axi_params.sv            (interface + param class, outside package)
5. axi_uvm_pkg.sv           (pulls in seq_item, driver, monitor, agent, seqs)
6. tb_multi_agent.sv        (top-level TB + env + tests)
```

---

## Adding a new bus to an existing TB

**Step 1 – Declare the parameter typedef** (once, anywhere visible):
```systemverilog
typedef axi_params #(.ADDR_W(64), .DATA_W(512), .ID_W(8), .USER_W(4))
    hbm_params_t;
```

**Step 2 – Add a virtual interface** to the TB module:
```systemverilog
axi_if #(.ADDR_W(64), .DATA_W(512), .ID_W(8), .USER_W(4))
    hbm_if (.aclk(aclk), .aresetn(aresetn));
```

**Step 3 – Add an agent** to the environment:
```systemverilog
axi_agent #(hbm_params_t) hbm_agent;
```

**Step 4 – Publish to config_db** in the TB `initial` block:
```systemverilog
uvm_config_db #(hbm_params_t::vif_t)::set(
    null, "uvm_test_top.env.hbm_agent.*", "vif", hbm_if);
uvm_config_db #(axi_vip_master_mst_t)::set(
    null, "uvm_test_top.env.hbm_agent",   "vip_agent", hbm_vip_h);
```

That's it – no changes to any shared library file.

---

## Sequence API

All sequences take the same `P` type as the agent they target.

| Sequence                  | Key knobs                                    | Outputs                       |
|---------------------------|----------------------------------------------|-------------------------------|
| `axi_write_seq #(P)`      | `addr`, `len`, `id`, `size`, `burst`, `data[]` | `wresp`                     |
| `axi_read_seq  #(P)`      | `addr`, `len`, `id`, `size`, `burst`         | `rdata[]`, `rresp[]`          |
| `axi_write_read_seq #(P)` | above + `check_data`                         | `wresp`, `rdata[]`, `rresp[]` |
| `axi_rand_seq  #(P)`      | `num_txns`                                   | —                             |

### Parallel sequences on two ports

```systemverilog
fork
    begin
        axi_write_read_seq #(hp_params_t) hp_seq = ...;
        hp_seq.start(env.hp_agent.sequencer);
    end
    begin
        axi_rand_seq #(gp_params_t) gp_seq = ...;
        gp_seq.start(env.gp_agent.sequencer);
    end
join
```

---

## Analysis ports

Each agent exposes `ap_write` and `ap_read`.  Connect a scoreboard:

```systemverilog
env.hp_agent.ap_write.connect(scoreboard.hp_write_export);
env.gp_agent.ap_read .connect(scoreboard.gp_read_export);
```

---

## UVM factory overrides

Each specialisation registers independently with the factory:

```systemverilog
// Replace the default seq_item with an extended one for the HP port only
axi_seq_item #(hp_params_t)::type_id::set_type_override(
    my_hp_seq_item #(hp_params_t)::get_type());
```
