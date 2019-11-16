module andnand_gate (a, b, andout, nandout);
input [15:0] a, b;
output  [15:0] andout, nandout;
assign andout = a & b;
assign nandout = ~(a & b);
endmodule


