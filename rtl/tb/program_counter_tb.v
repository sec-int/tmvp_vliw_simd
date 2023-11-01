`timescale 1ns/10ps

module pc_tb;
reg clk;
reg jmp_en = 0;
reg enable_clk = 0;
wire [5:0] jmp_target = 'd5;
wire [5:0] program_counter;
reg rst = 1;
reg start = 0;
wire done;

clock m_sys_clk (
    .enable(enable_clk),
    .clk(clk)
);

program_counter dut (
    .clk(clk),
    .rst(rst),
    .jmp_en(jmp_en),
    .jmp_target(jmp_target),
    .program_counter(program_counter)
);

initial begin
    $dumpfile("computer.vcd");
    $dumpvars(0, dut);
    #1
    enable_clk = 1;
    #2
    rst = 0;
    #3
    rst = 1;
    #5
    start = 1;
    #3
    start = 0;
    
    #20
    jmp_en = 1;
    #5

    jmp_en = 0;
    #20

    $finish;
end
endmodule