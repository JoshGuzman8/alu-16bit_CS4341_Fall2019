//=============================================
// OR module
//=============================================
module not_gate (a,clk, notout);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
    input [15:0] a, b;
    input clk;
    output [15:0] notout;
  
    reg [15:0] reg_notout;
  
    always @(posedge clk) begin
        reg_notout = ~a ;
    end

    assign notout = reg_notout;

endmodule


