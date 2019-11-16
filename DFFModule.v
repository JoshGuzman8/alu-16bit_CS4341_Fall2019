module DFF(clk,in,out);
  
  input  clk;
  input  in;
  output out;
  reg    out;
  
  always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
  out = in;
endmodule
