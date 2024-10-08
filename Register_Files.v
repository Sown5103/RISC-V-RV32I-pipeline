`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 04:05:13 PM
// Design Name: 
// Module Name: Register_Files
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


module Register_Files(
    A1, A2, A3, WD3, WE3, clk, rst, RD1, RD2
    );
    input clk, rst, WE3;
    input [4:0] A1, A2, A3;
    input [31:0] WD3;
    output [31:0] RD1, RD2;
    reg [31:0] Reg [31:0];
    assign RD1=(rst==0)?32'b0:Reg[A1];
    assign RD2=(rst==0)?32'b0:Reg[A2];
    
    always @(posedge clk) begin
        if (WE3) Reg[A3]<=WD3;
    end
    initial begin
        //Reg[9]=32'h00000020;
        //Reg[6]=32'h00000040;
        //Reg[5]=32'h00000011;
        //Reg[11]=32'h00000028;
        //Reg[12]=32'h00000030;
        //Reg[2]=32'h00000003;
        //Reg[3]=32'h00000007;
        Reg[0]=32'h00000000;
    end
endmodule
