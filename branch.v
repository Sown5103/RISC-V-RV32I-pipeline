`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2024 02:07:46 PM
// Design Name: 
// Module Name: branch
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


module branch (op_a,op_b,fun3,en,result);

   input [31:0]op_a,op_b;
   input [2:0]fun3;
   input en;

   output reg result;

   always @(*) begin
      if(en==1)begin
         case (fun3)
            3'b000 : result = (op_a == op_b) ? 1 : 0 ;//beq
            3'b001 : result = (op_a != op_b) ? 1 : 0 ;//bne
            3'b100 : result = ($signed (op_a) < $signed (op_b)) ? 1 : 0 ;//blt
            3'b101 : result = ($signed (op_a) >= $signed (op_b)) ? 1 : 0 ;//bge
            3'b110 : result = (op_a < op_b) ? 1 : 0 ;//bltu
            3'b111 : result = (op_a >= op_b) ? 1 : 0 ;//bgeu
            default: result = 0;
         endcase
      end
      else begin
         result = 0;
      end
   end
   
endmodule