`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2021 10:14:46 AM
// Design Name: 
// Module Name: DisGamma
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DisGamma(

input clk            ,
input rstn           ,
output s_axis_video_tready ,
input [31:0] s_axis_video_tdata   ,
input        s_axis_video_tvalid  ,
input        s_axis_video_tuser   ,
input        s_axis_video_tlast   ,
                           
input  m_axis_video_tready ,
output [23:0] m_axis_video_tdata  ,
output m_axis_video_tvalid ,
output m_axis_video_tuser  ,
output m_axis_video_tlast  

    );
    
reg [23:0] Reg_tdata  ;
reg        Reg_tvalid ;
reg        Reg_tuser  ;
reg        Reg_tlast  ;

always @(posedge clk or negedge rstn) 
    if (!rstn) begin 
        Reg_tdata  <= 24'h000000;
        Reg_tvalid <= 1'b0;
        Reg_tuser  <= 1'b0;
        Reg_tlast  <= 1'b0;
            end
     else if (m_axis_video_tready) begin
        Reg_tdata  <= {s_axis_video_tdata[29:22],s_axis_video_tdata[19:12],s_axis_video_tdata[9:2]} ;
        Reg_tvalid <= s_axis_video_tvalid;
        Reg_tuser  <= s_axis_video_tuser ;
        Reg_tlast  <= s_axis_video_tlast ;
            end 
     else begin 
        Reg_tdata  <= 24'h000000;
        Reg_tvalid <= 1'b0;
        Reg_tuser  <= 1'b0;
        Reg_tlast  <= 1'b0;
            end
       
assign m_axis_video_tdata  = Reg_tdata ;
assign m_axis_video_tvalid = Reg_tvalid;
assign m_axis_video_tuser  = Reg_tuser ;
assign m_axis_video_tlast  = Reg_tlast ;
assign s_axis_video_tready = m_axis_video_tready;
    
endmodule
