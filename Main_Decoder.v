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


/*module Main_Decoder(
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
endmodule*/
module Main_Decoder(Op,r_type,i_type,load,store,branch,jal,jalr,lui,auipc);

    input wire [6:0]Op;
    //input wire valid;
    //input wire load_signal_controller; 
    
    output reg r_type;
    output reg i_type; 
    output reg load;
    output reg store;
    output reg branch; 
    output reg jal;
    output reg jalr;
    output reg lui;
    output reg auipc;

    always @(*)begin 
        r_type = 1'b0;
        i_type = 1'b0;
        store = 1'b0;
        load = 1'b0;
        branch = 1'b0;
        auipc = 1'b0; 
        jal = 1'b0; 
        jalr = 1'b0; 
        lui = 1'b0; 
        case(Op)
            7'b0110011:begin 
                r_type = 1'b1;
            end 
            7'b0010011:begin 
                i_type = 1'b1;
            end
            7'b0100011:begin 
                store = 1'b1;
            end
            7'b0000011:begin
                //if (valid | load_signal_controller) begin 
                    load = 1'b1;
                //end
                //else begin
                    //load = 1'b1;
                //end
            end
            7'b1100011:begin 
                branch = 1'b1;
            end
            7'b0010111:begin 
                auipc = 1'b1;
            end
            7'b1101111:begin 
                jal = 1'b1;
            end
            7'b1100111:begin 
                jalr = 1'b1;
            end
            7'b0110111:begin 
                lui = 1'b1;
            end

            default:begin 
                r_type = 1'b0;
                i_type = 1'b0;
                store= 1'b0;
                load = 1'b0;
                branch = 1'b0;
                auipc = 1'b0;
                jal = 1'b0; 
                jalr = 1'b0; 
                lui = 1'b0; 
            end
        endcase
    end  
endmodule