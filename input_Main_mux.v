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


module mainMux (addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset,sel, res);  
	input[15:0] addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset;
  input [11:0] sel;  
  output [15:0] res;  
  reg [11:0] res;  
  always @(sel)  
  begin  
    case (sel)  
      selAND : res = andG;  
      selOR: res = orG;  
      selNOT: res = notG;  
      selXOR: res = xOrG ;  
      selNAND : res = nAndG;  
      selNOR: res = nOrG;  
      selNOR: res = xNorG; 
      selADD: res = addsub; 
      selSUB: res = addsub;
      selSHRIGHT: res = shRight;
      selSHRIGHT: res = shLeft;
      selCLEAR : res = reset;  
    endcase  
  end  
endmodule 
