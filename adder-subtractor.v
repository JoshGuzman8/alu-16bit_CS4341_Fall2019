module ripple_carry_adder_subtractor(S, C, V, A, B, Op);
   output [15:0] S;   // The 16-bit sum/difference.
   output 	C;   // The 1-bit carry/borrow status.
   output 	V;   // The 1-bit overflow status.
   input [15:0] 	A;   // The 16-bit augend/minuend.
   input [15:0] 	B;   // The 16-bit addend/subtrahend.
   input 	Op;  // The operation: 0 => Add, 1=>Subtract.
   
   wire 	C0; // The carry out bit of fa0, the carry in bit of fa1.
   wire 	C1; // The carry out bit of fa1, the carry in bit of fa2.
   wire 	C2; // The carry out bit of fa2, the carry in bit of fa3.
   wire 	C3; // The carry out bit of fa3, used to generate final carry/borrrow.
   wire 	C4; // The carry out bit of fa4, used to generate final carry/borrrow.
   wire 	C5; // The carry out bit of fa5, used to generate final carry/borrrow.
   wire 	C6; // The carry out bit of fa6, used to generate final carry/borrrow.
   wire 	C7; // The carry out bit of fa7, used to generate final carry/borrrow.
   wire 	C8; // The carry out bit of fa8, used to generate final carry/borrrow.
   wire 	C9; // The carry out bit of fa9, used to generate final carry/borrrow.
   wire 	C10; // The carry out bit of fa10, used to generate final carry/borrrow.
   wire 	C11; // The carry out bit of fa11, used to generate final carry/borrrow.
   wire 	C12; // The carry out bit of fa12, used to generate final carry/borrrow. 
   wire 	C13; // The carry out bit of fa13, used to generate final carry/borrrow.
   wire 	C14; // The carry out bit of fa14, used to generate final carry/borrrow.
   wire 	C15; // The carry out bit of fa15, used to generate final carry/borrrow.

   wire 	B0; // The xor'd result of B[0] and Op
   wire 	B1; // The xor'd result of B[1] and Op
   wire 	B2; // The xor'd result of B[2] and Op
   wire 	B3; // The xor'd result of B[3] and Op
   wire 	B4; // The xor'd result of B[4] and Op
   wire 	B5; // The xor'd result of B[5] and Op
   wire 	B6; // The xor'd result of B[6] and Op
   wire 	B7; // The xor'd result of B[7] and Op
   wire 	B8; // The xor'd result of B[8] and Op
   wire 	B9; // The xor'd result of B[9] and Op
   wire 	B10; // The xor'd result of B[10] and Op
   wire 	B11; // The xor'd result of B[11] and Op
   wire 	B12; // The xor'd result of B[12] and Op
   wire 	B13; // The xor'd result of B[13] and Op
   wire 	B14; // The xor'd result of B[14] and Op
   wire 	B15; // The xor'd result of B[15] and Op

		

	
   // Looking at the truth table for xor we see that  
   // B xor 0 = B, and
   // B xor 1 = not(B).
   // So, if Op==1 means we are subtracting, then
   // adding A and B xor Op alog with setting the first
   // carry bit to Op, will give us a result of
   // A+B when Op==0, and A+not(B)+1 when Op==1.
   // Note that not(B)+1 is the 2's complement of B, so
   // this gives us subtraction.     
   xor(B0, B[0], Op);
   xor(B1, B[1], Op);
   xor(B2, B[2], Op);
   xor(B3, B[3], Op);
   xor(B4, B[4], Op);
   xor(B5, B[5], Op);
   xor(B6, B[6], Op);
   xor(B7, B[7], Op);
   xor(B8, B[8], Op);
   xor(B0, B[9], Op);
   xor(B1, B[10], Op);
   xor(B2, B[11], Op);
   xor(B3, B[12], Op);
   xor(B0, B[13], Op);
   xor(B1, B[14], Op);
   xor(B2, B[15], Op);
   xor(C, C15, Op);     // Carry = C3 for addition, Carry = not(C3) for subtraction.
   xor(V, C15, C14);     // If the two most significant carry output bits differ, then we have an overflow.
   
   full_adder fa0(S[0], C0, A[0], B0, Op);    // Least significant bit.
   full_adder fa1(S[1], C1, A[1], B1, C0);
   full_adder fa2(S[2], C2, A[2], B2, C1);
   full_adder fa3(S[3], C3, A[3], B3, C2);    
   full_adder fa4(S[4], C4, A[4], B4, C3);   
   full_adder fa5(S[5], C5, A[5], B5, C4);
   full_adder fa6(S[6], C6, A[6], B6, C5);
   full_adder fa7(S[7], C7, A[7], B7, C6);    
   full_adder fa8(S[8], C8, A[8], B8, C7);    
   full_adder fa9(S[9], C9, A[9], B9, C8);
   full_adder fa10(S[10], C10, A[10], B10, C9);
   full_adder fa11(S[11], C11, A[11], B11, C10);   
   full_adder fa11(S[12], C12, A[12], B12, C11);    
   full_adder fa11(S[13], C13, A[13], B13, C12);    
   full_adder fa11(S[14], C14, A[14], B14, C13);    
   full_adder fa11(S[15], C15, A[15], B15, C15);    // Most significant bit.
endmodule // ripple_carry_adder_subtractor


module full_adder(S, Cout, A, B, Cin);
   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);
endmodule // full_adder