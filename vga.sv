module PanelDisplay (
input logic clk,
input logic rst,
output logic hsync,
output logic vsync,
output logic [3:0] red,
output logic [3:0] green,
output logic [3:0] blue);

reg [9:0] hor=0;
reg[9:0] ver=0;
 
logic pxlClk;
always_ff @(posedge clk) begin
 if (rst)
 pxlClk <= 1’b1;
 else
 pxlClk <= ~pxlClk;
end


always_ff @(posedge clk) begin
 if (rst)
 hsync<=1'b0;
 vsync<=1'b0;
 red<=0;
 green<=0;
 blue<=0;
 
 else
 
 if (pxlClk) begin
 if(hor==799) begin
 hor==0;
 if(ver==599) begin
  ver<=0;
  else
  ver<=ver+1;
  end
  else
  hor<=hor+1;
  
  if(hor>=800 && hor<1040) begin
  red<=0;
  green<=0;
  blue<=0;
  if(hor>=856 && hor< 976) begin
  hsync<=0;
  else 
  
  hsync<=1;
  end
  end
  if(ver>=600 && ver<667) begin
  red<=0;
  green<=0;
  blue<=0;
  if(ver>=637 && ver<643) begin 
  vsync<=0;
  else
  vsync<=1;
  end
  
  
  if((hor>=5) && (hor<95) && (ver>=5) && (ver<95)) begin
  red=1;
  green=0;
  blue=1;
  end
  
  if((hor>=100) && (hor<200) && (ver>=100) && (ver<200)) begin
  red=0;
  green=1;
  blue=1;
  end
  
  if((hor>=300) && (hor<400) && (ver>=300) && (ver<400)) begin
  red=1;
  green=1;
  blue=0;
  end
  
  
 


 end
end


endmodule