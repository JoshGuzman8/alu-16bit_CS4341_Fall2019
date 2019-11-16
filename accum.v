module accum (D, Q); 

input  [15:0] D; 
output [15:0] Q; 
reg    [15:0] tmp;   
tmp = D;  
assign Q = tmp; 
endmodule 
