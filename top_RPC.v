module top_RPC
(
 input logic [2:0] inA,
 input logic [2:0] inB,
 output logic valid,
 output logic tie,
 output logic winA,
 output logic winB
);

//intermediate wires

  logic outA,outB;
  logic inA1,inA2,inA3,inB1,inB2,inB3;
  
 
  assign outA = (~inA[0] & inA[1] & ~inA[2] | ~inA[0] & ~inA[1] &inA[2] | inA[0] & ~(inA[1] & inA[2]));
  assign outB = (inB[0] & ~(inB[1] & inB[2]) | ~inB[0] & inB[1] & ~inB[2] | ~(inB[0] & inB[1]) & inB[2]);
  assign valid = (outA & outB);
  
  assign tie = (valid & ~winA & ~winB);
  
  assign inA1 = (inA[0] & inB[2]);
  assign inA2 = (inA[1] & inB[0]);
  assign inA3 = (inA[2] & inB[1]);
  
  assign winA = (inA1 & inA2 & inA2);
  
  assign inB1 = (inA[0] & inB[1]);
  assign inB2 = (inA[1] & inB[2]);
  assign inB3 = (inA[2] & inB[0]);
  
  assign winB = (inB1 | inB2 | inB3);
  
  
endmodule