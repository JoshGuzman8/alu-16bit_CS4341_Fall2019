`define selAND  12'b000000000001
`define selOR  12'b000000000010
`define selNOT 12'b000000000100
`define selXOR 12'b000000001000
`define selNAND 12'b000000010000
`define selNOR 12'b000000100000
`define selCLEAR 12'b100000000000
`define selXNOR 12'b000001000000
`define selADD 12'b000010000000
`define selSUB 12'b000100000000
`define selSHRIGHT 12'b001000000000
`define selSHLEFT 12'b010000000000


module decoder (sel, res);  
  input [3:0] sel;  
  output [11:0] res;  
  reg [11:0] res;  
  always @(sel)  
 
  begin  
    case (sel)  
      4'b0000 : res = selAND;  
      4'b0001 : res = selOR ;  
      4'b0010 : res = selNOT;  
      4'b0011 : res = selXOR ;  
      4'b0100 : res = selNAND;  
      4'b0101 : res = selNOR;  
      4'b0110 : res = selXNOR; 
	  4'b1000 : res = selADD; 
	  4'b1001 : res = selSUB;
	  4'b1010 : res = selSHRIGHT;
	  4'b1011 : res = selSHLEFT;
      4'b0000 : res = selCLEAR;  
    endcase  
  end  
endmodule 
