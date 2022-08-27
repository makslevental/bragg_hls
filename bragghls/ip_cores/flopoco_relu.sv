`timescale 1ns/1ps
module frelu
    #(parameter
        ID=1,
        WIDTH=16
    )(
    input clk,
    input wire[WIDTH-1:0] a,
    output reg[WIDTH-1:0] res
);
    always @(posedge clk) begin
        res <= (a[WIDTH-3] == 0) ? a:0;   //if the sign bit is high, send zero on the output else send the input
    end
endmodule
