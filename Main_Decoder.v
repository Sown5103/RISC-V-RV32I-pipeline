`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 03:54:28 PM
// Design Name: 
// Module Name: Main_Decoder
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


module Main_Decoder(
    Op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp,Branch
    );
    //input zero;
    input [6:0]Op;
    output reg RegWrite, MemWrite, ResultSrc, ALUSrc,Branch;
    output reg [1:0]  ALUOp,ImmSrc;
    //output PCSrc;
    always @(*)
        case (Op)
            7'b0000011: begin RegWrite<=1; ImmSrc<=2'b00; ALUSrc<=1; MemWrite<=0; ResultSrc<=1; Branch<=0; ALUOp<=2'b00; end//lw
            7'b0100011: begin RegWrite<=0; ImmSrc<=2'b01; ALUSrc<=1; MemWrite<=1; ResultSrc<=0; Branch<=0; ALUOp<=2'b00; end//sw
            7'b0110011: begin RegWrite<=1; ImmSrc<=2'b00; ALUSrc<=0; MemWrite<=0; ResultSrc<=0; Branch<=0; ALUOp<=2'b10; end//R
            7'b1100011: begin RegWrite<=0; ImmSrc<=2'b10; ALUSrc<=0; MemWrite<=0; ResultSrc<=0; Branch<=1; ALUOp<=2'b01; end//beq
            7'b0010011: begin RegWrite<=1; ImmSrc<=2'b00; ALUSrc<=1; MemWrite<=0; ResultSrc<=0; Branch<=0; ALUOp<=2'b00; end//I
            default: begin RegWrite<=0; ImmSrc<=2'b00; ALUSrc<=0; MemWrite<=0; ResultSrc<=0; Branch<=0; ALUOp<=2'b00; end
        endcase
    //assign PCSrc=zero & Branch;
endmodule
