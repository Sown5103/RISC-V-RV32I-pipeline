`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2024 05:07:27 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
     clk,rst,load,store,A, WD, RD,func3,byteadd
    );
    input clk,rst,load,store;
    input [31:0]A,WD;
    input[2:0]func3;
    input[1:0]byteadd;
    output reg[31:0] RD;

    reg [31:0] mem [1023:0];
    wire [31:0]addr;
    reg [31:0]temp;
    assign addr={2'b0,A[31:2]};
    always @ (posedge clk) 
    begin
        if (store)
        begin
            if(func3==3'b000)begin //sb
               if (byteadd==2'b00) 
                    mem[addr][7:0]<=WD[7:0];
               else if (byteadd==2'b01) 
                    mem[addr][15:8]<=WD[7:0];
               else if (byteadd==2'b10) 
                    mem[addr][23:16]<=WD[7:0];
               else if (byteadd==2'b11) 
                    mem[addr][31:24]<=WD[7:0];
            end
            else  if(func3==3'b001)begin //sh
                if (byteadd==2'b00) 
                    mem[addr][15:0]<=WD[15:0];
                else if (byteadd==2'b01) 
                    mem[addr][23:8]<=WD[15:0];
                else if (byteadd==2'b10) 
                    mem[addr][31:16]<=WD[15:0]; 
            end
            else if(func3==3'b010) begin //sw
                mem[A[31:2]] <= WD;
            end
        end
    end
    always @(*) begin
            if(func3==3'b000)begin //lb
                if (byteadd==2'b00) 
                    RD<={{24{mem[addr][7]}},mem[addr][7:0]};
                else if (byteadd==2'b01) 
                    RD<={{24{mem[addr][15]}},mem[addr][15:8]};
                else if (byteadd==2'b10) 
                    RD<={{24{mem[addr][23]}},mem[addr][23:16]};
                else if (byteadd==2'b11) 
                    RD<={{24{mem[addr][31]}},mem[addr][31:24]};               
            end

            else if(func3==3'b001)begin //lh
                if (byteadd==2'b00) 
                    RD<={{16{mem[addr][15]}},mem[addr][15:0]};
                else if (byteadd==2'b01) 
                    RD<={{16{mem[addr][23]}},mem[addr][23:8]};
                else if (byteadd==2'b10) 
                    RD<={{16{mem[addr][31]}},mem[addr][31:16]};
            end

            else if(func3==3'b010) begin //lw
                RD<=mem[addr];
            end

            else if(func3==3'b100)begin //lbu
                if (byteadd==2'b00) 
                    RD<={24'b0,mem[addr][7:0]};
                else if (byteadd==2'b01) 
                    RD<={24'b0,mem[addr][15:8]};
                else if (byteadd==2'b10) 
                    RD<={24'b0,mem[addr][23:16]};
                else if (byteadd==2'b11) 
                    RD<={24'b0,mem[addr][31:24]};  
            end

            else if(func3==3'b101)begin //lhu
                if (byteadd==2'b00) 
                    RD<={16'b0,mem[addr][15:0]};
                else if (byteadd==2'b01) 
                    RD<={16'b0,mem[addr][23:8]};
                else if (byteadd==2'b10) 
                    RD<={16'b0,mem[addr][31:16]};
            end

            //if(func3==3'b110) begin //lwu
             //  temp<=mem[addr];
           // end
    end
    //assign RD = (~rst) ? 32'd0 : temp;
    
    initial begin
        //mem[28] = 32'h00000020;
        //mem[40] = 32'h00000002;
        //mem[7]=32'h000000ab;
        mem[0]=32'h00000000;
        mem[1]=32'h12345678;
        mem[2]=32'h00000000;
    end
endmodule
