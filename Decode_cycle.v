`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 08:27:35 PM
// Design Name: 
// Module Name: Decode_cycle
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




module Decode_cycle(clk, rst, InstrD, PCD, PCPlus4D, RegWriteW, RDW, ResultW, RegWriteE,ResultSrcE,
    Branch_resultE,LoadE,StoreE,JalE,JalrE, ALUControlE, RD1_E, RD2_E, RD_E, PCE, PCPlus4E, RS1_E, RS2_E,
    InstrE,LoadD,Branch_resultD,JalD,JalrD,opb,RS1_D,RS2_D,ForwardAEDec,ForwardBEDec);

    // Declaring I/O
    input clk, rst, RegWriteW;
    input [4:0] RDW;
    input [31:0] InstrD, PCD, PCPlus4D, ResultW;
    input [1:0]ForwardAEDec,ForwardBEDec;
    output RegWriteE,Branch_resultE,LoadE,StoreE,JalE,JalrE;
    output [1:0]ResultSrcE;
    output [3:0] ALUControlE;
    output [31:0] RD1_E, RD2_E;
    output [4:0] RS1_E, RS2_E, RD_E;
    output [31:0] PCE, PCPlus4E,InstrE,opb;
    output wire LoadD,Branch_resultD,JalD,JalrD;
    // Declare Interim Wires
    wire RegWriteD,Branch_resultD,StoreD,JalD,JalrD,BranchD,operand_a,operand_b;
    wire [1:0]ResultSrcD;
    wire [3:0] ALUControlD;
    wire [31:0] RD1_D, RD2_D, InstrD,op_a,op_b,oppa,oppb,i_immo , s_immo , sb_immo , uj_immo , u_immo,imm_mux_out;
    wire [2:0]imm_sel;
    
    // Declaration of Interim Register
    reg RegWriteD_r,Branch_resultD_r,LoadD_r,StoreD_r,JalD_r,JalrD_r;
    reg [3:0] ALUControlD_r;
    reg [31:0] RD1_D_r, RD2_D_r;
    reg [4:0] RD_D_r, RS1_D_r, RS2_D_r;
    reg [31:0] PCD_r, PCPlus4D_r,InstrD_r,op_b_r; 
    reg [1:0]ResultSrcD_r;

    output wire [31:0] RS1_D,RS2_D;
    assign RS1_D=InstrD[19:15];
    assign RS2_D=InstrD[24:20];
    // Initiate the modules
    // Control Unit
    Control_Unit control (
                        .opcode(InstrD[6:0]),
                        .fun3(InstrD[14:12]),
                        .fun7(InstrD[30]),
                        .reg_write(RegWriteD),
                        .imm_sel(imm_sel),
                        .operand_b(operand_b),
                        .operand_a(operand_a),
                        .mem_to_reg(ResultSrcD),
                        .Load(LoadD),
                        .Jalr(JalrD),
                        .Store(StoreD),
                        .Branch(BranchD),
                        .Jal(JalD),
                        .alu_control(ALUControlD)
                        );

    // Register File
    Register_Files rf (
                        .clk(clk),
                        .rst(rst),
                        .WE3(RegWriteW),
                        .WD3(ResultW),
                        .A1(InstrD[19:15]),
                        .A2(InstrD[24:20]),
                        .A3(RDW),
                        .RD1(op_a),
                        .RD2(op_b)
                        );
    Mux u_muxx1 
    (
        .a(op_a),
        .b(ResultW),
        .s(ForwardAEDec),
        .c(oppa)
    );
    Mux u_muxx2 
    (
        .a(op_b),
        .b(ResultW),
        .s(ForwardBEDec),
        .c(oppb)
    );
    immediategen u_imm_gen0 (
        .instr(InstrD),
        .i_imme(i_immo),
        .sb_imme(sb_immo),
        .s_imme(s_immo),
        .uj_imme(uj_immo),
        .u_imme(u_immo)
    );
    mux3_8 u_mux0(
        .a(i_immo),
        .b(s_immo),
        .c(sb_immo),
        .d(uj_immo),
        .e(u_immo),
        .sel(imm_sel),
        .out(imm_mux_out)
    );
    // Sign Extension
    //SELECTION OF PROGRAM COUNTER OR OPERAND A
    Mux u_mux1 
    (
        .a(oppa),
        .b(PCD),
        .s(operand_a),
        .c(RD1_D)
    );
    
    //SELECTION OF OPERAND B OR IMMEDIATE     
    Mux u_mux2(
        .a(oppb),
        .b(imm_mux_out),
        .s(operand_b),
        .c(RD2_D)
    );

    //BRANCH
    branch u_branch0(
        .en(BranchD),
        .op_a(op_a),
        .op_b(op_b),
        .fun3(InstrD[14:12]),
        .result(Branch_resultD)
    );
    
    // Declaring Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrD_r <= 32'b0;
            RegWriteD_r <= 1'b0;
            //ALUSrcD_r <= 1'b0;
            //MemWriteD_r <= 1'b0;
            ResultSrcD_r <= 1'b0;
            Branch_resultD_r <= 1'b0;
            ALUControlD_r <= 4'b0000;
            RD1_D_r <= 32'h00000000; 
            RD2_D_r <= 32'h00000000; 
            //Imm_Ext_D_r <= 32'h00000000;
            RD_D_r <= 5'h00;
            PCD_r <= 32'h00000000; 
            PCPlus4D_r <= 32'h00000000;
            RS1_D_r <= 5'h00;
            RS2_D_r <= 5'h00;
            LoadD_r <= 1'b0;
            StoreD_r <= 1'b0;
            JalD_r <= 1'b0;
            JalrD_r <= 1'b0;
            op_b_r<=32'b0;
        end
        else begin
            InstrD_r <= InstrD;
            RegWriteD_r <= RegWriteD;
            //ALUSrcD_r <= ALUSrcD;
            //MemWriteD_r <= MemWriteD;
            ResultSrcD_r <= ResultSrcD;
            Branch_resultD_r <= Branch_resultD;
            ALUControlD_r <= ALUControlD;
            RD1_D_r <= RD1_D; 
            RD2_D_r <= RD2_D; 
            //Imm_Ext_D_r <= Imm_Ext_D;
            RD_D_r <= InstrD[11:7];
            PCD_r <= PCD; 
            PCPlus4D_r <= PCPlus4D;
            RS1_D_r <= RS1_D;
            RS2_D_r <= RS2_D;
            LoadD_r <= LoadD;
            StoreD_r <= StoreD;
            JalD_r <= JalD;
            JalrD_r <= JalrD;
            op_b_r<=oppb;
        end
    end

    // Output asssign statements
    assign InstrE = InstrD_r;
    assign RegWriteE = RegWriteD_r;
    //assign ALUSrcE = A    LUSrcD_r;
    //assign MemWriteE = MemWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign Branch_resultE = Branch_resultD_r;
    assign ALUControlE = ALUControlD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    //assign Imm_Ext_E = Imm_Ext_D_r;
    assign RD_E = RD_D_r;
    assign PCE = PCD_r;
    assign PCPlus4E = PCPlus4D_r;
    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r;
    assign LoadE = LoadD_r;
    assign StoreE = StoreD_r;
    assign JalE = JalD_r;
    assign JalrE = JalrD_r;
    assign opb=op_b_r;
endmodule