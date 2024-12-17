`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2024 03:37:05 PM
// Design Name: 
// Module Name: Fetch_cycle
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
`include "PC_Adder.v"
`include "Mux.v"
module Fetch_cycle(clk, rst, LoadD,ALU_ResultE,JalE,JalrE,Branch_resultE,JalD,JalrD,Branch_resultD, InstrD, 
PCD, PCPlus4D,predicted_address,sel);
    input clk, rst,sel;
    input JalE,JalrE,Branch_resultE,LoadD;
    input JalD,JalrD,Branch_resultD;
    input[31:0] ALU_ResultE,predicted_address;
    output[31:0] InstrD;
    output[31:0] PCD, PCPlus4D;
    
    wire[31:0]PC_F, PCF, PCPlus4F,InstrF;
    reg[31:0] InstrF_reg,PCF_reg,PCPlus4F_reg;
    reg flush_pipeline,flush_pipeline2;
    
    /*Mux Mux_RegToALU(.a(PCPlus4F),
                     .b(PCTargetE),
                     .s(PCSrcE),
                     .c(PC_F));*/
    NextAddr na(    
                    .PCnext(PCPlus4F),
                    .ALU_Result(ALU_ResultE),
                    .jal(JalE),
                    .jalr(JalrE),
                    .branch(Branch_resultE),
                    .load(LoadD),
                    .PC_F(PC_F)
               );                
    PC PC(
          .PCnext(PC_F),
          .rst(rst),
          .clk(clk),
          .PCi(PCF)
          );
          
    Instruction_Memory Instruction_Memory(.A(PCF),
                                          .rst(rst),
                                          .RD(InstrF));
                                          
    PC_Adder PC_Adder(.a(PCF),
                      .b(32'd4),
                      .c(PCPlus4F));
    
    //FETCH
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end     
    
    always @ (posedge clk  ) begin
    if (JalD | /*Branch_resultD*/ | JalrD) begin
      // If jal, jalr, or branch result is high, flush the pipeline for one cycle
      PCF_reg <= 32'b0;
      InstrF_reg <= 32'bz;
      flush_pipeline <= 1; // Set flag to flush for one cycle
    end 
    else begin
      if (flush_pipeline) begin
        // Stall the pipeline for one additional cycle after flushing
        PCF_reg <= 32'b0;
        InstrF_reg <= 32'bz;
        flush_pipeline <= 0; // Reset flag after one cycle stall
        //flush_pipeline2 <= 1; // Set flag to flush for one cycle
      end
      //else if (flush_pipeline2) begin
        // Stall the pipeline for one additional cycle after flushing
       // PCF_reg <= 32'b0;
        //InstrF_reg <= 32'b0;
        //flush_pipeline2 <= 0; // Reset flag after one cycle stall
      //end
      else if (LoadD) begin
        //stall pipeline
        //PCF_reg <= PCD;
        InstrF_reg <= 32'bz;
      end
      else begin
        // For other instructions, proceed normally
        PCF_reg <= PCF;
        InstrF_reg <= InstrF;
      end
    end
    end
                    
    //output
    assign  InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign  PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign  PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;
endmodule
