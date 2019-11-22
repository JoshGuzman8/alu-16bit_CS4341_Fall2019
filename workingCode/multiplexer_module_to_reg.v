//=============================================
// Multiplexer module
//=============================================
module muxInput (in, sel, out);

    //---------------------------------------------
    //Local Parameters
    //---------------------------------------------
    parameter selINPUT = 0;
    parameter selCLEAR = 1;

    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------  
      input[15:0] in;
      input sel;  
      output [15:0] out;  
      reg [15:0] out;  
      localparam RESET = 16'b0000000000000000;

  always @(sel)  
  begin  
    case (sel)  
      selINPUT : out = in;  
      selCLEAR: out = RESET;  
      default : out = RESET;
    endcase  
  end  
endmodule 
