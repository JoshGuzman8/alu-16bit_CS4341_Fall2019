// NOT FINISHED
module or_gate(a, b, out) ;
input [15:0] a ;
input [15:0] b ;
output out ;
wire out ;
assign out =a[0]|a[1]|a[2] ;
endmodule

// FINISHED
module nor_gate (a, b, y);
input [15:0] a, b;
output y;

assign y = ~(a | b);
endmodule

// FINISHED
module xor_gate (a, b, c); 
 input [15:0] a, b; 
 output c; 
 wire c, a_not, b_not; 
   not a_inv (a_not, a); 
   not b_inv (b_not, b); 
   and a1 (x, a_not, b); 
   and a2 (y, b_not, a); 
   or out (c, x, y); 
endmodule 

// FINISHED
module xnor_gate(X,A, B);
   output X;
   input [15:0]  A;
   input [15:0]  B;

   xnor(X,A, B);
endmodule
