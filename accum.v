module accum (CLR, D, Q); 
input  CLR; 
input  [15:0] D; 
output [15:0] Q; 
reg    [15:0] tmp;  
 
  always @(posedge CLR) 
    begin 
      if (CLR) 
        tmp = 16'b0000000000000000; 
      else 
        tmp = D; 
    end 
  assign Q = tmp; 
endmodule 
