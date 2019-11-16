module andnand_gate (a, b, clk, andout, nandout);
input [15:0] a, b;
output  [15:0] andout, nandout;
always @(posedge clk)
assign andout = a & b;
assign nandout = ~(a & b);
endmodule


