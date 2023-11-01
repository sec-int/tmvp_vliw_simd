module tmvp22_tb;

  // ==========================
  // System clock
  // ==========================

  wire clk;
  reg enable_clk = 1;
  reg start = 0;


  reg [15:0] t [7:0];
  initial begin
      t[0] = 0;
      t[1] = 1; 
      t[2] = 2;
      t[3] = 3;
      t[4] = 4;
      t[5] = 5;
      t[6] = 6;
      t[7] = 7;
  end
  reg [2:0] t_counter = 0;
  reg [15:0] current_t;
  reg [15:0] result;
  reg running;

  clock m_sys_clk (
    .enable(enable_clk),
    .clk(clk)
  );

  always @(posedge clk) begin
    if(running) begin
      current_t <= t[t_counter];
      t_counter <= t_counter + 1;
    end else if(start) running <= 1;
  end


  // ==========================
  // Machine
  // ==========================
  reg rst = 1;
  tmvp22 dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .in_val(current_t),
    .out_val(result)
  );

  // ==========================
  // Tests and monitoring
  // ==========================

  initial begin
    // $readmemh("memory.list", m_machine.m_ram.mem);
    $dumpfile("waveform.vcd");
    $dumpvars(0, dut);
    // $dumpvars(0, dut.ram[0]);
    // $dumpvars(0, dut.pmem[0]);

    #10 rst = 0;
    #10 rst = 1;
    #10 start = 1;
    #10 start = 0;
    #1000;
    $stop;
  end
endmodule