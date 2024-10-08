`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 03:28:47 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    A, rst, RD
    );
    input[31:0] A;
    input rst;
    output[31:0] RD;
    
    reg [31:0] Mem [1023:0];
    assign RD=(rst==0)?32'b0:{Mem[A[31:2]]};
    initial begin
        //Mem[0]=32'hFFC4A303;
        //Mem[1]=32'h00832383;
        //Mem[0]=32'h0064A423;
        //Mem[1]=32'h00B62423;    
        //Mem[0]=32'h0062E233;
        //Mem[0]=32'h003100B3;
        //Mem[1]=32'h0062F433;
        
        //Mem[0]=32'h003100B3;
        //Mem[1]=32'h40308233;sub
        //Mem[2]=32'h0040E2B3;or
        //Mem[3]=32'hFFC2A403;lw
        //Mem[4]=32'h002423A3;sw
        
        Mem[0]=32'h00500293;
        Mem[1]=32'h00300313;
        Mem[2]=32'h006283B3;
        Mem[3]=32'h00002403;
        Mem[4]=32'h00100493;
        Mem[5]=32'h00940533;
    end
endmodule
