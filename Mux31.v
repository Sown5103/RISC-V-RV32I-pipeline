`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 08:22:37 PM
// Design Name: 
// Module Name: Mux31
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


module Mux31(
    a,b,c,s,d
    );
    input[31:0]a,b,c; 
    input[1:0]s;
    output [31:0]d;
    assign d=(s==2'b00)?a:(s==2'b01)?b:(s==2'b10)?c:32'b0;
endmodule
