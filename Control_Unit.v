`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 03:37:22 PM
// Design Name: 
// Module Name: Control_Unit
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


`include "ALU_Decoder.v"
`include "Main_Decoder.v"
/*
module Control_Unit(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

    input [6:0]Op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc;
    output [2:0]ALUControl;

    wire [1:0]ALUOp;

    Main_Decoder Main_Decoder(
                .Op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule*/
module Control_Unit (
    input wire [6:0] opcode,
    input wire [2:0] fun3,
    input wire fun7,
    //input wire valid,
    //input wire load_control,

    output wire reg_write,
    output wire [2:0]imm_sel,
    output wire operand_b,
    output wire operand_a,
    output wire [1:0] mem_to_reg,
    output wire Load,
    output wire Jalr,
    output wire Store,
    output wire Branch,
    output wire Jal,
    output wire [3:0] alu_control
);

    wire r_type;
    wire i_type;
    wire load;
    wire store;
    wire branch;
    wire jal;
    wire jalr;
    wire lui;
    wire auipc;

    Main_Decoder maindec (
        .Op(opcode),
        .r_type(r_type),
        .i_type(i_type),
        .load(load),
        .branch(branch),
        .store(store),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc)
    );

    ALU_Decoder aludec (
        .fun3(fun3),
        .fun7(fun7),
        .i_type(i_type),
        .r_type(r_type),
        .load(load),
        .store(store),
        .branch(branch),
        .jal(jal),
        .jalr(jalr),
        .lui(lui),
        .auipc(auipc), 
        
        .jal_out(Jal),
        .branch_out(Branch),
        .load_out(Load),
        .store_out(Store),
        .jalr_out(Jalr),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .operand_b(operand_b),
        .operand_a(operand_a),
        .imm_sel(imm_sel),
        .alu_control(alu_control)
    );

endmodule
