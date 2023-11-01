`timescale 1ns/10ps

module adder_tb;
reg clk = 0;
reg [0:15] a = 16'h2;
reg [0:15] b = 2;
wire [0:15] result;
reg rst = 1;
reg start = 0;
wire done;

adder dut (
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .start(start),
    .result(result),
    .done(done)
);

always #4 clk = ~clk;

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, dut);
    #2
    rst = 0;
    #3
    rst = 1;
    #5
    start = 1;
    #3
    start = 0;
    
    #20

    a = 16'hFFFF;
    #5
    start = 1;
    #8
    start = 0;
    #20
    $finish;
end
endmodule