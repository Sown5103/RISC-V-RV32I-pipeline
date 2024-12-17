`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 08:23:45 PM
// Design Name: 
// Module Name: Execute_cycle
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
`include "PC_Adder.v"
`include "ALU.v"
`include "Mux41.v"
module Execute_cycle(clk, rst, RegWriteE, ResultSrcE, LoadE,StoreE, ALUControlE, 
    RD1_E, RD2_E, RD_E, PCPlus4E,InstrE, RegWriteM, ResultSrcM,LoadM,StoreM, RD_M, PCPlus4M, WriteDataM, ALU_ResultM, 
    ResultW,ResultF, ForwardA_E, ForwardB_E,InstrM,ResultE,opb,ForwardASt,ForwardBSt,inabr,inbbr,BranchE,Branch_resultE);

    // Declaration I/Os
    input clk, rst, RegWriteE,LoadE,StoreE;
    input [3:0] ALUControlE;
    input [31:0] RD1_E, RD2_E,opb,inabr,inbbr;
    input [4:0] RD_E;
    input [31:0] PCPlus4E,InstrE;
    input [31:0] ResultW,ResultF;
    input [1:0] ForwardA_E, ForwardB_E,ResultSrcE,ForwardASt,ForwardBSt;
    input BranchE;
    output RegWriteM,LoadM,StoreM,Branch_resultE;
    output [4:0] RD_M; 
    output [31:0] PCPlus4M, WriteDataM, ALU_ResultM,InstrM;
    output [31:0] ResultE;
    output [1:0]ResultSrcM;
    // Declaration of Interim Wires
    wire [31:0] Src_A,Src_B,opbb,Src_A1,Src_A2,temp1,temp2;
    wire [31:0] ResultE;
    reg LoadE_r, StoreE_r;
   
    // Declaration of Register
    reg RegWriteE_r;
    reg [4:0] RD_E_r;
    reg [31:0] PCPlus4E_r, RD2_E_r, ResultE_r,InstrE_r,Br1,Br2;
    reg[1:0]ResultSrcE_r;
    // Declaration of Modules
    // 3 by 1 Mux for Source A
   
    
    Mux41 srca_mux (
                        .a(RD1_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .d(0),
                        .s(ForwardA_E),
                        .e(temp1)
                        );

    // 3 by 1 Mux for Source B
    Mux41 srcb_mux (
                        .a(RD2_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .d(0),
                        .s(ForwardB_E),
                        .e(temp2)
                        );
    assign Src_A1=BranchE?RD1_E:temp1;
    assign Src_B=BranchE?RD2_E:temp2;
    // Writedata 
    Mux41 wd1_mux (
                        .a(RD1_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .d(0),
                        .s(ForwardASt),
                        .e(Src_A2)
                        );
    Mux41 wd2_mux (
                        .a(opb),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .d(0),
                        .s(ForwardBSt),
                        .e(opbb)
                        );         
    //branch
    always @(*)begin
        if (BranchE) begin
            if(ForwardA_E==0) Br1=inabr;
            else if(ForwardA_E==2'b01||ForwardA_E==2'b10) begin
                Br1=temp1;
                
            end
            if(ForwardB_E==0) Br2=inbbr;
            else if(ForwardB_E==2'b01||ForwardB_E==2'b10)begin
                Br2=temp2;
                
            end 
        end
    end
    branch u_branch0(
        .en(BranchE),
        .op_a(Br1),
        .op_b(Br2),
        .fun3(InstrE[14:12]),
        .result(Branch_resultE)
    );
    //for alu inA
    Mux srca (
            .a(Src_A1),
            .b(Src_A2),
            .s(StoreE),
            .c(Src_A)
            );       
    // ALU Unit
    ALU alu (
            .a_i(Src_A),
            .b_i(Src_B),
            .op_i(ALUControlE),
            .res_o(ResultE)
            );

    

    // Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteE_r <= 1'b0; 
            ResultSrcE_r <= 1'b0;
            LoadE_r <=1'b0;
            StoreE_r <=1'b0;
            RD_E_r <= 5'h00;
            PCPlus4E_r <= 32'h00000000; 
            RD2_E_r <= 32'h00000000; 
            ResultE_r <= 32'h00000000;
            InstrE_r <= 32'b0;
        end
        else begin
            RegWriteE_r <= RegWriteE;  
            ResultSrcE_r <= ResultSrcE;
            LoadE_r <= LoadE;
            StoreE_r <= StoreE;
            RD_E_r <= RD_E;
            PCPlus4E_r <= PCPlus4E; 
            RD2_E_r <= opbb; 
            ResultE_r <= ResultE;
            InstrE_r <= InstrE;
        end
    end

    // Output Assignments
    assign RegWriteM = RegWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign LoadM = LoadE_r;
    assign StoreM = StoreE_r;
    assign RD_M = RD_E_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = RD2_E_r;
    assign ALU_ResultM = ResultE_r;
    assign InstrM = InstrE_r;
endmodule