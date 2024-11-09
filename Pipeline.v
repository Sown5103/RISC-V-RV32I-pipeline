`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 07:53:05 PM
// Design Name: 
// Module Name: Pipeline
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

`include "Fetch_cycle.v"
`include "Decode_cycle.v"
`include "Execute_cycle.v"
`include "Memory_cycle.v"
`include "Writeback_cycle.v"
`include "Hazard_unit.v"
    module Pipeline(
    clk, rst
    );
    
    input clk, rst;
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, Branch_resultE,LoadE, StoreE,JalE,JalrE,LoadD,JalD,JalrD,Branch_resultD, 
    RegWriteM, MemWriteM,LoadM,StoreM,RegWriteF;
    wire [1:0]ResultSrcE,ResultSrcM,ResultSrcW;
    wire [3:0] ALUControlE;
    wire [4:0] RD_E, RD_M, RD_W,RD_F;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E,InstrE, PCPlus4M, WriteDataM, 
    ALU_ResultM,InstrM,ResultF;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW,ALU_ResultE,opbE;
    wire [4:0] RS1_E, RS2_E,RS1_D,R21_D;
    wire [1:0] ForwardBE, ForwardAE,ForwardAEDec,ForwardBEDec;
    
    Fetch_cycle Fetch (
                        .clk(clk), 
                        .rst(rst), 
                        .LoadD(LoadD),
                        .ALU_ResultE(ALU_ResultE),
                        .JalE(JalE),
                        .JalrE(JalrE),
                        .Branch_resultE(Branch_resultE), 
                        .JalD(JalD),
                        .JalrD(JalrD),
                        .Branch_resultD(Branch_resultD),
                        //out
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D)
                    );

    // Decode Stage
    Decode_cycle Decode (//in
                        .clk(clk), 
                        .rst(rst), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D), 
                        .RegWriteW(RegWriteW), 
                        .RDW(RD_W), 
                        .ResultW(ResultW),
                        .ForwardAEDec(ForwardAEDec),
                        .ForwardBEDec(ForwardBEDec),
                         //out
                        .LoadD(LoadD),
                        .JalD(JalD),
                        .JalrD(JalrD),
                        .Branch_resultD(Branch_resultD),
                        .RegWriteE(RegWriteE),
                        .ResultSrcE(ResultSrcE),
                        .Branch_resultE(Branch_resultE),
                        .LoadE(LoadE),
                        .StoreE(StoreE),
                        .JalE(JalE),
                        .JalrE(JalrE), 
                        .ALUControlE(ALUControlE), 
                        .RD1_E(RD1_E), 
                        .RD2_E(RD2_E), 
                        .RD_E(RD_E), 
                        .PCE(PCE), 
                        .PCPlus4E(PCPlus4E),
                        .RS1_E(RS1_E), 
                        .RS2_E(RS2_E),
                        .InstrE(InstrE),
                        .opb(opbE),
                        .RS1_D(RS1_D),
                        .RS2_D(RS2_D)
                    );

    // Execute Stage
    Execute_cycle Execute (
                        //in
                        .clk(clk), 
                        .rst(rst), 
                        .RegWriteE(RegWriteE), 
                        .ResultSrcE(ResultSrcE), 
                        .LoadE(LoadE),
                        .StoreE(StoreE),
                        .ALUControlE(ALUControlE), 
                        .RD1_E(RD1_E), 
                        .RD2_E(RD2_E),  
                        .RD_E(RD_E),  
                        .PCPlus4E(PCPlus4E), 
                        .InstrE(InstrE),
                        .ForwardA_E(ForwardAE),
                        .ForwardB_E(ForwardBE),
                        .ResultW(ResultW),
                        //.ResultF(ResultF),
                        .opb(opbE),
                        //out
                        .ResultE(ALU_ResultE),
                        .RegWriteM(RegWriteM),  
                        .ResultSrcM(ResultSrcM), 
                        .LoadM(LoadM),
                        .StoreM(StoreM),
                        .RD_M(RD_M), 
                        .PCPlus4M(PCPlus4M), 
                        .WriteDataM(WriteDataM), 
                        .ALU_ResultM(ALU_ResultM),
                        .InstrM(InstrM)                   
                    );
    
    // Memory Stage
    Memory_cycle Memory (
                        //in
                        .clk(clk), 
                        .rst(rst), 
                        .RegWriteM(RegWriteM), 
                        .ResultSrcM(ResultSrcM), 
                        .LoadM(LoadM),
                        .StoreM(StoreM),
                        .RD_M(RD_M), 
                        .PCPlus4M(PCPlus4M), 
                        .WriteDataM(WriteDataM), 
                        .ALU_ResultM(ALU_ResultM), 
                        .InstrM(InstrM),
                        //out
                        .RegWriteW(RegWriteW), 
                        .ResultSrcW(ResultSrcW), 
                        .RD_W(RD_W), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW)
                    );

    // Write Back Stage
    Writeback_cycle WriteBack (
                        //in
                        .clk(clk), 
                        .rst(rst), 
                        .ResultSrcW(ResultSrcW), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW),
                        .RD_W(RD_W), 
                        .RegWriteW(RegWriteW),
                        //out
                        .ResultW(ResultW)
                        
                    );
    Hazard_unit Forwarding (
                        .rst(rst), 
                        .StoreE(StoreE),
                        .RegWriteM(RegWriteM), 
                        .RegWriteW(RegWriteW), 
                        //.RegWriteF(RegWriteF),
                        .RD_M(RD_M), 
                        .RD_W(RD_W), 
                        //.RD_F(RD_F),
                        .RS1_E(RS1_E), 
                        .RS2_E(RS2_E), 
                        .RS1_D(RS1_D),
                        .RS2_D(RS2_D),
                        .ForwardAE(ForwardAE), 
                        .ForwardBE(ForwardBE),
                        .ForwardAEDec(ForwardAEDec),
                        .ForwardBEDec(ForwardBEDec)
                        );
endmodule
