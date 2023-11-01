module mult #(
    parameter INT_SIZE=16
) (
    input wire clk,
    input wire rst,
    input wire [0:INT_SIZE*2-1] a,
    input wire [0:INT_SIZE*2-1] b,
    input wire start,

    output reg [0:INT_SIZE*2 - 1] result,
    output reg busy,
    output reg done
    
);

always @(posedge clk) begin
    if(~rst) begin
        result <= 0;
        done <= 0;
        busy <= 0;
    end else if(start) begin
        result <= a * b;
        done <= 0;
        busy <= 1;
    end else begin
        busy <= 0;
        done <= 1;
    end
end
endmodule