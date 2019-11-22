//=============================================
//  shifter module
//  Author: Josh Guzman
//
//  Description: 
//      This module takes in a 16-bit number
//      and does a left and right shift of the
//      the number on the positive edge of the
//      clock.
//=============================================
module shifter(a, clk, leftShift, rightShift);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a;             //16-bit number
        input clk;                  //1-bit clock
        output [15:0] leftShift;    //a shifted to left
        output [15:0] rightShift;   //a shifted to right
    
        reg [15:0] reg_leftShift, reg_rightShift;   //reg to hold primatives to pass to wire

    always @(*) begin
        reg_leftShift = a << 1;
        reg_rightShift = a >> 1;
    end
    
    assign leftShift = reg_leftShift;
    assign rightShift = reg_rightShift;

endmodule
