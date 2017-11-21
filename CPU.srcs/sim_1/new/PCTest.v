`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 23:22:22
// Design Name: 
// Module Name: PCTest
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


odule PCTest(
    output reg CLK,
    output reg[3:0] PC
    );
    always #5 CLK=~CLK;
    initial
        begin
            CLK=0;
            PC=0;
        end
    always@(negedge CLK)
        begin
            PC=PC+'b100;
        end
endmodule
