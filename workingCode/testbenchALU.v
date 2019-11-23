//=============================================
// Include files
//=============================================
`include "controlLogicModule.v" 
`include "multiplexer_module_to_reg.v"
`include "registerModule.v"
`include "AND_NAND_modules.v"
`include "OR_NOR_modules.v"
`include "XOR_XNOR_modules.v"
`include "NOT_module.v"
`include "adder_module.v"
`include "shifter_module.v"
`include "multiplexer_module_out_selector.v"
`include "accum_module.v"
`include "adder2.v"


//=============================================
// Breadboard
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
    wire [15:0] mux_a_out;
    wire [15:0] mux_b_out;
    wire [15:0] reg_a_out;
    wire [15:0] reg_b_out;
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
    controlLogic controlLogic (opcode, select);
    muxInput mux_a (a, select[11], mux_a_out);
    muxInput mux_b (b, select[11], mux_b_out);
    register reg_a (clk, mux_a_out, reg_a_out);
    register reg_b (clk, mux_b_out, reg_b_out);
    and_gate AND (reg_a_out, reg_b_out, and_out);
    nand_gate NAND (reg_a_out, reg_b_out, nand_out);
    orMod OR (reg_a_out, reg_b_out, or_output);
    norMod NOR (reg_a_out, reg_b_out, nor_output);
    xorMod XOR (reg_a_out, reg_b_out, xor_output);
    xnorMod XNOR (reg_a_out, reg_b_out, xnor_output);
    not_gate NOT (reg_a_out, not_out);
    adder_subber add_sub (addsub_out, carry, overflow, reg_a_out, reg_b_out, select[7]);
    shifter Shifter (reg_a_out, shLeft_out, shRight_out);
    muxSel muxSelector (addsub_out ,shRight_out, shLeft_out, and_out, or_output, xor_output,
                xnor_output, nand_out, nor_output, not_out, select, mux_out);
    accum accumulator (mux_out, finalOutput);


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
       #11///Offset the Square Wave
        $display("             A            |             B            |      OPCODE      |          OUTPUT          | Next State |");
        $display("--------------------------+--------------------------+------------------+--------------------------+------------|");
      forever
        begin
          #2 $write(" %16b \(%5d\) | %16b \(%5d\) |  %4b  ", ALU.mux_a_out , ALU.mux_a_out,  ALU.mux_b_out, ALU.mux_b_out, opcode);  
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
        #3 $write("| %16b \(%5d\) ", ALU.finalOutput, ALU.finalOutput);          //Delay output for clock to update output
            if((opcode == opADD || opcode == opSUB) & ALU.overflow)begin
              $display("|    ERROR   |");
            end
            else begin
              $display("|    Ready   |");
              end
        end
    end	
   
   
  //---------------------------------------------   
  // The Input Stimulous.
  //---------------------------------------------   
    initial 
    begin
    //Offset the Square Wave
        #12 opcode = opAND;    a = 16'b0010010100001010; b = 16'b1010010000001110;
        #5 opcode = opCLEAR;
        #5 opcode = opOR;      a = 16'b0010010100001010; b = 16'b1010010000001110;
        #5 opcode = opCLEAR;   
        #5 opcode = opNOR;     a = 16'b0010010100001010; b = 16'b1010010000001110;
        #5 opcode = opCLEAR;
        #5 opcode = opNOT;     a = 16'b0000111100001111; b = 16'bXXXXXXXXXXXXXXXX;
        #5 opcode = opCLEAR;
        #5 opcode = opXOR;     a = 16'b0010010100001010; b = 16'b1010010000001110;
        #5 opcode = opCLEAR;
        #5 opcode = opNAND;    a = 16'b0010010100001010; b = 16'b1010010000001110;
        #5 opcode = opCLEAR;
        #5 opcode = opXNOR;    a = 16'b0010010100001010; b = 16'b1010010000001110;
        #5 opcode = opCLEAR;
        #5 opcode = opSHRIGHT; a = 16'b1100111001100111; b = 16'bXXXXXXXXXXXXXXXX;
        #5 opcode = opCLEAR;
        #5 opcode = opSHLEFT;  a = 16'b1100111001100111; b = 16'bXXXXXXXXXXXXXXXX;
        #5 opcode = opCLEAR;
        #5 opcode = opADD;     a = 16'b0000000000011110; b = 16'b0000000000000111;
        #5 opcode = opCLEAR;
        #5 opcode = opADD;     a = 16'b1011110001000000; b = 16'b1001110001000000;
        #5 opcode = opCLEAR;
        #5 opcode = opSUB;     a = 16'b0000000000000111; b = 16'b0000000000011110;
        #5 opcode = opCLEAR;	
        #5 opcode = opSUB;     a = 16'b0000000000011110; b = 16'b0000000000000111;
        #5 opcode = opCLEAR;	
      
      $finish;
    end
	
	
endmodule //end of Testbench
