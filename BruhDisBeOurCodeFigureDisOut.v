`define RESET 16'b0000000000000000

`define opAND   4'b0000
`define opOR  4'b0001
`define opNOT 4'b0010
`define opXOR  4'b0011
`define opNAND 4'b0100
`define opNOR 4'b0101
`define opXNOR 4'b0110
`define opADD 4'b1000
`define opSUB 4'b1001
`define opSHRIGHT 4'b1010
`define opSHLEFT 4'b1011
`define opCLEAR 4'b1111

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


module DFF(clk,in,out);
  
  input  clk;
  input  [15:0] in;
  output [15:0] out;
  reg    [15:0] out;
  
  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
  out = in;
endmodule



module decoder (sel, res);  
  input [3:0] sel;  
  output [11:0] res;  
  reg [11:0] res;  
  always @(sel)  
 
  begin  
    case (sel)  
      4'b0000 : res = 12'b000000000001;  
      4'b0001 : res = 12'b000000000010 ;  
      4'b0010 : res = 12'b000000000100;  
      4'b0011 : res = 12'b000000001000 ;  
      4'b0100 : res = 12'b000000010000;  
      4'b0101 : res = 12'b000000100000;  
      4'b0110 : res = 12'b000001000000; 
	  4'b1000 : res = 12'b000010000000; 
	  4'b1001 : res = 12'b000100000000;
	  4'b1010 : res = 12'b001000000000;
	  4'b1011 : res = 12'b010000000000;
      4'b0000 : res = 12'b100000000000;  
    endcase  
  end  
endmodule 


module accum (D, Q); 

input  [15:0] D; 
output [15:0] Q; 
reg    [15:0] tmp;  
reg [15:0] reg_Q;

always @(*) begin
tmp = D;  
reg_Q = tmp; 
end 

assign Q = reg_Q;
endmodule 



module mainMux (addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset,sel, res);  
	input[15:0] addsub,shRight,shLeft,andG,orG,xOrG,xNorG,nAndG,nOrG,notG,reset;
  input [11:0] sel;  
  output [15:0] res;  
  reg [15:0] res;  
  always @(sel)  
  begin  
    case (sel)  
      12'b000000000001 : res = andG;  
      12'b000000000010: res = orG;  
      12'b000000000100: res = notG;  
      12'b000000001000: res = xOrG ;  
      12'b000000010000 : res = nAndG;  
      12'b000000100000: res = nOrG;  
      12'b000001000000: res = xNorG; 
      12'b000010000000: res = addsub; 
      12'b000100000000: res = addsub;
      12'b001000000000: res = shRight;
      12'b010000000000: res = shLeft;
      12'b100000000000: res = reset;  
    endcase  
  end  
endmodule 


//Shifter module
module shifter(a, clk, leftShift, rightShift);
    input [15:0] a;
    input clk;
    output [15:0] leftShift;
    output [15:0] rightShift;
    
    reg [15:0] reg_leftShift, reg_rightShift;

    always @(posedge clk) begin

    reg_leftShift = a << 1;
    reg_rightShift = a >> 1;
    
    end
    
    assign leftShift = reg_leftShift;
    assign rightShift = reg_rightShift;

endmodule


// This will produce or and nor output
module orMod(a,b,clk,or_output,nor_output);
    input [15:0] a, b;
    input clk;
    output [15:0] or_output;
    output [15:0] nor_output;
    
    reg [15:0] reg_or_output, reg_nor_output;

    always @(posedge clk) begin

    reg_or_output = (a | b);
    reg_nor_output = ~(a | b);
    
    end
    
    assign or_output = reg_or_output;
    assign nor_output = reg_nor_output;
        
endmodule

// This will return the xor and xnor output
module xorMod(a,b,clk,xor_output,xnor_output);
    input [15:0] a, b;
    input clk;
    output [15:0] xor_output, xnor_output;
    
    reg [15:0] reg_xor_output, reg_xnor_output;

    always @(posedge clk) begin

    reg_xor_output = ^(a | b);
    reg_xnor_output = ^~(a | b);
    
    end
    
    assign xor_output = reg_xor_output;
    assign xnor_output = reg_xnor_output;

endmodule



module not_gate (a,clk, notout);
input [15:0] a, b;
input clk;
  output [15:0] notout;
  
  reg [15:0] reg_notout;
  
always @(posedge clk) begin
reg_notout = ~a ;
end

assign notout = reg_notout;

endmodule

module andnand_gate (a, b, clk, andout, nandout);
input [15:0] a, b;
input clk;
output [15:0] andout, nandout;
reg [15:0] reg_andout, reg_nandout;

always @(posedge clk) begin
reg_andout = a & b;
//nand n1 (nandout,a,b);
reg_nandout = ~(a & b);
end

assign andout = reg_andout;
assign nandout = reg_andout;

endmodule

module ripple_carry_adder_subtractor(Sum, Carry, Overflow, A, B, sel);
	output [15:0] Sum;   // The 16-bit sum/difference.
   output 	Carry;   // The 1-bit carry/borrow status.
   output 	Overflow;   // The 1-bit overflow status.
   input [15:0] 	A;   // The 16-bit augend/minuend.
   input [15:0] 	B;   // The 16-bit addend/subtrahend.
   input 	sel;  // The operation: 0 => Add, 1=>Subtract.
   
   wire 	C0; // The carry out bit of fa0, the carry in bit of fa1.
   wire 	C1; // The carry out bit of fa1, the carry in bit of fa2.
   wire 	C2; // The carry out bit of fa2, the carry in bit of fa3.
   wire 	C3; // The carry out bit of fa3, used to generate final carry/borrrow.
   wire 	C4; // The carry out bit of fa4, used to generate final carry/borrrow.
   wire 	C5; // The carry out bit of fa5, used to generate final carry/borrrow.
   wire 	C6; // The carry out bit of fa6, used to generate final carry/borrrow.
   wire 	C7; // The carry out bit of fa7, used to generate final carry/borrrow.
   wire 	C8; // The carry out bit of fa8, used to generate final carry/borrrow.
   wire 	C9; // The carry out bit of fa9, used to generate final carry/borrrow.
   wire 	C10; // The carry out bit of fa10, used to generate final carry/borrrow.
   wire 	C11; // The carry out bit of fa11, used to generate final carry/borrrow.
   wire 	C12; // The carry out bit of fa12, used to generate final carry/borrrow. 
   wire 	C13; // The carry out bit of fa13, used to generate final carry/borrrow.
   wire 	C14; // The carry out bit of fa14, used to generate final carry/borrrow.
   wire 	C15; // The carry out bit of fa15, used to generate final carry/borrrow.

   wire 	B0; // The xor'd result of B[0] and Op
   wire 	B1; // The xor'd result of B[1] and Op
   wire 	B2; // The xor'd result of B[2] and Op
   wire 	B3; // The xor'd result of B[3] and Op
   wire 	B4; // The xor'd result of B[4] and Op
   wire 	B5; // The xor'd result of B[5] and Op
   wire 	B6; // The xor'd result of B[6] and Op
   wire 	B7; // The xor'd result of B[7] and Op
   wire 	B8; // The xor'd result of B[8] and Op
   wire 	B9; // The xor'd result of B[9] and Op
   wire 	B10; // The xor'd result of B[10] and Op
   wire 	B11; // The xor'd result of B[11] and Op
   wire 	B12; // The xor'd result of B[12] and Op
   wire 	B13; // The xor'd result of B[13] and Op
   wire 	B14; // The xor'd result of B[14] and Op
   wire 	B15; // The xor'd result of B[15] and Op

		

	
   // Looking at the truth table for xor we see that  
   // B xor 0 = B, and
   // B xor 1 = not(B).
   // So, if Op==1 means we are subtracting, then
   // adding A and B xor Op alog with setting the first
   // carry bit to Op, will give us a result of
   // A+B when Op==0, and A+not(B)+1 when Op==1.
   // Note that not(B)+1 is the 2's complement of B, so
   // this gives us subtraction.     
	xor(B0, B[0], sel);
   	xor(B1, B[1], sel);
   	xor(B2, B[2], sel);
   	xor(B3, B[3], sel);
   	xor(B4, B[4], sel);
   	xor(B5, B[5], sel);
   	xor(B6, B[6], sel);
   	xor(B7, B[7], sel);
   	xor(B8, B[8], sel);
   	xor(B9, B[9], sel);
   	xor(B10, B[10], sel);
	xor(B11, B[11], sel);  
	xor(B12, B[12], sel);
	xor(B13, B[13], sel);
	xor(B14, B[14], sel);
	xor(B15, B[15], sel);
	xor(Carry, C15, sel);     // Carry = C3 for addition, Carry = not(C3) for subtraction.
	xor(Overflow, C15, C14);     // If the two most significant carry output bits differ, then we have an overflow.
   
	full_adder fa0(Sum[0], C0, A[0], B0, sel);    // Least significant bit.
   full_adder fa1(Sum[1], C1, A[1], B1, C0);
   full_adder fa2(Sum[2], C2, A[2], B2, C1);
   full_adder fa3(Sum[3], C3, A[3], B3, C2);    
   full_adder fa4(Sum[4], C4, A[4], B4, C3);   
   full_adder fa5(Sum[5], C5, A[5], B5, C4);
   full_adder fa6(Sum[6], C6, A[6], B6, C5);
   full_adder fa7(Sum[7], C7, A[7], B7, C6);    
   full_adder fa8(Sum[8], C8, A[8], B8, C7);    
   full_adder fa9(Sum[9], C9, A[9], B9, C8);
   full_adder fa10(Sum[10], C10, A[10], B10, C9);
   full_adder fa12(Sum[11], C11, A[11], B11, C10);   
   full_adder fa13(Sum[12], C12, A[12], B12, C11);    
   full_adder fa14(Sum[13], C13, A[13], B13, C12);    
   full_adder fa15(Sum[14], C14, A[14], B14, C13);    
   full_adder fa16(Sum[15], C15, A[15], B15, C15);    // Most significant bit.
endmodule // ripple_carry_adder_subtractor


module full_adder(S, Cout, A, B, Cin);
   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);
endmodule // full_adder




module Breadboard(a,b,opcode,clk,select);

//---------------------------------------------
//Parameters
//---------------------------------------------
input [15:0] a , b;
input [3:0] opcode;
input clk;
input [11:0] select;

wire [15:0] dff_a_out;
wire [15:0] dff_b_out;
wire [15:0] andG, nandout;
wire [15:0] or_output, nor_output;
wire [15:0] xor_output,xnor_output;
wire [15:0] notout;
wire [15:0] addsub; 
wire [15:0] shLeft, shRight;
wire [15:0] muxOut;
wire carry;
wire overflow;
wire [15:0] finalOutput;


//---------------------------------------------
//Local Variables
//---------------------------------------------
reg [15:0] state;

//==Create the two Flip-Flops, and plug them into the circuit
decoder regular_decoder(opcode, select);
DFF A(clk, a, dff_a_out) ;
DFF B(clk, b, dff_b_out) ; 
andnand_gate and_nand_1 (a, b, clk, andG, nandout); 
orMod or_mod_1 (a,b,clk,or_output,nor_output);
xorMod xor_mod_1(a,b,clk,xor_output,xnor_output);
not_gate not_gate_1 (a,clk, notout);
ripple_carry_adder_subtractor rpc_adder_sub_1(addsub, carry, overflow, a, b, select[8]);
shifter shifter_1(a, clk, shLeft, shRight);
accum accumulater_1 (muxOut, finalOutput);

//==The MUX with its inputs, the select, and its output
mainMux  mux(addsub,shRight,shLeft,andG,or_output,xor_output,xnor_output,nandout,nor_output,notout,16'b0000000000000000,select,muxOut);

//always @(*) begin

//state={A.dff_a_out,B.dff_b_out};//Set the state equal to the value of the flip flops

//end

endmodule

//=============================================
// Test Bench
//=============================================
module Test_FSM() ;

//---------------------------------------------
//Inputs
//---------------------------------------------
  reg [15:0] a , b;
  reg [3:0] opcode;
  reg clk;
  reg [11:0] select;
  
  
//---------------------------------------------
//Declare FSM
//---------------------------------------------  
  Breadboard ALU(a,b,opcode,clk,select);
  
//---------------------------------------------
//The Display Thread with Clock Control
//---------------------------------------------
   initial
    begin
	  forever
			begin
					#5 
					clk = 0 ;
					#5
					clk = 1 ;
			end
   end	

   

//---------------------------------------------
//The Display Thread with Clock Control
//---------------------------------------------
   initial
    begin
	  #1 ///Offset the Square Wave
      $display("    A           | B              |OPCOD|       OUTPUT   |");
      $display("----------------+----------------+-----+----------------|");
	  forever
			begin
			#5
					$display(" %16b | %16b | %4b ||     %16b|",a,b,opcode,ALU.finalOutput);
			end
   end	

   
   
   
//---------------------------------------------   
// The Input Stimulous.
// Flipping the switch up and down.
//---------------------------------------------   
   
   
  initial 
	begin
	    #2 //Offset the Square Wave
		#10 opcode = 4'b1000; a = 16'b0000000000000001; b = 16'b0000000000000001;
        #10 opcode = 4'b1001; a = 16'b0000000000000010; b = 16'b0000000000000001;
        #10 opcode = 4'b1011; a = 16'b0100000000000010;
        #10 opcode = 4'b1010; a = 16'b0100000000000010;
        #10 opcode = 4'b0010; a = 16'b0000000000000010;
        #10 opcode = 4'b0001; a = 16'b0000000000000010; b = 16'b0000000000000011;
        #10 opcode = 4'b0101; a = 16'b0000000000000010; b = 16'b0000000000000011;
        #10 opcode = 4'b0011; a = 16'b0000000000000010; b = 16'b0000000000000011;
        #10 opcode = 4'b0110; a = 16'b0000000000000010; b = 16'b0000000000000011;
        #10 opcode = 4'b0000; a = 16'b0000000000000010; b = 16'b0000000000000011;
        #10 opcode = 4'b0100; a = 16'b0000000000000010; b = 16'b0000000000000011;

		
		
		$finish;
	end
	
	
endmodule
