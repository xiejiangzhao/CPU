`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/17 19:54:42
// Design Name: 
// Module Name: PC
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


module PC(
    input CLK,
    input Reset,
    input PCWre,
    input [31:0] PC_next,
    output reg [31:0] PC_now
    );
    always@(negedge CLK)
        begin
            if(Reset == 0)
                begin
                    PC_now <= 0;
                end
            else
                begin
                    if(PCWre != 0)
                        begin
                              PC_now <= PC_next;
                        end     
                end
        end
    initial
        begin
            PC_now = 0;
        end
endmodule
