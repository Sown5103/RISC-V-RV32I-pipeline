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
        Mem[9] = 32'h003170b3; // and x1, x2, x3*/
        
        //YTYPE x2=5
        /*
        Mem[0] = 32'h00310093; // addi x1, x2, 3
        Mem[1] = 32'h00312093; // slti x1, x2, 3
        Mem[2] = 32'h00313093; // sltiu x1, x2, 3
        Mem[3] = 32'h00314093; // xori x1, x2, 3
        Mem[4] = 32'h00315093; // srli x1, x2, 3
        Mem[5] = 32'h40315093; // srai x1, x2, 3
        Mem[6] = 32'h00316093; // ori x1, x2, 3
        Mem[7] = 32'h00317093; // andi x1, x2, 3*/
        
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
        
        //JAL
        /*
        Mem[0]=32'h00100193;
        Mem[1]=32'h00418313;
        Mem[2]=32'h00518233;
        Mem[3]=32'hFF9FF2EF;
        Mem[4]=32'h00100113;
        */
        //jalr
        /*
        Mem[0]=32'h00C00167;	//jal x2 12(x0)	jal x2,12
        Mem[1]=32'h00008093;	//addi x1 x1 0	addi x1,x1,0
        Mem[2]=32'h00008093;	//addi x1 x1 0	addi x1,x1,0
        Mem[3]=32'h00018193;//
        */
        //lui
        //Mem[0]=32'h000050b7;//lui x1, 5
        //auipc
        //Mem[0]=32'h00008093;	//addi x1 x1 0	addi x1,x1,0
        //Mem[1]=32'h00005097; //auipc x1,5
        /*
        Mem[0]=32'h00500293;
        Mem[1]=32'h00300313;
        Mem[2]=32'h006283B3;
        Mem[3]=32'h00002403;
        //Mem[4]=32'h00100493;
        Mem[4]=32'h00100493;
        Mem[5]=32'h00940533;
        Mem[6]=32'h00940533;*/
        //sim
       // Mem[0]  = 32'h00538123; //    lb x2, 0(x9)     # R-type: x3 = x1 + x2
        //Mem[1]  = 32'h00209463; // bne x1, x2, 8
        //Mem[2]  = 32'h002081B3; // 0x8   add x3, x1, x2
        //Mem[3]  = 32'h00508213; // addi x4,x1,5
        
        //Mem[0]  = 32'h00500093; // 0x0   addi x1, x0, 5     # I-type: x1 = x0 + 5   5
        //Mem[1]  = 32'h00A00113; // 0x4   addi x2, x0, 10    # I-type: x2 = x0 + 10  10
        //Mem[2]  = 32'h002081B3; // 0x8   add x3, x1, x2     # R-type: x3 = x1 + x2  15
        //Mem[3]  = 32'h40110233//sub x4, x2, x1
        //Mem[3]  = 32'h40208233; // 0xC   sub x4, x1, x2     # R-type: x4 = x2 - x1  -5
        //Mem[4]  = 32'h404082b3; //          sub x5, x1, x4
        //Mem[3]  = 32'h00112023; // 0x10  sw x1, 0(x2)       # S-type: store x1 to memory address 0
        //Mem[5]  = 32'h00002283; // 0x14  lw x5, 0(x0)       # I-type: load from memory address 0 to x5
        //Mem[6]  = 32'hFFD28313; // 0x18  addi x6, x5, -3    # I-type: x6 = x5 - 3
        //Mem[7]  = 32'h001373B3; // 0x1C  and x7, x6, x1     # R-type: x7 = x6 & x1
        //Mem[8]  = 32'h00236433; // 0x20  or x8, x6, x2      # R-type: x8 = x6 | x2
        //Mem[9]  = 32'h008004EF; // 0x24  jal x9, label      # Jump to label
        //Mem[10] = 32'h00838533; // 0x28  add x10, x7, x8
        //Mem[11] = 32'h00148493; // 0x2c  addi x9, x9, 1     # I-type: x9 = x0 + 1
        
        //beq
        Mem[0]  = 32'h00A00093; // 0x0   addi x1, x0, a     # I-type: x1 = x0 + 5   5
        Mem[2]  = 32'h00100193; //x3+=1
        Mem[1]  = 32'h00A00113; // 0x4   addi x2, x0, 10    # I-type: x2 = x0 + 10  10
        Mem[3]  = 32'h00208863; // 0x8   beq x1, x2, mem6     
        Mem[4]  = 32'h00008093;//x1=x1+0
        Mem[5]  = 32'h00008093; //     
        Mem[6]  = 32'h00008093; //     
        Mem[7]  = 32'h00500193; // x3=x0+5       # I-type: load from memory address 0 to x5
        Mem[8]  = 32'h00008093;//x1=x1+0
        Mem[9]  = 32'h00008093; //     
        Mem[10]  = 32'h00008093; // 
        //Mem[6]  = 32'hFFD28313; // 0x18  addi x6, x5, -3    # I-type: x6 = x5 - 3
        //Mem[7]  = 32'h001373B3; // 0x1C  and x7, x6, x1     # R-type: x7 = x6 & x1
    end
endmodule
