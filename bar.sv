module bars (
 input logic clk,
 input logic rst,
 input logic incr,
 input logic decr,
 input logic mvUp,
 input logic mvDown,
 output logic hsync,
 output logic vsync,
 output logic [3:0] red,
 output logic [3:0] green,
 output logic [3:0] blue);
 
 
logic hor [10:0]; 
logic ver [9:0];
 
logic pxlClk;
always_ff @(posedge clk) begin
 if (rst) 
 pxlClk <= 1'b1;
 else
 pxlClk <= ~pxlClk;
end

logic [1:0] det_mvUp;
logic pos_mvUp;
always_ff @(posedge clk) begin
 if (rst) begin
 det_mvUp <= 2’b00;
 end else begin
 det_mvUp[1] <= det_mvUp[0]
 det_mvUp[0] <= mvUp;
 end
end
assign pos_mvUp = det_mvUp[0] & ~det_mvUp[1];

logic [1:0] det_mvDown;
logic pos_mvDown;
always_ff @(posedge clk) begin
 if (rst) begin
 det_mvDown <= 2’b00;
 end else begin
 det_mvDown[1] <= det_mvDown[0]
 det_mvDown[0] <= mvDown;
 end
end
assign pos_mvDown = det_mvDown[0] & ~det_mvDown[1];

logic [1:0] det_incr;
logic pos_incr;
always_ff @(posedge clk) begin
 if (rst) begin
 det_incr <= 2’b00;
 end else begin
 det_incr[1] <= det_incr[0]
 det_incr[0] <= incr;
 end
end
assign pos_incr = det_incr[0] & ~incr[1];

logic [1:0] det_decr;
logic pos_decr;
always_ff @(posedge clk) begin
 if (rst) begin
 det_decr <= 2’b00;
 end else begin
 det_decr[1] <= det_mvUp[0]
 det_decr[0] <= decr;
 end
end
assign pos_decr = det_decr[0] & ~det_decr[1];



always_ff @(posedge clk) begin
 if (rst) begin 
 hsync<=1'b1;
 vsync<=1'b1;
 red<=4'b0000;
 green<=4'b0000;
 blue<=4'b0000;
 hor<=0;
 ver<=0;
 incr<=0;
 decr<=0;
 mvUp<=2'b00;
 mvDown<=2'b00;
 cnt_1<=0;
 cnt_2<=0;
 cnt_3<=0;
 end
 else begin
 
 if (pxlClk) begin
 if(hor==1039) begin
 hor<=0;
end
 if(ver==665) begin
  ver<=0;
  end
  else begin
  ver<=ver+1;
  end
  else begin
  hor<=hor+1;
  end
  
  if(hor>=856 && hor< 976) begin
  hsync<=1'b0;
  end
  else begin
  
  hsync<=1'b1;
  end


  if(ver>=637 && ver<643) begin
  vsync<=1'b0;
  end
  else begin
  vsync<=1'b1;
  end
  
  logic [2:0]en_X;
  always_ff @ ([posedge clk) begin
  if((pos_mvUp==3'b001 || pos_mvDown=3'b001) begin
  en_0<=1'b1;
  end else if(pos_mvUp==3'b010) begin 
  en_1<=1'b1;
  end else if(pos_mvUp==3'b100) begin 
  en_2<=1'b1;
  end
  
  


endmodule