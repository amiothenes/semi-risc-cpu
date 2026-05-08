# Semi-RISC CPU, 32-bit Processor in VHDL

A fully functional 32-bit semi-RISC processor designed and implemented in VHDL from scratch, built across two lab phases for COE608 (Computer Architecture) at Toronto Metropolitan University. Phase I established the reset/clock foundation; Phase II delivered the complete CPU, ALU, FSM control unit, datapath, registers, memory, and a full testbench.

## Architecture

- **Harvard architecture**, separate instruction memory and data memory (1KB)
- **32-bit external data bus**, 16-bit instruction bus, 8-bit data memory addressing
- **Two 32-bit working registers** (A, B) plus 1-bit status registers for Carry (C) and Zero (Z)
- **Multi-cycle execution**, 3-stage: Instruction Fetch (T0) -> Pre-decode (T1) -> Decode/Execute (T2)
- **Load/Store architecture**, all computation performed in working registers

## Module Hierarchy

```
cpu1.vhd                    <- Top-level CPU integration
├── reset_circuit.vhd       <- Clock and reset logic
├── control_new.vhd         <- FSM control unit (T0/T1/T2 state machine)
├── Data_Path.vhd           <- Datapath: registers, MUXes, buses
│   ├── register32.vhd      <- 32-bit general-purpose register (A, B)
│   ├── alu.vhd             <- ALU (arithmetic, logic, shift, clear ops)
│   │   └── add.vhd -> adder32.vhd -> adder16.vhd -> adder4.vhd -> fulladd.vhd
│   ├── mux2to1.vhd         <- 2-to-1 multiplexer
│   ├── mux4to1.vhd         <- 4-to-1 multiplexer
│   ├── pc.vhd              <- Program Counter
│   ├── LZE.vhd             <- Lower zero-extend (immediate values)
│   ├── UZE.vhd             <- Upper zero-extend
│   └── RED.vhd             <- Register extension/decode unit
├── data_mem.vhd            <- 1KB data memory (8-bit addressed)
└── system_memory.vhd       <- Instruction memory (initialized via .mif)
cpu_test_sim.vhd            <- Simulation testbench
```

## Instruction Set (26 instructions)

| Category | Instructions |
|---|---|
| Load Immediate | `LDAI`, `LDBI`, `LUI` |
| Memory | `LDA`, `LDB`, `STA`, `STB` |
| Arithmetic | `ADD`, `ADDI`, `SUB`, `INCA`, `DECA` |
| Logic | `AND`, `ANDI`, `ORI`, `ROL`, `ROR` |
| Clear | `CLRA`, `CLRB`, `CLRC`, `CLRZ` |
| Control Flow | `JMP`, `BEQ`, `BNE`, `TSTZ`, `STTC` |

Instructions are 32 bits wide. `IR[31:28]` selects instruction class; data processing ops share OpCode `0111`, differentiated by function bits `IR[27:24]`.

## Tools

- **Language:** VHDL
- **IDE / Synthesis:** Quartus Prime (Intel FPGA)
- **Simulation:** Quartus Functional Simulation + ModelSim
- **Target Board:** Intel DE2-115 (Cyclone IV E FPGA)

## Project Structure

```
semi-risc-cpu/
├── Part I/           <- Phase 1: reset circuit foundation
│   ├── reset_circuit.vhd
│   └── Screenshots/
└── Part II/          <- Phase 2: full CPU implementation
    ├── *.vhd         <- All VHDL source files
    ├── Screenshots/  <- Waveform verification (per instruction)
    ├── Lab6_Pt1.qpf  <- Quartus project file
    └── system_memory.mif <- Instruction memory initialization
```

## Simulation & Waveform Verification

Each instruction was independently simulated in **Quartus Prime** and verified via waveform inspection across all three execution stages (T0/T1/T2). Register binary states, memory signals, and control line assertions were validated per instruction.

| Instruction | Waveform |
|---|---|
| ADD | ![ADD](Part%20II/Screenshots/ADD.png) |
| ADDI | ![ADDI](Part%20II/Screenshots/ADDI.png) |
| SUB | ![SUB](Part%20II/Screenshots/SUB.png) |
| INCA | ![INCA](Part%20II/Screenshots/INCA.png) |
| DECA | ![DECA](Part%20II/Screenshots/DECA.png) |
| LDAI / STA / CLRA / LDA | ![Load/Store A](Part%20II/Screenshots/LDAI_STA_CLRA_LDA.png) |
| LDBI / STB / CLRB / LDB | ![Load/Store B](Part%20II/Screenshots/LDBI_STB_CLRB_LDB.png) |
| LUI | ![LUI](Part%20II/Screenshots/LUI.png) |
| ANDI | ![ANDI](Part%20II/Screenshots/ANDI.png) |
| ORI | ![ORI](Part%20II/Screenshots/ORI.png) |
| ROL | ![ROL](Part%20II/Screenshots/ROL.png) |
| ROR | ![ROR](Part%20II/Screenshots/ROR.png) |
| JMP | ![JMP](Part%20II/Screenshots/JMP.png) |
| BEQ | ![BEQ](Part%20II/Screenshots/BEQ.png) |
| BNE | ![BNE](Part%20II/Screenshots/BNE.png) |

## Course

COE608, Computer Organization and Architecture
Toronto Metropolitan University, 2025
