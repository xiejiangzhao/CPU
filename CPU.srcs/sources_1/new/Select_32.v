`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 09:06:24
// Design Name: 
// Module Name: 32_Selector
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



module Select_32(
    input Opt,
    input[31:0] DataA,
    input[31:0] DataB,
    output[31:0] DataC
    );
  assign DataC = (Opt == 1'b0 ? DataA : DataB);
endmodule