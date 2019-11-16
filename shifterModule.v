//Shifter module
module shifter(a, leftShift, rightShift);
    input [15:0] a;
    output [15:0] leftShift;
    output [15:0] rightShift;

    always @(posedge clk)

    leftShift = a << 1;
    rightShift = a >> 1;

endmodule
