//=============================================
// OR module
//=============================================
module orMod(a, b, clk, or_output);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        input clk;
        output [15:0] or_output;
        reg [15:0] reg_or_output;

    always @(posedge clk) begin
        reg_or_output = (a | b);   
    end
    
    assign or_output = reg_or_output;
        
endmodule

//=============================================
// NOR module
//=============================================
module norMod(a, b, clk, nor_output);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        input clk;
        output [15:0] nor_output;
        reg [15:0] reg_or_output, reg_nor_output;

    always @(posedge clk) begin
        reg_nor_output = ~(a | b);
    end
    
    assign nor_output = reg_nor_output;
        
endmodule


