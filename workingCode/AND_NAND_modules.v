//=============================================
//  And Nand module
//  Author: Bowen Jiang
//
//  Description: 
//      This module takes in two 16-bit number
//      for input and make the 'and' and 'nand' 
//      result of it to be a 16-bit 
//      output on the positive edge of the
//      clock.
//=============================================
//=============================================
// AND module
//=============================================
module and_gate (a, b, andout);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        output [15:0] andout;
        reg [15:0] reg_andout;

    always @(*) begin
        reg_andout = a & b;

    end

    assign andout = reg_andout;

endmodule

//=============================================
// NAND module
//=============================================
module nand_gate (a, b, nandout);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        output [15:0] nandout;
        reg [15:0] reg_nandout;

    always @(*) begin
        reg_nandout = ~(a & b);
    end

    assign nandout = reg_nandout;

endmodule
