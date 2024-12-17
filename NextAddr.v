`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 10:34:28 PM
// Design Name: 
// Module Name: NextAddr
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


module NextAddr(
    PCnext,ALU_Result,jal,jalr,branch,load,PC_F,sel,predicted_address,flag,PCback
    );
    
    input[31:0] PCnext,ALU_Result,jal,jalr,branch,load,predicted_address,PCback;
    input sel,flag;
    output reg [31:0] PC_F;
    always@(*) begin   
            if(jal|jalr/*|branch*/) PC_F <= ALU_Result;
            if(flag)begin
                if(branch)PC_F<=ALU_Result;
                else PC_F<=PCback;
                
            end
            else if(load) PC_F<=PC_F;
            else if(sel)PC_F<=predicted_address;
            else PC_F<=PCnext;       
    end
    //assign PC_F=(jal|jalr|branch)?ALU_Result:
     //           (load)?PC_F:PCnext;
endmodule
