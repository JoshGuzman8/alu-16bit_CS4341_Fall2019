//=============================================
//  OR module
//  Author: Cameron Buchman
//
//  Description: 
//      This module takes in two 16-bit numbers
//      and will return one 16-bit number, either
//      A or B as long as at least one is valid.
//=============================================
module orMod(a, b, or_output);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        output [15:0] or_output;
        reg [15:0] reg_or_output;

    always @(*) begin
        reg_or_output = (a | b);   
    end
    
    assign or_output = reg_or_output;
        
endmodule

//=============================================
//  NOR module
//  Author: Cameron Buchman
//
//  Description: 
//      This module takes in two 16-bit numbers
//      and will return one 16-bit number, as long
//      as neither A or B are valid.
//=============================================
module norMod(a, b,nor_output);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        output [15:0] nor_output;
        reg [15:0] reg_or_output, reg_nor_output;

    always @(*) begin
        reg_nor_output = ~(a | b);
    end
    
    assign nor_output = reg_nor_output;
        
endmodule


