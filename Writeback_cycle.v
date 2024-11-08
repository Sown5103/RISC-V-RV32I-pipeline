`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2024 08:54:03 PM
// Design Name: 
// Module Name: Writeback_cycle
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
`include "Mux.v"
module Writeback_cycle(clk, rst, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW,RD_W,RegWriteW, ResultF,ResultW,RD_F,RegWriteF);

// Declaration of IOs
    input clk, rst,RegWriteW;
    input [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    input [4:0]RD_W;
    input [1:0]ResultSrcW;
    output [4:0]RD_F;
    output[31:0]ResultF;
    output RegWriteF;
    output wire [31:0] ResultW;
    reg [4:0]RD_W_r;
    reg [31:0]ResultW_r;
    reg RegWriteW_r;



// Declaration of Module
    Mux41 result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
                .c(PCPlus4W),
                .d(32'b0),
                .s(ResultSrcW),
                .e(ResultW)
                );
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RD_W_r<=5'b0;
            ResultW_r<=32'b0;
            RegWriteW_r<=1'b0;
        end
        else begin
            RD_W_r<=RD_W;
            ResultW_r<=ResultW;
            RegWriteW_r<=RegWriteW;
        end
    end

    // Output Assignments
    assign RD_F = RD_W_r;
    assign ResultF = ResultW_r;
    assign RegWriteF=RegWriteW_r;
endmodule
