-- This repository is moved to https://github.com/bi-tud-sds/tmvp_vliw_simd --

# Crypto Accelerator
The CPU contains a 4-stage pipeline.
There is no hazard or data dependency checking.

Word size is 16 bit, but register size is 32 bit. 
Therefore one instruction computes two sums at the same time.

There are 2 ALUs in parallel. Each instruction is 32 bit ( = 16 bit + 16 bit) wide.

## RAM

- Size: 2048 bit (128 words)
- Memory width: 32 bit
- Address width: 32 bit

## ALU Register File

- 16 registers
- each 32 bit, (= 2 words)

## Instruction Set

- `MULT` - Implemented. Executes two multiplications in a single instruction.
- `ADD` - Implemented. Executes two addtions in a single instruction.
- `MAC` - Implemented. Executes a_high * b_high + a_low * b_low and stores result in the target register in a single instruction.
- `JMP NZ` 
- `LOAD`
- `STORE`
- `LOADI` - implemented. Halfwords can be loaded immediately into lower or higer part of the word.

## Instruction Format

One instruction is 32 bit wide, 16 bits for each of the two ALUs.

|OpCode  | Reg Source 1 | Reg Source 2 | Result WB Reg |OpCode  | Reg Source 1 | Reg Source 2 | Result WB Reg |
|--------|--------------|--------------|---------------|--------|--------------|--------------|---------------|
|4 bits  | 4 bits       | 4 bits       | 4 bit         |4 bits  | 4 bits       | 4 bits       | 4 bit         |
