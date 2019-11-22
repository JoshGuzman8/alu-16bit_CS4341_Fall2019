/*===============================================
  controlLogic Module 
  Author: Albey Kappil
  
  Description: 
  	This module that take an input of 4-bit 
	opcode representing the operation taking
  	place and outputs a one-hot number 
	representing the inputed opcode.
=================================================
*/
module controlLogic (opCode, sel);  

  //---------------------------------------------
  //Local Parameters
  //---------------------------------------------
    localparam opAND = 4'b0000;
    localparam opOR = 4'b0001;
    localparam opNOT = 4'b0010;
    localparam opXOR = 4'b0011;
    localparam opNAND = 4'b0100;
    localparam opNOR = 4'b0101;
    localparam opXNOR = 4'b0110;
    localparam opADD = 4'b1000;
    localparam opSUB = 4'b1001;
    localparam opSHRIGHT = 4'b1010;
    localparam opSHLEFT = 4'b1011;
    localparam opCLEAR = 4'b1111;

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
    input [3:0] opCode; 
    output [11:0] sel;  
    reg [11:0] reg_sel; 

  always @(opCode)  
 
  begin  
    case (opCode)  
      opAND : reg_sel = selAND;  
      opOR : reg_sel = selOR;  
      opNOT : reg_sel = selNOT;  
      opXOR : reg_sel = selXOR ;  
      opNAND : reg_sel = selNAND;  
      opNOR : reg_sel = selNOR;  
      opXNOR : reg_sel = selXNOR; 
	    opADD : reg_sel = selADD; 
	    opSUB : reg_sel = selSUB;
	    opSHRIGHT : reg_sel = selSHRIGHT;
	    opSHLEFT : reg_sel = selSHLEFT;
      opCLEAR : reg_sel = selCLEAR;
      default : reg_sel = selCLEAR;  
    endcase  
  end  

  assign sel = reg_sel;
endmodule 
