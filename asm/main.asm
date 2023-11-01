#bits 16

#subruledef register
{
    r0  => 0x000
    r1  => 0x001
    r2  => 0x002
    r3  => 0x003
    r4  => 0x004
    r5  => 0x005
    r6  => 0x006
    r7  => 0x007
    r8  => 0x008
    r9  => 0x009
    r10 => 0x00A
    r11 => 0x00B
    r12 => 0x00C
    r13 => 0x00D
    r14 => 0x00E
    r15 => 0x00F

}

#ruledef
{
    ; Inserts an empty cycle into the pipeline.
    nop                      => 0x0000
    
    ; Halts the execution of the CPU.
    hlt                      => 0xffff

    ; Adds a register to the `acc` and updates the `acc`.
    add {source: register}   => 0x2 @ source

    ; Multiplies a register with `acc` and updates it.
    mul {source: register}   => 0x3 @ source

    ; Does a jump relative to that address if the `acc` equals to 0.
    jmpzr {addr}             => 0x6 @ addr`12

    ; Writes the value in the `acc` back into the given register.
    store {source: register} => 0x4 @ source

    ; Loads a value from a register into the `acc`.
    load {source: register}  => 0x5 @ source

    ; Loads a 12-bit value immediately into the `acc`.
    loadi {immediate}        => 0x1 @ immediate`12

    ; Add immediately the 12-bit value to the `acc`.
    addi {immediate}         => 0x7 @ immediate`12

    ; Multiply immediately the `acc` with the immediate value.
    muli {immediate}        => 0x8 @ immediate`12
}

nop
addi 2
nop
loadi 0b0000_1111_0001
add r4
add r5
add r6
add r7
nop
nop
nop
jmpzr -1
hlt