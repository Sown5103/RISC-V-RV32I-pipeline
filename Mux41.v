`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2024 11:13:18 PM
// Design Name: 
// Module Name: Mux41
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


module Mux41(
    a,b,c,d,s,e
    );
    input[31:0]a,b,c,d; 
    input[1:0]s;
    output [31:0]e;
    assign e=(s==2'b00)?a:(s==2'b01)?b:(s==2'b10)?c:d;
endmodule