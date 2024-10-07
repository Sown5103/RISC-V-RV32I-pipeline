`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 03:56:13 PM
// Design Name: 
// Module Name: PC
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


module PC(
    PCi, PCnext, rst, clk
    );
    input[31:0] PCnext;
    input rst,clk;
    output reg[31:0]PCi;
    always @(posedge clk)
    if (rst==0)
    begin
        PCi<=32'b0;
    end 
    else 
    begin
        PCi<=PCnext;
    end
endmodule
