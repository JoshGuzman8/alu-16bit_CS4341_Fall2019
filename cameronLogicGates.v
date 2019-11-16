// This will produce or and nor output
module orMod(a,b,clk,or_output,nor_output)
    input [15:0] a, b;
    input clk;
    output [15:0] or_output;
    output [15:0] nor_output;

    always(@posedg clk)

    assign or_output = (a | b);
    assign nor_output = ~(a | b);
        
endmodule

// This will return the xor and xnor output
module xorMod(a,b,clk,xor_output,xnor_output)
    input [15:0] a, b;
    input clk;
    output [15:0] xor_output, xnor_output;

    always(@posedg clk)

    assign xor_output = ^(a | b);
    assign xnor_output = ^~(a | b);

end module
