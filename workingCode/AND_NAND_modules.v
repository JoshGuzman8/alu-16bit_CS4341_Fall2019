//=============================================
// AND module
//=============================================
module and_gate (a, b, clk, andout);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        input clk;
        output [15:0] andout;
        reg [15:0] reg_andout;

    always @(posedge clk) begin
        reg_andout = a & b;

    end

    assign andout = reg_andout;

endmodule

//=============================================
// NAND module
//=============================================
module nand_gate (a, b, clk, nandout);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        input [15:0] a, b;
        input clk;
        output [15:0] nandout;
        reg [15:0] reg_nandout;

    always @(posedge clk) begin
        reg_nandout = ~(a & b);
    end

    assign nandout = reg_nandout;

endmodule