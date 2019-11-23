//=============================================
// XOR module
//=============================================
// This will return the xor and xnor output
module xorMod(a, b, xor_output);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        output [15:0] xor_output;
        
        reg [15:0] reg_xor_output;

    always @(*) begin
        reg_xor_output = a ^ b;    
    end
    
    assign xor_output = reg_xor_output;

endmodule

//=============================================
// XNOR module
//=============================================
// This will return the xor and xnor output
module xnorMod(a, b, xnor_output);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        output [15:0] xnor_output;
        
        reg [15:0] reg_xnor_output;

    always @(*) begin
        reg_xnor_output = ~(a ^ b);    
    end
    
    assign xnor_output = reg_xnor_output;

endmodule


