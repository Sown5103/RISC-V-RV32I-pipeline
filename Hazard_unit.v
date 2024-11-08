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
    rst, RegWriteM, RegWriteW,RegWriteF, RD_M, RD_W,RD_F, Rs1_E, Rs2_E, ForwardAE, ForwardBE
    );
    input rst, RegWriteM, RegWriteW, RegWriteF;
    input[4:0] RD_M, RD_W,RD_F, Rs1_E, Rs2_E;
    output[1:0] ForwardAE, ForwardBE;
    
    assign ForwardAE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs1_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs1_E)) ? 2'b01 : 
                       ((RegWriteF == 1'b1) & (RD_F != 5'h00) & (RD_F == Rs1_E)) ? 2'b11 : 2'b00;
                       
    assign ForwardBE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == Rs2_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == Rs2_E)) ? 2'b01 : 
                       ((RegWriteF == 1'b1) & (RD_F != 5'h00) & (RD_F == Rs2_E)) ? 2'b11 : 2'b00;
endmodule
