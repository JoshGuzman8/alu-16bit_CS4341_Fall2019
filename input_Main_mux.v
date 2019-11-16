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


module mux (addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset,sel, res);  
	input[15:0] addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset;
  input [11:0] sel;  
  output [11:0] res;  
  reg [11:0] res;  
  always @(sel)  
  begin  
    case (sel)  
      opAND : res = andG;  
      opOR: res = orG;  
      opNOT: res = notG;  
      opXOR: res = xOrG ;  
      opNAND : res = nAndG;  
      opNOR: res = nOrG;  
      opNOR: res = xNorG; 
	  opADD: res = addsub; 
	  opSUB: res = addsub;
	  opSHRIGHT: res = shRight;
	  opSHRIGHT: res = shLeft;
      default : res = reset;  
    endcase  
  end  
endmodule 
