`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 14:01:14
// Design Name: 
// Module Name: InsMEM
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


module InsMEM(
    input [31:0] IAddr,
    output reg [31:0] IDataOut,
    input RW
    );
    reg [7:0] memory [99:0];
    initial
        begin
            $readmemb ("E:/CPU/rom_data.txt", memory);
            IDataOut=0;
        end
    always@(IAddr or RW )
        begin
            if(RW)
                begin
                    IDataOut[31:24] = memory[IAddr];
                    IDataOut[23:16] = memory[IAddr+1];
                    IDataOut[15:8] = memory[IAddr+2];
                    IDataOut[7:0] = memory[IAddr+3];
                end
        end
endmodule
