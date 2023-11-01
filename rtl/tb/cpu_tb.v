// `timescale  1 ns / 1 ps
module cpu_tb;
  // ==========================
  // System clock
  // ==========================

  wire clk;
  reg enable_clk = 1;
  reg enable = 0;
  wire [15:0] dout = 'b0;
  reg [15:0] din = 'b0;
    
  clock m_sys_clk (
    .enable(enable_clk),
    .clk(clk)
  );


  // ==========================
  // Machine
  // ==========================
  reg rst = 1;
  cpu dut (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .data_out(dout),
    .data_in(din)
  );

  // ==========================
  // Tests and monitoring
  // ==========================

  initial begin
    // $readmemh("memory.list", m_machine.m_ram.mem);
    $dumpfile("waveform.vcd");
    $dumpvars(0, dut, 
      dut.fetch0.registers[1], 
      dut.fetch0.registers[2], 
      dut.fetch0.registers[3], 
      dut.fetch0.registers[4],
      dut.fetch0.registers[5],
      dut.fetch0.addr_history[0],
      dut.fetch0.addr_history[1]
    );

    #10 rst = 0;
    #10 rst = 1;
    #10 enable = 1;
    #10 enable = 0;
    #1000;
    $stop;
  end
endmodule