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
    rst, RegWriteM, RegWriteW, RD_M, RD_W, RS1_E, RS2_E, ForwardAE, ForwardBE,StoreE,
    RS1_D,RS2_D,ForwardAEDec,ForwardBEDec,ForwardASt,ForwardBSt
    );
    input rst, RegWriteM, RegWriteW,StoreE;
    input[4:0] RD_M, RD_W, RS1_E, RS2_E,RS1_D,RS2_D;
    output reg[1:0] ForwardAE, ForwardBE,ForwardAEDec,ForwardBEDec,ForwardASt,ForwardBSt;
    always @(*) begin
    // Initialize outputs to 0
    ForwardAE = 2'b00;
    ForwardBE = 2'b00;
    ForwardAEDec = 2'b00;
    ForwardBEDec = 2'b00;
    ForwardASt=2'b00;
    ForwardBSt=2'b00;
    // ForwardAE logic
    if (rst == 1'b0) begin
        ForwardAE = 2'b00; ForwardASt=2'b00;
    end else if ((RegWriteM == 1'b1) && (RD_M != 5'h00) && (RD_M == RS1_E) ) begin
        if (StoreE) ForwardASt=2'b10; else ForwardAE = 2'b10;
    end else if ((RegWriteW == 1'b1) && (RD_W != 5'h00) && (RD_W == RS1_E) ) begin
        if (StoreE) ForwardASt=2'b01; else ForwardAE = 2'b01;
    end else begin
        ForwardAE = 2'b00; ForwardASt=2'b00;
    end

    // ForwardBE logic
    if (rst == 1'b0) begin
        ForwardBE = 2'b00; ForwardBSt=2'b00;
    end else if ((RegWriteM == 1'b1) && (RD_M != 5'h00) && (RD_M == RS2_E) ) begin
        if (StoreE) ForwardBSt=2'b10; else ForwardBE = 2'b10;
    end else if ((RegWriteW == 1'b1) && (RD_W != 5'h00) && (RD_W == RS2_E) ) begin
        if (StoreE) ForwardBSt=2'b01; else ForwardBE = 2'b01;
    end else begin
        ForwardBE = 2'b00; ForwardBSt=2'b00;
    end

    // ForwardAEDec logic
    if (rst == 1'b0) begin
        ForwardAEDec = 2'b00;
    end else if ((RegWriteW == 1'b1) && (RD_W != 5'h00) && (RD_W == RS1_D)) begin
        ForwardAEDec = 2'b01;
    end else begin
        ForwardAEDec = 2'b00;
    end

    // ForwardBEDec logic
    if (rst == 1'b0) begin
        ForwardBEDec = 2'b00;
    end else if ((RegWriteW == 1'b1) && (RD_W != 5'h00) && (RD_W == RS2_D)) begin
        ForwardBEDec = 2'b01;
    end else begin
        ForwardBEDec = 2'b00;
    end
  
    end

    


/*
    assign ForwardAE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == RS1_E))&(StoreE==1'b0) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS1_E))&(StoreE==1'b0) ? 2'b01 : 
                        2'b00;
                       
    assign ForwardBE = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_M != 5'h00) & (RD_M == RS2_E))&(StoreE==1'b0) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS2_E))&(StoreE==1'b0) ? 2'b01 : 
                        2'b00;
    assign ForwardAEDec = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS1_D)) ? 2'b01 : 2'b00;
    assign ForwardBEDec = (rst == 1'b0) ? 2'b00 : 
                       ((RegWriteW == 1'b1) & (RD_W != 5'h00) & (RD_W == RS2_D)) ? 2'b01 : 2'b00;  */
                                          
endmodule
