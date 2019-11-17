//=============================================
// shifter module
//=============================================
module shifter(a, clk, leftShift, rightShift);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a;
        input clk;
        output [15:0] leftShift;
        output [15:0] rightShift;
    
        reg [15:0] reg_leftShift, reg_rightShift;

    always @(posedge clk) begin
        reg_leftShift = a << 1;
        reg_rightShift = a >> 1;
    end
    
    assign leftShift = reg_leftShift;
    assign rightShift = reg_rightShift;

endmodule