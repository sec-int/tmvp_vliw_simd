module bram_tb;

  wire clk;
  reg enable_clk = 0;

  clock m_sys_clk (
    .enable(enable_clk),
    .clk(clk)
  );

  reg rst = 1;
  reg [15:0] reg_input = 16'habcd;
  reg [15:0] wenable = 16'h1;
  reg [4:0] selector1 = 'd4;
  reg [4:0] selector2 = 'd4;

  reg [15:0] output1;
  reg [15:0] output2;
  
  regbank dut (
    .ck(clk),
    .rn(rst),
    .inp(reg_input),
    .wen(wenable),
    .sel1(selector1),
    .sel2(selector2),
    .out1(output1),
    .out2(output2)
  );
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, dut);
    #10 rst = 0;
    #10 rst = 1;
    #10 enable_clk = 1;
    #5 selector2 = 0; 
    #5 wenable = 16'h2;
    #100;
    $stop;
  end
    
endmodule