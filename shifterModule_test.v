//This file can be run to test the shifterModule

`include "shifterModule.v"

module testbench();
    //Declare data types in testbench
    reg [15:0] a;
    reg sel;
    wire [15:0] outShift;
    wire overflow;       //Flag for overflow

    
    //Instantiate test design (modules being used)
    shifter sh (a, sel, overflow, outShift);

    //Stiumlus (intial block for where the code will begin and end)

    //This block changes values of inputs
    initial
        begin
                a = 16'b0001000010000010; sel = 1'b0;
            #40 a = 16'b0100011001001000; sel = 1'b1;
            #20 a = 16'b1010010011110001; sel = 1'b0;
            #20 a = 16'b0011010010001000; sel = 1'b1;
            #20 a = 16'b1100100001000100; sel = 1'b0;
            #20 a = 16'b1000000000000011; sel = 1'b1;
            #20 a = 16'b0110011011001011; sel = 1'b0;
            #20 a = 16'b0100101010001000; sel = 1'b1;
            #20 a = 16'b0011001010000001; sel = 1'b0;
            #20 a = 16'b0000000000010001; sel = 1'b1;
            $finish;
        end

    //This block displays the information of the states of inputs/outputs
    initial
        begin
            #10 ///Offset the Square Wave
            $display("        a        |sel|overflow?|     output     |");
            $display(" ----------------+---+---------+----------------+");
            forever
			    begin
                    #20
                    $display(" %16b| %1b |        %1b|%16b", a, sel, overflow, outShift);
			    end
        end
endmodule
