`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 10:08:57
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(
    input [5:0] command,
    input zero,
    input sign,
    output reg RegDst,//rt rd
    output reg InsMemRW,//read write
    output reg PCWre,//bugai gai
    output reg ExtSel,//0 sign
    output reg DBDataSrc,//alu lw
    output reg WR,//write
    output reg ALUSrcB,
    output reg ALUSrcA,
    output reg [1:0] PCSrc,
    output reg [2:0] ALUOp,
    output reg RegWre,
    output reg RD 
    );
     reg i_add,i_addi,i_sub,i_ori,i_and,i_or,i_sll,i_slt,i_sw,i_lw,i_beq,i_bne,i_bgtz,i_j,i_halt;
    always@(command or zero or sign)
        begin
            if(command==6'b000000)
                begin
                    i_add=1;
                    ALUOp=3'b000;
                end
            else i_add=0;
            if(command==6'b000001)
                begin
                    i_addi=1;
                    ALUOp=3'b000;
                end
            else i_addi=0;
            if(command==6'b000010)
                begin
                    i_sub=1;
                    ALUOp=3'b001;
                end
            else i_sub=0;
            if(command==6'b010000)
                begin
                    i_ori=1;
                    ALUOp=3'b011;
                end
            else i_ori=0;
            if(command==6'b010001)
                begin
                    i_and=1;
                    ALUOp=3'b100;
                end
            else i_and=0;
            if(command==6'b010010)
                begin
                    i_or=1;
                    ALUOp=3'b011;
                end
            else i_or=0;
            if(command==6'b011000)
                begin
                    i_sll=1;
                    ALUOp=3'b010;
                end
            else i_sll=0;
            if(command==6'b011100)
                begin
                    i_slt=1;
                    ALUOp=3'b110;
                end
            else i_slt=0;
            if(command==6'b100110)
                begin
                    i_sw=1;
                    ALUOp=3'b000;
                end
            else i_sw=0;
            if(command==6'b100111)
                begin
                    i_lw=1;
                    ALUOp=3'b000;
                end
            else i_lw=0;
            if(command==6'b110000)
                begin
                    i_beq=1;
                    ALUOp=3'b001;
                end
            else i_beq=0;
            if(command==6'b110001)
                begin
                    i_bne=1;
                    ALUOp=3'b001;
                end
            else i_bne=0;
            if(command==6'b110010)
                begin
                    i_bgtz=1;
                    ALUOp=3'b001;
                end
            else i_bgtz=0;
            if(command==6'b111000)
                begin
                    i_j=1;
                end
            else i_j=0;
            if(command==6'b111111)
                begin
                    i_halt=1;
                end
            else i_halt=0;
        PCWre=!i_halt;
        ALUSrcA=i_sll;
        ALUSrcB=i_ori|i_addi|i_sw|i_lw;
        DBDataSrc=i_lw;
        RegWre=i_add|i_addi|i_sub|i_ori|i_and|i_or|i_sll|i_slt|i_lw;
        RD=!i_lw;
        WR=!i_sw;
        ExtSel=!i_ori;
        RegDst=i_add|i_sub|i_and|i_or|i_sll|i_slt;
        if(i_beq&zero==1|i_bne&zero==0|i_bgtz&zero==0&sign==0)
            begin
                PCSrc=2'b01;
            end
        else if(i_j)
            begin
                PCSrc=2'b10;
            end
        else PCSrc=2'b00;
        end
    initial
        begin
            InsMemRW=1;
        end
endmodule
