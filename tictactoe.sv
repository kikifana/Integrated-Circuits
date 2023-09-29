module tictactoe (
input logic clk,
//input logic [4:0]sw,

input logic [0:8] x,
input logic [0:8] o,
output logic error,
output logic full,
output logic winX,
output logic winO,
output logic noWin);
//output logic[8:0]x,
//output logic[8:0]o);


/*
integer address;
assign address=sw[3:0];


always_comb
begin 

if (sw[4]==1) x[address] = 1;
else o[address] = 1;

end
*/

assign error = |(x & o);
assign full = &(x | o);
assign winX = ~error * (&(x[0:2]) | &(x[3:5]) | &(x[6:8]) | x[0]*x[3]*x[6] |  x[1]*x[4]*x[7] | x[2]*x[5]*x[8] | x[0]*x[4]*x[8] | x[2]*x[4]*x[6]);
assign winO = ~error * (&(o[0:2]) | &(o[3:5]) | &(o[6:8]) | o[0]*o[3]*o[6] |  o[1]*o[4]*o[7] | o[2]*o[5]*o[8] | o[0]*o[4]*o[8] | o[2]*o[4]*o[6]);
assign noWin = ~error * ~(winX | winO);



endmodule
