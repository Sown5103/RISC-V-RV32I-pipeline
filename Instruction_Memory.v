`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 03:28:47 PM
// Design Name: 
// Module Name: Instruction_Memory
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


    module Instruction_Memory(
    A, rst, RD
    );
    input[31:0] A;
    input rst;
    output[31:0] RD;
    
    reg [31:0] Mem [1023:0];
    assign RD=(rst==0)?32'b0:{Mem[A[31:2]]};
    initial begin
        //Mem[0]=32'hFFC4A303;
        //Mem[1]=32'h00832383;
        //Mem[0]=32'h0064A423;
        //Mem[1]=32'h00B62423;    
        //Mem[0]=32'h0062E233;
        //Mem[0]=32'h003100B3;
        //Mem[1]=32'h0062F433;
        
        //Mem[0]=32'h003100B3;
        //Mem[1]=32'h40308233;sub
        //Mem[2]=32'h0040E2B3;or
        //Mem[3]=32'hFFC2A403;lw
        //Mem[4]=32'h002423A3;sw
        /*
        Mem[0]=32'h00500293;
        Mem[1]=32'h00300313;
        Mem[2]=32'h006283B3;
        Mem[3]=32'hFF9FF06F;
        //Mem[3]=32'hFF9FF2EF;
        Mem[4]=32'h00140413;
        //Mem[3]=32'hFF5FF2EF;
        Mem[5]=32'h00940533;*/
        
        //RTYPE x2=5, x3=3
        /*Mem[0] = 32'h003100b3; // add x1, x2, x3
        Mem[1] = 32'h403100b3; // sub x1, x2, x3
        Mem[2] = 32'h003110b3; // sll x1, x2, x3
        Mem[3] = 32'h003120b3; // slt x1, x2, x3
        Mem[4] = 32'h003130b3; // sltu x1, x2, x3
        Mem[5] = 32'h003140b3; // xor x1, x2, x3
        Mem[6] = 32'h003150b3; // srl x1, x2, x3
        Mem[7] = 32'h403150b3; // sra x1, x2, x3
        Mem[8] = 32'h003160b3; // or x1, x2, x3
        Mem[9] = 32'h003170b3; // and x1, x2, x3
        */
        //YTYPE x2=5
        /*
        Mem[0] = 32'h00310093; // addi x1, x2, 3
        Mem[1] = 32'h00312093; // slti x1, x2, 3
        Mem[2] = 32'h00313093; // sltiu x1, x2, 3
        Mem[3] = 32'h00314093; // xori x1, x2, 3
        Mem[4] = 32'h00315093; // srli x1, x2, 3
        Mem[5] = 32'h40315093; // srai x1, x2, 3
        Mem[6] = 32'h00316093; // ori x1, x2, 3
        Mem[7] = 32'h00317093; // andi x1, x2, 3
        */
        //LOAD
        /*
        Mem[0]=32'h00002403;//lw x8, 0(x0)
        Mem[1]=32'h00240413;//addi x8, x8, 2
        Mem[2]=32'h00140313;//addi x6, 8, 1
        */
        //STORELOAD
        /*
        Mem[0]=32'h00702823;//sw x7, 16(x0)
        Mem[1]=32'h01002183;//lw x3, 16(x0)
        Mem[2]=32'h00A18213;//	addi x4, x3, 10*/
        Mem[0]=32'h00500293;
        Mem[1]=32'h00300313;
        Mem[2]=32'h006283B3;
        Mem[3]=32'h00002403;
        //Mem[4]=32'h00100493;
        Mem[4]=32'h00100493;
        Mem[5]=32'h00940533;
        Mem[6]=32'h00940533;
    end
endmodule
