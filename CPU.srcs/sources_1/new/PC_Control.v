`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 20:25:26
// Design Name: 
// Module Name: PC_Control
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


module PC_Control(
    input [31:0] PC_now,
    input [25:0] j_addr,
    input [31:0] extend_addr,
    input [1:0] PCSrc,
    output [31:0] PC_next
    );
    wire[31:0] output1,output2;
    wire[31:0] PC4;
    wire[31:0] merge_addr;
    assign PC4 = PC_now+'b100;
    assign output2=PC4+(extend_addr<<2);
    assign merge_addr={PC_now[31:28],j_addr,1'b0,1'b0};
    Select_32 first(.Opt(PCSrc[0]),.DataA(PC4),.DataB(output2),.DataC(output1));
    assign PC_next=(PCSrc[1]==1'b0 ? output1 : merge_addr);
endmodule
