 input clk, rst, up, down, load; 
  input [1:0] loadMax;
  input [n-1:0] maxIn ;
  input [n-1:0] in ;
  output [n-1:0] out ;
  
//---------------------------------------------
// Local Variables
//---------------------------------------------  
  wire [n-1:0] next, outpm1,outDown,outUp ;
  wire [n-1:0] max;
  wire [n-1:0] mux2out;
  wire [1:0] selectMax;
//=============================================
//State Labels
//Make them One-Hot
//=============================================
`define State1  3'b001 //3 Bit, One Hot
`define State2  3'b010 //3 Bit, One Hot
`define State4  3'b100 //3 Bit, One Hot

//=============================================
// Transition Labels
// Name them for easy typing and memory
//=============================================
`define _0 1'b0 //1 Bit
`define _1 1'b1 //1 Bit


//=============================================
// D Flip-Flop
//=============================================
module DFF(clk,in,out);
  
  input  clk;
  input  in;
  output out;
  reg    out;
  
  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
  out = in;
 endmodule

 
 //=============================================
// 4-Channel, 2-Bit Multiplexer
//=============================================

module Mux4(a3, a2, a1, a0, s, b) ;
	parameter k = 3 ;//Three Bits Wide
	input [k-1:0] a3, a2, a1, a0 ;  // inputs
	input [3:0]   s ; // one-hot select
	output[k-1:0] b ;
	assign b = ({k{s[3]}} & a3) | 
               ({k{s[2]}} & a2) | 
               ({k{s[1]}} & a1) |
               ({k{s[0]}} & a0) ;
endmodule


//=============================================
// Light Switch Automata
//=============================================
module Breadboard(clk, rst,x);

//---------------------------------------------
//Parameters
//---------------------------------------------
input clk;
input rst;
input x;

//---------------------------------------------
//Local Variables
//---------------------------------------------
reg  [2:0] state;//The state, 3 Bits, ABC
reg  [3:0] select;//The selection for the multiplexer, Reset, Next State, and 2 don't cares. can be reduced to 2.
wire [2:0] muxout;//The output for the mulitplexer, 3 bits,  ABC
wire [2:0] feedback;//The feedback from the D Flip-Flops, 3 Flip-Flops, 3 Bits, ABC
reg  [2:0] gateout;//The output from the characteristic equations, 3 equations, 3 bits, ABC
 

//LOCAL VARIABLES FOR THE RESULTS OF THE EQUATIONS FROM THE TABLE

reg Anext;//Next state equation for DFF A
reg Bnext;//Next state equation for DFF B
reg Cnext;//Next state equation for DFF C
reg z1;   //Results for output Z1
reg z0;   //results for output z2

//==Create the three Flip-Flops, and plug them into the circuit
//           IN          OUT
DFF A (clk, muxout[2], feedback[2]) ;
DFF B (clk, muxout[1], feedback[1]) ;
DFF C (clk, muxout[0], feedback[0]) ; 

//==The MUX with its inputs, the select, and its output
// Channel 0 is Feedback, The value of the previous state/current state/Stae Equation
// Channel 1 is Reset
// Channel 2 is Don't Care
// Channel 3 is Don't Care
// S has to be  0001 if RST is low
// S has to be  0010 if RST is high

//                  Reset 3 DFFS to 001
//                         |
//                         V
Mux4 iMux(3'b00,3'b00,3'b001,gateout,select,muxout);

//==These statements are are procedural, not parallel==
always @(*) begin

//==Update value on the MUX==
select={1'b0,1'b0,rst,~rst};

//==Results of mux goes to muxout==
//(thread)

//==Feed the results of the mux to the Gates==
//Have to have the results of the State Equations
 
Anext = (B.out&(~x))|(C.out&( x)); // Bx'+Cx
Bnext = (A.out&( x))|(C.out&(~x)); // Ax +Cx'
Cnext = (A.out&(~x))|(B.out&( x)); // Ax'+Bx  

z1 = (~C.out|x);
z0 = ~B.out; //z0=Not B
 

gateout={Anext,Bnext,Cnext};


//==The current state is based on the flip-flops==
//(Thread)
//Find the next state
state={A.out,B.out,C.out};//Set the state equal to the value of the flip flops

end

endmodule

//=============================================
// Test Bench
//=============================================
module Test_FSM() ;

//---------------------------------------------
//Inputs
//---------------------------------------------
  reg clk;
  reg rst;
  reg x;//Input Variable

  wire out;
  
  reg [2:0] oldval;
  reg [2:0] newval;
  
  
//---------------------------------------------
//Declare FSM
//---------------------------------------------  
  Breadboard FSM(clk, rst,x);
  
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
	  $display("        Old   New ZZ");
      $display("CLK|RST|ABC|X|ABC|10");
      $display("---+---+---+-+---+--");
	  forever
			begin
			#5
			$display(" %1b | %1b |%1b%1b%1b|%1b|%1b%1b%1b|%1b%1b",clk,rst,FSM.A.out,FSM.B.out,FSM.C.out,x,FSM.Anext,FSM.Bnext,FSM.Cnext,FSM.z1,FSM.z0);
			end
   end	

   
   
   
//---------------------------------------------   
// The Input Stimulous.
// Flipping the switch up and down.
//---------------------------------------------   
   
   
  initial 
	begin
	    #2 //Offset the Square Wave
		#10 rst = 0 ; x=1'b0;
		#10 $display ("Reset");
		
		//Go forwards
		#10 rst = 1 ; x=1'b0;
		#10 rst = 0 ; x=1'b0;
		#10 rst = 0 ; x=1'b0;
		#10 rst = 0 ; x=1'b0;
		
		#10 $display ("Reset");
		//go backwards
		#10 rst = 1 ; x=1'b1;
		#10 rst = 0 ; x=1'b1;
		#10 rst = 0 ; x=1'b1;
		#10 rst = 0 ; x=1'b1;
		
		$finish;
	end
	
	
endmodule

 
