//=============================================
// DFF
//=============================================
module register(clk,in,out);
  //---------------------------------------------
  //Inputs/Outputs/regs
  //---------------------------------------------
    input  clk;
    input  [15:0] in;
    output [15:0] out;
    reg    [15:0] out;
  
  always @(clk) begin//<--This is the statement that makes the circuit behave with TIME
  out = in;
  end
endmodule
