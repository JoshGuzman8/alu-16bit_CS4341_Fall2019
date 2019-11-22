module adder-subber(Sum, Carry, Overflow, A, B, sel);

         output [15:0] Sum;   // The 16-bit sum/difference.

        output 	Carry;   // The 1-bit carry/borrow status.

        output 	Overflow;   // The 1-bit overflow status.

        input [15:0] 	A;   // The 16-bit augend/minuend.

        input [15:0] 	B;   // The 16-bit addend/subtrahend.

        input 	sel;  // The operation: 0 => Add, 1=>Subtract.
        
        reg [15:0] Sum;
        reg [16:0] o_Sum;
    
    always @ (A or B or sel)
	begin
		if (sel ==1'b0)
			Sum  = A - B;
		else
			Sum  = A + B;
	end
	
	always @ (A or B or sel)
	begin
		if (sel ==1'b0)
			o_Sum  = A - B;
		else
			o_Sum  = A + B;
	end
    
    assign Carry = o_Sum[16];
        
endmodule 
