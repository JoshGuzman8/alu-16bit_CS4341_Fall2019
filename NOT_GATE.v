module not_gate (a,clk, notout);
input [15:0] a, b;
  output [15:0] outnot;
always @(posedge clk)
assign y = ~a ;
endmodule
