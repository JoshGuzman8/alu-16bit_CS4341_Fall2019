//=============================================
//  Not module
//  Author: Bowen Jiang
//
//  Description: 
//      This module takes in a 16-bit number
//      for input and make the swap of it to be a 16-bit 
//      output on the positive edge of the
//      clock.
//=============================================
//=============================================
// Not module
//=============================================
module not_gate (a,clk, notout);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
    input [15:0] a;
    input clk;
    output [15:0] notout;
  
    reg [15:0] reg_notout;
  
    always @(*) begin
        reg_notout = ~a ;
    end

    assign notout = reg_notout;

endmodule


