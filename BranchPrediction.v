`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 08:43:22 PM
// Design Name: 
// Module Name: BranchPrediction
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


module BranchPrediction(
    input actual_outcome, // output of and gate whose inputs are branch control and zero flag
    input [31:0] inst,
    input [31:0] pc_address,
    input branch, // branch control signal
    //input flag, // output of xor of actual outcome and predicted outcome
    input clk,rst,
    output reg predicted_outcome,
    output reg [31:0] predicted_address,
    output reg [31:0] PCback,
    output reg sel,
    output reg flag
);
    integer i = 0;
    reg [1:0] temp;
    reg [1:0] bht [15:0]; // 4 bit branch history table
    reg [3:0] address; // to store 4 bit address
    reg [31:0] predicted_offset; // pc = pc + 4 or pc = pc + x
    reg [1:0] prev_branch = 2'b00;
    
   
    always@(*) begin
        if (inst[6:0] == 7'b1100011) begin
            address = {prev_branch, pc_address[3:2]};
            if (bht[address] == 2'b10 || bht[address] == 2'b11) predicted_outcome=1'b1; else predicted_outcome=1'b0;
            predicted_offset = predicted_outcome?({{20{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8]}<<1):32'd4;
            predicted_address = predicted_offset + pc_address;
            sel = 1'b1;
            PCback=pc_address+32'd4;
        end
        else begin
            //predicted_outcome = 1'b0;
            sel = 1'b0;
        end
    end
    always@(posedge clk) 
        if(rst==1'b0) begin
            for (i=0; i<16; i=i+1) // prediction set to not taken
            bht[i] = 2'b11;
            flag=0; 
            PCback=0;
        end
        else if (branch == 1'b1)begin
            prev_branch = {actual_outcome, prev_branch[1]};
            
        end
    always@(*) begin
        if (branch == 1'b1) begin // saturation counter fsm
            flag=actual_outcome^predicted_outcome;
            if (flag)
            case(bht[address])
                2'b00: if (actual_outcome==1'b1) bht[address] = 2'b01;
                2'b01: if (actual_outcome==1'b1) bht[address] = 2'b10;
                2'b10: if (actual_outcome==1'b0) bht[address] = 2'b01;
                2'b11: if (actual_outcome==1'b0) bht[address] = 2'b10;
            endcase
            else if(flag==1'b0)
            case(bht[address])
                2'b00: if (actual_outcome==1'b0) bht[address] = 2'b00;
                2'b01: if (actual_outcome==1'b0) bht[address] = 2'b00;
                2'b10: if (actual_outcome==1'b1) bht[address] = 2'b11;
                2'b11: if (actual_outcome==1'b1) bht[address] = 2'b11;
            endcase
        end
        else flag=0;
    end
endmodule
