//=============================================
//  accumulator module
//  Author: Bowen Jiang
//
//  Description: 
//      This module takes in a 16-bit number
//      for input and make it to be a 16-bit 
//      output on the positive edge of the
//      clock.
//=============================================
//=============================================
// Accumulator module
//=============================================
module accum (D, Q, clk); 
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input  [15:0] D; 
        input clk;
        output [15:0] Q; 
        reg    [15:0] tmp;  
        reg [15:0] reg_Q;

    always @(posedge clk) begin
        tmp = D;  
        reg_Q = tmp; 
    end 

    assign Q = reg_Q;
endmodule
