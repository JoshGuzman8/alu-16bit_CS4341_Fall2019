`include "cameronLogicGates.v"
`include "and_nand.v"
`include "NOT_GATE.v"
`include "adder-subtractor.v"
`include "shifterModule.v"
`include "input_Main_mux.v"
`include "accum.v"
`include "Opcode_Decoder.v"

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


module Breadboard(a,b,opcode,clk,select);

//---------------------------------------------
//Parameters
//---------------------------------------------
input [15:0] a , b;
input [3:0] opcode;
input clk;
input [11:0] select;

wire [15:0] andG, nandout;
wire [15:0] or_output, nor_output;
wire [15:0] xor_output,xnor_output;
wire [15:0] notout;
wire [15:0] addsub; 
wire [15:0] shLeft, shRight;
wire [15:0] muxOut;

//---------------------------------------------
//Local Variables
//---------------------------------------------
reg overflow;
reg [15:0] finalOutput;

//==Create the two Flip-Flops, and plug them into the circuit
decoder regular_decoder(opcode, select);
DFF A(clk, a, dff_a_out) ;
DFF B(clk, b, dff_b_out) ; 
andnand_gate and_nand_1 (a, b, clk, andG, nandout); 
orMod or_mod_1 (a,b,clk,or_output,nor_output);
xorMod xor_mod_1(a,b,clk,xor_output,xnor_output);
not_gate not_gate_1 (a,clk, notout);
ripple_carry_adder_subtractor rpc_adder_sub_1(addsub, 1'b0, overflow, a, b, select[8]);
shifter shifter_1(a, clk, shLeft, shRight);
accum accumulater_1(muxOut, finalOutput);

//==The MUX with its inputs, the select, and its output
mainMux  mux(addsub,shRight,shLeft,andG,or_output,xor_output,xnor_output,nandout,nor_output,notout,RESET,select,muxOut);

state={A.dff_a_out,B.dff_b_out};//Set the state equal to the value of the flip flops

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
      $display("    A     | B  |OPCOD|Current|OUTPUT|NEXTSTATE");
      $display("----------+----+-----+-------+------+---------|");
	  forever
			begin
			#5
					$display(" %16b | %16b | %4b | %b|     %b|",a,b,opcode,ALU.state,ALU.finalOutput,ALU.state);
					oldval=ALU.state;
			end
   end	

   
   
   
//---------------------------------------------   
// The Input Stimulous.
// Flipping the switch up and down.
//---------------------------------------------   
   
   
  initial 
	begin
	    #2 //Offset the Square Wave
		#10 opcode = opADD; a = 16'0000000000000001; b = 16'0000000000000001;
        #10 opcode = opSUB; a = 16'0000000000000010; b = 16'0000000000000001;
        #10 opcode = opSHLEFT; a = 16'0100000000000010;
        #10 opcode = opSHRIGHT; a = 16'0100000000000010;
        #10 opcode = opNOT; a = 16'0000000000000010;
        #10 opcode = opOR; a = 16'0000000000000010; b = 16'0000000000000011;
        #10 opcode = opNOR; a = 16'0000000000000010; b = 16'0000000000000011;
        #10 opcode = opXOR; a = 16'0000000000000010; b = 16'0000000000000011;
        #10 opcode = opXNOR; a = 16'0000000000000010; b = 16'0000000000000011;
        #10 opcode = opAND; a = 16'0000000000000010; b = 16'0000000000000011;
        #10 opcode = opNAND; a = 16'0000000000000010; b = 16'0000000000000011;

		
		
		$finish;
	end
	
	
endmodule
