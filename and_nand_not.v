module and_gate (a, b, c, y);
input [15:0] a, b;
input c;
output [15:0] y;

  always @(c or a or b)
 if(c == 0)
assign y = a & b;
  else
assign y = ~(a & b);
endmodule

module not_gate (a, y);
input [15:0] a, b;
output [15:0]y;

assign y = ~a ;
endmodule
