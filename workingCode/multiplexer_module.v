/*=============================================
  Multiplexer module
  Author: Albey Kappil
  
  Description:
        A Multiplexer module with 12 channels of
        16-bit input from the output of each of 
        the operation modules of the ALU. this 
        module uses a one-hot input select from 
        the controlLogic to choose between the 
        channels to output a 16bit solution. 
*/=============================================
module muxSel (addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,sel, res);

    //---------------------------------------------
    //Local Parameters
    //---------------------------------------------
        localparam selAND = 12'b000000000001;
        localparam selOR = 12'b000000000010;
        localparam selNOT = 12'b000000000100;
        localparam selXOR = 12'b000000001000;
        localparam selNAND = 12'b000000010000;
        localparam selNOR = 12'b000000100000;
        localparam selXNOR = 12'b000001000000;
        localparam selADD = 12'b000010000000;
        localparam selSUB = 12'b000100000000;
        localparam selSHRIGHT = 12'b001000000000;
        localparam selSHLEFT = 12'b010000000000;
        localparam selCLEAR = 12'b100000000000;

    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------  
      localparam RESET = 16'b0000000000000000;
      input[15:0] addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset;
      input [11:0] sel;  
      output [15:0] res;  
      reg [15:0] res;  

  always @(sel)  
  begin  
    case (sel)  
      selAND : res = andG;  
      selOR: res = orG;  
      selNOT: res = notG;  
      selXOR: res = xOrG ;  
      selNAND : res = nAndG;  
      selNOR: res = nOrG;  
      selXNOR: res = xNorG; 
      selADD: res = addsub; 
      selSUB: res = addsub;
      selSHRIGHT: res = shRight;
      selSHLEFT: res = shLeft;
      selCLEAR: res = RESET;  
      default : res = RESET;
    endcase  
  end  
endmodule 
