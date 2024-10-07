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
module Writeback_cycle(clk, rst, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW, ResultW);

// Declaration of IOs
input clk, rst, ResultSrcW;
input [31:0] PCPlus4W, ALU_ResultW, ReadDataW;

output [31:0] ResultW;

// Declaration of Module
Mux result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW)
                );
endmodule
