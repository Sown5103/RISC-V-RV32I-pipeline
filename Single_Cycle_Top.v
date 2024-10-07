`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 08:16:37 PM
// Design Name: 
// Module Name: Single_Cycle_Top
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
`include "Register_Files.v"
`include "Data_Memory.v"
`include "Sign_Extend.v"
`include "Control_Unit.v"
`include "PC_Adder.v"
`include "ALU.v"
`include "Mux.v"
module Single_Cycle_Top(
    clk, rst 
    );
    input clk, rst;
    wire RegWrite,MemWrite,ALUSrc,ResultSrc;
    wire[31:0] PC_Top,RD_Ins,Imm_Ext_Top,RD1_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,ResultDMem;
    wire[2:0] ALUControl_Top;
    wire[1:0] ImmSrc;
    PC PC(.PCi(PC_Top),
          .PCnext(PCPlus4),
          .rst(rst),.clk(clk));
    
    PC_Adder PC_Adder(.a(PC_Top),
                      .b(32'd4),
                      .c(PCPlus4));
                      
    Instruction_Memory Instruction_Memory(.A(PC_Top),
                                          .rst(rst),
                                          .RD(RD_Ins));
                                          
    Register_Files Register_Files(.A1(RD_Ins[19:15]),
                                  .A2(RD_Ins[24:20]),
                                  .A3(RD_Ins[11:7]),
                                  .WD3(ResultDMem),
                                  .WE3(RegWrite),
                                  .clk(clk),
                                  .rst(rst),
                                  .RD1(RD1_Top),
                                  .RD2(RD2_Top));
                                  
    Sign_Extend Sign_Extend(.In(RD_Ins),
                            .Imm_Ext(Imm_Ext_Top),
                            .ImmSrc(ImmSrc));
                            
    Mux Mux_RegToALU(.a(RD2_Top),
                     .b(Imm_Ext_Top),
                     .s(ALUSrc),
                     .c(SrcB));
   
    ALU ALU(.A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .OverFlow(),
            .Carry(),
            .Zero(),
            .Negative());
                  
    Control_Unit Control_Unit(.Op(RD_Ins[6:0]),
                              .RegWrite(RegWrite),
                              .ImmSrc(ImmSrc),
                              .ALUSrc(ALUSrc),
                              .MemWrite(MemWrite),
                              .ResultSrc(ResultSrc),
                              .Branch(),
                              .funct3(RD_Ins[14:12]),
                              .funct7(RD_Ins[31:25]),
                              .ALUControl(ALUControl_Top));
                              
    Data_Memory Data_Memory(.A(ALUResult),
                            .WD(RD2_Top),
                            .clk(clk),
                            .WE(MemWrite),
                            .RD(ReadData),
                            .rst(rst));
    Mux Mux_DMemToRF(.a(ALUResult),
                     .b(ReadData),
                     .s(ResultSrc),
                     .c(ResultDMem));
endmodule
