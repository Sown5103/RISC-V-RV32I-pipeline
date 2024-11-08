`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 05:07:27 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
     clk,rst,load,store,A, WD, RD
    );
    input clk,rst,load,store;
    input [31:0]A,WD;
    output [31:0] RD;

    reg [31:0] mem [1023:0];

    always @ (posedge clk)
    begin
        if(store)
            mem[A[31:2]] <= WD;
        //else if(load)
           // RD = (~rst) ? 32'd0 : mem[A[31:2]];
    end

    assign RD = (~rst) ? 32'd0 : mem[A[31:2]];

    initial begin
        //mem[28] = 32'h00000020;
        //mem[40] = 32'h00000002;
        //mem[7]=32'h000000ab;
        mem[0]=32'h00000000;
    end
endmodule
