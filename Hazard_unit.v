`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: FOR BACKUP
// 
// Create Date: 10/08/2024 07:55:07 PM
// Design Name: 
// Module Name: Hazard_unit
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


module Hazard_unit(
    rst, RegWriteM, RegWriteW, RD_M, RD_W, RS1_E, RS2_E, ForwardAE, ForwardBE,StoreE,RS1_D,RS2_D,ForwardAEDec,ForwardBEDec
    );
    input rst, RegWriteM, RegWriteW,StoreE;
    input[4:0] RD_M, RD_W, RS1_E, RS2_E,RS1_D,RS2_D;
    output[1:0] ForwardAE, ForwardBE,ForwardAEDec,ForwardBEDec;
    
    assign ForwardAE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == RS1_E))&(StoreE==1'b0) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS1_E))&(StoreE==1'b0) ? 2'b01 : 
                        2'b00;
                       
    assign ForwardBE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == RS2_E))&(StoreE==1'b0) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS2_E))&(StoreE==1'b0) ? 2'b01 : 
                        2'b00;
    assign ForwardAEDec = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS1_D)) ? 2'b01 : 
                        2'b00;
    assign ForwardBEDec = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS2_D)) ? 2'b01 : 
                        2'b00;                     
endmodule
