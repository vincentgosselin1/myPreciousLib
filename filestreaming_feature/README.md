# File Streaming Feature — Proposal Plan

**Lab Setup:** Versal VCK190 (AMD) → Ethernet Switch → Windows Lab PC
**Goal:** Stream a 32-bit hardware counter value from the Versal PL, through the PS (Linux), over Ethernet, into a text file on the PC.

---

## 1. Objective

Implement a hardware-to-software streaming pipeline that demonstrates the VCK190's PL↔PS↔Ethernet data path:

- A **32-bit free-running counter** is implemented in the Versal Programmable Logic (PL).
- The counter value streams into the Processing System (PS, Cortex-A72 APU running Linux).
- The PS forwards the stream over Ethernet (via the lab's switch) to a Windows PC.
- The PC logs incoming values to a plain text file in real time.

---

## 2. Architecture Overview

```
┌─────────────────────────── Versal VCK190 ───────────────────────────┐
│                                                                       │
│   PL: 32-bit counter (AXI4-Stream)                                   │
│         │                                                            │
│         ▼                                                            │
│   AXI DMA (S2MM) ──► DDR4 (via NoC)                                  │
│         │                                                            │
│   PS (Linux, APU): reads DDR4 buffer, streams over TCP               │
│         │                                                            │
└─────────┼──────────────────────────────────────────────────────────┘
          ▼
   [ Ethernet Switch ]
          │
          ▼
   Windows Lab PC: TCP receiver → counter_log.txt
```

---

## 3. Design Options Considered

| Option | Data path | Complexity | Notes |
|---|---|---|---|
| **A — AXI4-Lite (polled)** | PL register → PS reads via `/dev/mem` polling | Low | Good for first end-to-end bring-up; CPU actively polls each sample |
| **B — AXI4-Stream + AXI DMA (chosen)** | PL stream → AXI DMA → DDR4 → PS reads buffer | Medium–High | True hardware-driven streaming; low CPU overhead; scalable throughput |

**Decision:** Proceed with **Option B**, using the VCK190's onboard **DDR4** (via the NoC) as the DMA target rather than carving memory out of the PS's own system DDR4. This keeps the streaming buffer independent of Linux's memory pool and allows for a much larger buffer (ring-buffer capable) for sustained throughput.

---

## 4. Implementation Plan

### Phase 1 — PL Design (Vivado)
- [ ] Implement `axis_counter` module: 32-bit counter with AXI4-Stream master interface, asserting `TLAST` every N samples (burst boundary).
- [ ] Instantiate **AXI DMA** IP (S2MM channel only, Simple mode for v1) with 32-bit stream width.
- [ ] Connect counter's `m_axis_*` port to AXI DMA's S2MM stream slave.
- [ ] Add **NoC (DDRMC)** connectivity for DDR4; route AXI DMA's `M_AXI_S2MM` master through the NoC to the DDR4 controller.
- [ ] In **Address Editor**, assign:
  - AXI DMA control (AXI4-Lite) base address (e.g. `0xA0010000`)
  - AXI DMA's DDR4 target region (e.g. `0x60000000 – 0x6FFFFFFF`, 256MB)
- [ ] Generate bitstream and export XSA (include bitstream).

### Phase 2 — PS Platform (PetaLinux)
- [ ] Build PetaLinux BSP for VCK190 using the exported XSA.
- [ ] Add `reserved-memory` device tree node matching the DDR4 region reserved for DMA (`no-map`, non-cacheable).
- [ ] Bring up PS Ethernet (confirm VCK190 board's Ethernet PHY/MAC config in device tree).
- [ ] Verify network connectivity between VCK190 and PC through the lab switch (static IPs, same subnet, `ping` test).

### Phase 3 — PS Application
- [ ] Write userspace C app (`dma_stream.c`):
  - Map AXI DMA control registers via `/dev/mem`.
  - Map DDR4 target buffer (physical address) via `/dev/mem`.
  - Reset and start the S2MM DMA channel.
  - Program `S2MM_DA` / `S2MM_LENGTH` per burst; poll `S2MM_DMASR` for completion.
  - Read completed buffer contents; stream values to PC over TCP socket.
- [ ] Cross-compile with PetaLinux SDK; deploy and run on target (`sudo ./dma_stream` — requires `/dev/mem` access).

### Phase 4 — PC Receiver (Windows)
- [ ] Write `pc_receiver.py`: TCP server binding to a known port, appending received counter values (newline-delimited) to `counter_log.txt`.
- [ ] Confirm firewall allows inbound TCP on the chosen port.
- [ ] Start receiver before PS app; verify log file populates correctly.

### Phase 5 — Validation
- [ ] Confirm counter values increment monotonically in `counter_log.txt` with no gaps/duplicates.
- [ ] Measure achieved throughput (samples/sec) and compare against DMA burst configuration.
- [ ] Stress-test for extended run time (confirm no buffer overrun / stale-data issues from cache coherency).

---

## 5. Future Enhancements (Post-v1)

### 5.1 Scatter-Gather DMA + Ring Buffer

Simple mode (v1) requires the CPU to re-arm a new transfer after every burst completes — the DMA engine sits idle between the CPU noticing completion and reprogramming the next transfer. For sustained high sample rates, upgrade to **Scatter-Gather (SG) mode**:

- A **ring of descriptors** is built in the reserved DDR4 region, each describing one burst's worth of samples and pointing to the next descriptor (wrapping at the end).
- The AXI DMA engine walks the ring continuously and independently of the CPU, writing counter samples into successive buffers as long as there are "armed" descriptors ahead of its current position (tracked via the **tail descriptor pointer**).
- The PS app trails behind: it waits for a descriptor's `STATUS.Cmplt` bit, drains that descriptor's buffer over TCP, clears/resets the descriptor, and advances the tail pointer to recycle that slot back into the ring — so the DMA never runs out of work as long as the CPU keeps up.
- This decouples PL production rate from PS consumption rate (within the depth of the ring), smoothing out scheduling jitter on the PS side.

A reference skeleton (`dma_stream_sg.c`) is included with this proposal. It is **not a drop-in final driver** — descriptor field offsets and control/status bit positions must be verified against the AXI DMA Product Guide (PG021) for the exact IP version/configuration used in the Vivado design before relying on it in the lab. Recommended follow-up before use:
- Confirm descriptor struct layout (`NXTDESC`, `BUFFER_ADDRESS`, `CONTROL`, `STATUS` fields) matches the generated IP.
- Replace the busy-wait polling loop with an **interrupt-driven** wait (S2MM introduction interrupt) once functionally correct, to reduce CPU load further.
- Tune `N_DESC` (ring depth) and `BURST_LEN` (samples per descriptor) against the reserved DDR4 region size and desired latency/throughput trade-off.

### 5.2 Other Enhancements

- **UDP instead of TCP:** lower overhead if occasional dropped samples are acceptable.
- **Cache coherency review:** if routing DMA writes through the coherent interconnect (CCI) instead of marking the region non-cacheable, revisit device tree cacheability attributes.
- **Configurable sample rate / burst size:** expose via AXI-Lite control register instead of RTL parameter.
- **IRQ-driven completion (both modes):** replace register polling with a proper interrupt handler for lower CPU overhead and lower latency.

---

## 6. Open Items / Risks

- VCK190 carrier-card-specific Ethernet PHY configuration must be confirmed before PS networking will come up correctly.
- Cache coherency between PL-written DDR4 data and PS reads must be handled correctly (non-cacheable region for v1) to avoid stale reads.
- DDR4 address range for the DMA target must not overlap the PS's own Linux-managed memory region — verify in Address Editor and device tree memory map.

---

## 7. Reference Implementation Files

The following source files accompany this proposal:

| File | Description |
|---|---|
| `axis_counter.v` | PL counter with AXI4-Stream master interface, configurable burst length via `TLAST` |
| `system-user.dtsi` | PetaLinux device tree overlay reserving the DDR4 region for the DMA target buffer |
| `dma_stream.c` | PS userspace app — **v1, Simple mode**: single-burst DMA transfers, CPU re-arms each one, streams to PC over TCP |
| `dma_stream_sg.c` | PS userspace app — **v2, Scatter-Gather mode (reference skeleton)**: descriptor ring for continuous DMA streaming; verify against PG021 before lab use |
| `pc_receiver.py` | Windows PC TCP server, appends received counter values to `counter_log.txt` |

**Recommended build order:** get `axis_counter.v` + `dma_stream.c` (v1, Simple mode) working end-to-end first, validate the full PL→PS→Ethernet→PC pipeline, then swap in `dma_stream_sg.c` once the SG descriptor fields have been confirmed against the actual AXI DMA IP configuration in the Vivado design.
