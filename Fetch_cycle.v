`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2024 03:37:05 PM
// Design Name: 
// Module Name: Fetch_cycle
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

`include "PC.v"
`include "Instruction_Memory.v"
`include "PC_Adder.v"
`include "Mux.v"
module Fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);
    input clk, rst;
    input PCSrcE;
    input[31:0] PCTargetE;
    output[31:0] InstrD;
    output[31:0] PCD, PCPlus4D;
    
    wire[31:0]PC_F, PCF, PCPlus4F,InstrF;
    reg[31:0] InstrF_reg,PCF_reg,PCPlus4F_reg;
    Mux Mux_RegToALU(.a(PCPlus4F),
                     .b(PCTargetE),
                     .s(PCSrcE),
                     .c(PC_F));
                     
    PC PC(.PCi(PCF),
          .PCnext(PC_F),
          .rst(rst),.clk(clk));
          
    Instruction_Memory Instruction_Memory(.A(PCF),
                                          .rst(rst),
                                          .RD(InstrF));
                                          
    PC_Adder PC_Adder(.a(PCF),
                      .b(32'd4),
                      .c(PCPlus4F));
    
    //FETCH
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end                       
    //output
    assign  InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign  PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign  PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;
endmodule
