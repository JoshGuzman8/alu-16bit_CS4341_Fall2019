`define opAND  12'b000000000001
`define opOR  12'b000000000010
`define opNOT 12'b000000000100
`define opXOR 12'b000000001000
`define opNAND 12'b000000010000
`define opNOR 12'b000000100000
`define opCLEAR 12'b100000000000
`define opXNOR 12'b000001000000
`define opADD 12'b000010000000
`define opSUB 12'b000100000000
`define opSHRIGHT 12'b001000000000
`define opSHLEFT 12'b010000000000


module mux (sel, res);  
  input [3:0] sel;  
  output [11:0] res;  
  reg [11:0] res;  
  always @(sel)  
 
  begin  
    case (sel)  
      4'b0000 : res = opAND;  
      4'b0001 : res = opOR ;  
      4'b0010 : res = opNOT;  
      4'b0011 : res = opXOR ;  
      4'b0100 : res = opNAND;  
      4'b0101 : res = opNOR;  
      4'b0110 : res = opXNOR; 
	  4'b1000 : res = opADD; 
	  4'b1001 : res = opSUB;
	  4'b1010 : res = opSHRIGHT;
	  4'b1011 : res = opSHLEFT;
      default : res = opCLEAR;  
    endcase  
  end  
endmodule 
