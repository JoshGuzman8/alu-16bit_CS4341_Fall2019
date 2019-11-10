//Shifter module
//Inputs:
//  a:    16 bit binary number
//  sel:  the selector bit decides whether we are shifting left or right, 0 is left and 1 is right
//Outputs:
//  overflow: Flag for overflow, 1 if overflow occured during shift
//  outShift: 16 bit output of the shifted a number
//Circuit diagram used: (need to upload this still)

module shifter(a, sel, overflow, outShift);
    input [15:0] a;         //16 bit input
    input sel;              //sel is the selector and can be 0 or 1 for shift left and right respective
    output overflow;        //Overflow flag
    output [15:0] outShift; //16 bit output

    //Naming convention of wires is as follows:
    //  w<a[n]><u or d>
    //  w is wire
    //  a[n] refers to the position of the bit in a that is being shifted
    //  u is up shift, d is down shift
    //  ex: "w4d" means this wire will handle shifting bit a[4] to the right
    wire w15d, w14u, w14d, w13u, w13d, w12u, w12d, w11u, w11d, w10u, w10d,
         w9u, w9d, w8u, w8d, w7u, w7d, w6u, w6d, w5u, w5d, w4u, w4d, w3u,
         w2u, w2d, w1u, w1d, w0u;
    wire notSel;  //This wire holds the NOT of the select bit

    //Gates
    not n0  (notSel, sel);
    //And gates
    and a15u (overflow, a[15], notSel);
    and a15d (w15d,  a[15],  sel);
    and a14u (outShift[15], a[14], notSel);
    and a14d (w14d,  a[14],  sel);
    and a13u (w13u,  a[13],  notSel);
    and a13d (w13d,  a[13],  sel);
    and a12u (w12u,  a[12],  notSel);
    and a12d (w12d,  a[12],  sel);
    and a11u (w11u,  a[11],  notSel);
    and a11d (w11d,  a[11],  sel);
    and a10u (w10u,  a[10],  notSel);
    and a10d (w10d,  a[10],  sel);
    and a9u  (w9u,   a[9],   notSel);
    and a9d  (w9d,   a[9],   sel);
    and a8u  (w8u,   a[8],   notSel);
    and a8d  (w8d,   a[8],   sel);
    and a7u  (w7u,   a[7],   notSel);
    and a7d  (w7d,   a[7],   sel);
    and a6u  (w6u,   a[6],   notSel);
    and a6d  (w6d,   a[6],   sel);
    and a5u  (w5u,   a[5],   notSel);
    and a5d  (w5d,   a[5],   sel);
    and a4u  (w4u,   a[4],   notSel);
    and a4d  (w4d,   a[4],   sel);
    and a3u  (w3u,   a[3],   notSel);
    and a3d  (w3d,   a[3],   sel);
    and a2u  (w2u,   a[2],   notSel);
    and a2d  (w2d,   a[2],   sel);
    and a1u  (w1u,   a[1],   notSel);
    and a1d  (outShift[0], a[1],   sel);
    and a0u  (w0u,   a[0],   notSel);
    //Or gates
    or  or14 (outShift[14], w15d, w13u);
    or  or13 (outShift[13], w14d, w12u);
    or  or12 (outShift[12], w13d, w11u);
    or  or11 (outShift[11], w12d, w10u);
    or  or10 (outShift[10], w11d, w9u);
    or  or9  (outShift[9],  w10d, w8u);
    or  or8  (outShift[8],  w9d,  w7u);
    or  or7  (outShift[7],  w8d,  w6u);
    or  or6  (outShift[6],  w7d,  w5u);
    or  or5  (outShift[5],  w6d,  w4u);
    or  or4  (outShift[4],  w5d,  w3u);
    or  or3  (outShift[3],  w4d,  w2u);
    or  or2  (outShift[2],  w3d,  w1u);
    or  or1  (outShift[1],  w2d,  w0u);

endmodule
