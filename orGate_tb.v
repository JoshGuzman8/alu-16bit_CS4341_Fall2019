//This file can be run to test the Logica gates agreed to by Cameron Buchman

`include "cameronLogicGates.v"

module testbench();
    //Declare data types in testbench
    reg [15:0] a;
    reg [15:0] b;
    wire gate_output;       

    
    //Instantiate test design (modules being used)
    or_gate or_g (a, b, gate_output);

    //Stiumlus (intial block for where the code will begin and end)

    //This block changes values of inputs
    initial
        begin
                a = 16'b0001000010000010; b = 16'b0001000010000010;
            #40 a = 16'b0100011001001000; b = 16'b0001000010000010;
            #20 a = 16'b1010010011110001; b = 16'b0001000010000010;
            #20 a = 16'b0011010010001000; b = 16'b0001000010000010;
            #20 a = 16'b1100100001000100; b = 16'b0001000010000010;
            #20 a = 16'b1000000000000011; b = 16'b0001000010000010;
            #20 a = 16'b0110011011001011; b = 16'b0001000010000010;
            #20 a = 16'b0100101010001000; b = 16'b0001000010000010;
            #20 a = 16'b0011001010000001; b = 16'b0001000010000010;
            #20 a = 16'b0000000000010001; b = 16'b0001000010000010;
            $finish;
        end

    //This block displays the information of the states of inputs/outputs
    initial
        begin
            #10 ///Offset the Square Wave
            $display("                  OR GATE                   ");
            $display("        a        |        b       |  output  |");
            $display(" ----------------+----------------+----------+");
            forever
			    begin
                    #20
                    $display(" %16b| %16b |    %1b", a, b, gate_output);
			    end
        end

endmodule
