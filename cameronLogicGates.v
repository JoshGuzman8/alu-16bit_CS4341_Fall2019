// This will produce or and nor output
module orMod(a,b,or_output,nor_output)
    input [15:0] a, b;
    output [15:0] or_output;
    output [15:0] nor_output;

    always(@posedg clk)

    assign or_output = (a | b);
    assign nor_output = ~(a | b);
        
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
