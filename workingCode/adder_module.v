//=============================================
// adder module
//=============================================
module ripple_carry_adder_subtractor(Sum, Carry, Overflow, A, B, sel);
      

    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
        output [15:0] Sum;   // The 16-bit sum/difference.
        output 	Carry;   // The 1-bit carry/borrow status.
        output 	Overflow;   // The 1-bit overflow status.
        input [15:0] 	A;   // The 16-bit augend/minuend.
        input [15:0] 	B;   // The 16-bit addend/subtrahend.
        input 	sel;  // The operation: 0 => Add, 1=>Subtract.

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
    xor(B0, B[0], sel);
    xor(B1, B[1], sel);
    xor(B2, B[2], sel);
    xor(B3, B[3], sel);
    xor(B4, B[4], sel);
    xor(B5, B[5], sel);
    xor(B6, B[6], sel);
    xor(B7, B[7], sel);
    xor(B8, B[8], sel);
    xor(B9, B[9], sel);
    xor(B10, B[10], sel);
    xor(B11, B[11], sel);  
    xor(B12, B[12], sel);
    xor(B13, B[13], sel);
    xor(B14, B[14], sel);
    xor(B15, B[15], sel);
    xor(Carry, C15, sel);     // Carry = C3 for addition, Carry = not(C3) for subtraction.
    xor(Overflow, C15, C14);     // If the two most significant carry output bits differ, then we have an overflow.

    full_adder fa0(Sum[0], C0, A[0], B0, sel);    // Least significant bit.
    full_adder fa1(Sum[1], C1, A[1], B1, C0);
    full_adder fa2(Sum[2], C2, A[2], B2, C1);
    full_adder fa3(Sum[3], C3, A[3], B3, C2);    
    full_adder fa4(Sum[4], C4, A[4], B4, C3);   
    full_adder fa5(Sum[5], C5, A[5], B5, C4);
    full_adder fa6(Sum[6], C6, A[6], B6, C5);
    full_adder fa7(Sum[7], C7, A[7], B7, C6);    
    full_adder fa8(Sum[8], C8, A[8], B8, C7);    
    full_adder fa9(Sum[9], C9, A[9], B9, C8);
    full_adder fa10(Sum[10], C10, A[10], B10, C9);
    full_adder fa12(Sum[11], C11, A[11], B11, C10);   
    full_adder fa13(Sum[12], C12, A[12], B12, C11);    
    full_adder fa14(Sum[13], C13, A[13], B13, C12);    
    full_adder fa15(Sum[14], C14, A[14], B14, C13);    
    full_adder fa16(Sum[15], C15, A[15], B15, C15);    // Most significant bit.
endmodule // ripple_carry_adder_subtractor

//=============================================
// full_adder
//=============================================
module full_adder(S, Cout, A, B, Cin);
    //---------------------------------------------
    //Inputs/Outputs/regs
    //---------------------------------------------
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
