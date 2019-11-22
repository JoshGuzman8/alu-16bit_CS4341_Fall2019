//=============================================
// Team members: Josh Guzman, Albey Kappil,
//		 Bowen Jiang, Cameron Buchman,
//		 Swamy Singaravelu
// Project:	 16-bit ALU
// Date:	 11/17/19
// Language: 	 iVerilog
//
// Description:
//	This project simulates a 16-bit ALU in
//	verilog behaviorally.
//=============================================


// Include files
`include "controlLogicModule.v" 
`include "DFFModule.v"
`include "AND_NAND_modules.v"
`include "OR_NOR_modules.v"
`include "XOR_XNOR_modules.v"
`include "NOT_module.v"
`include "adder_module.v"
`include "shifter_module.v"
`include "multiplexer_module.v"
`include "accum_module.v"


//=============================================
// Breadboard:
// Modules, wires, regs have been instantiated here
//=============================================
module Breadboard(a,b,opcode,clk,select);

  //---------------------------------------------
  //Parameters
  //---------------------------------------------
    input [15:0] a , b;
    input [3:0] opcode;
    input clk;
    output [11:0] select;

    wire [11:0] select;
    wire [15:0] dff_a_out;
    wire [15:0] dff_b_out;
    wire [15:0] and_out, nand_out;
    wire [15:0] or_output, nor_output;
    wire [15:0] xor_output,xnor_output;
    wire [15:0] not_out;
    wire [15:0] addsub_out; 
    wire [15:0] shLeft_out, shRight_out;
    wire [15:0] mux_out;
    wire carry;
    wire overflow;
    wire [15:0] finalOutput;

  //---------------------------------------------
  //Local Variables
  //---------------------------------------------
    reg [15:0] state;
  //---------------------------------------------
  //Instantiate modules
  //---------------------------------------------
    controlLogic cL (opcode, select);
    DFF dff_a (clk, a, dff_a_out);
    DFF dff_b (clk, b, dff_b_out);
    and_gate AND (a, b, clk, and_out);
    nand_gate NAND (a, b, clk, nand_out);
    orMod OR (a, b, clk, or_output);
    norMod NOR (a, b, clk, nor_output);
    xorMod XOR (a, b, clk, xor_output);
    xnorMod XNOR (a, b, clk, xnor_output);
    not_gate NOT (a, clk, not_out);
    ripple_carry_adder_subtractor rpc_adder_sub (addsub_out, carry, overflow, a, b, select[8]);
    shifter shift (a, clk, shLeft_out, shRight_out);
    muxSel mux (addsub_out ,shRight_out, shLeft_out, and_out, or_output, xor_output,
                xnor_output, nand_out, nor_output, not_out, select, mux_out);
    accum accumulater (mux_out, finalOutput, clk);


endmodule //end of Breadboard

//=============================================
// Test Bench
//=============================================
module Testbench() ;

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

  //---------------------------------------------
  //Inputs
  //---------------------------------------------
    reg [15:0] a , b;
    reg [3:0] opcode;
    reg clk;
    wire [11:0] select;
  
  
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
            #1 
            clk = 0 ;
            #1
            clk = 1 ;
        end
    end	

   

  //---------------------------------------------
  //The Display Thread with Clock Control
  //---------------------------------------------
    initial
      begin
      #15 ///Offset the Square Wave
        $display("             A            |             B            |      OPCODE      |          OUTPUT          |");
        $display("--------------------------+--------------------------+------------------+--------------------------|");
      forever
        begin
        #10 $write(" %16b \(%5d\) | %16b \(%5d\) |  %4b  ", a , a,  b, b, opcode);  
                case (opcode)  
                  opAND :  $write(" \(   AND\) ");  
                  opOR :   $write(" \(    OR\) ");  
                  opNOT :  $write(" \(   NOT\) ");  
                  opXOR :  $write(" \(   XOR\) ");  
                  opNAND : $write(" \(  NAND\) ");
                  opNOR :  $write(" \(   NOR\) ");  
                  opXNOR : $write(" \(  XNOR\) "); 
                  opADD :  $write(" \(   Add\) "); 
                  opSUB :  $write(" \(   Sub\) ");
                  opSHRIGHT : $write(" \(ShiftR\) ");
                  opSHLEFT :  $write(" \(ShiftL\) ");
                  opCLEAR : $write(" \( Clear\) ");
                  default : $write(" \( Clear\) ");  
                endcase
        #20 $display("| %16b \(%5d\) |", ALU.finalOutput, ALU.finalOutput);          //Delay output for clock to update output
        end
    end	
   
   
  //---------------------------------------------   
  // The Input Stimulous.
  //---------------------------------------------   
    initial 
    begin
        #12 //Offset the Square Wave
        #10 opcode = opAND;     a = 16'b1100000000000001; b = 16'b1000000000000001;
        #30 opcode = opOR;      a = 16'b0000000000000010; b = 16'b0000000000000001;
        #30 opcode = opNOT;     a = 16'b0100000000000010;
        #30 opcode = opXOR;     a = 16'b0100000000000010; b = 16'b0000000000000011;
        #30 opcode = opNAND;    a = 16'b0000000000000010;
        #30 opcode = opNOR;     a = 16'b0000000000000010; b = 16'b0000000000000011;
        #30 opcode = opXNOR;    a = 16'b0000000000000010; b = 16'b0000000000000011;
        #30 opcode = opADD;     a = 16'b0000000000000010; b = 16'b0000000000000011;
        #30 opcode = opSUB;     a = 16'b0000000000000010; b = 16'b0000000000000011;
        #30 opcode = opSHRIGHT; a = 16'b0000000000001000; b = 16'b0000000000000000;
        #30 opcode = opSHLEFT;  a = 16'b0000000010000000; b = 16'b0000000000000000;
        #30 opcode = opCLEAR;	
        #30
      
      $finish;
    end
	
	
endmodule //end of Testbench
