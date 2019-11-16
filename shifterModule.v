//Shifter module
module shifter(a, sel, outShift);
    input [15:0] a;
    input sel;          //sel is the selector and can be 0 or 1 for shift left and right respective
    output [15:0] outShift;

    always @(posedge clk)

    if(sel == 0)
        outShift = a << 1;
    else(sel == 1)
        outShift = a >> 1;

endmodule
