module andnand_gate (a, b,c, y);
input [15:0] a, b;
input c;
output reg [15:0]y;
always@(c)
if (c == 0)
assign y = a & b;
else
assign y = ~(a & b);

endmodule


