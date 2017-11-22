`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/20 11:39:27
// Design Name: 
// Module Name: CPU
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


module CPU(
    input CLK,
    input work_CLK,
    input[1:0] SW_in,
    input RST,
    output[10:0] display_output
    );
        wire[31:0] PC_now_wire,PC_next_wire;
        wire PCWre_wire;
        wire[1:0] PCSrc_wire;
        wire zero_wire,sign_wire,RegDst_wire,InsMemRW_wire,ExtSel_wire,DBDataSrc_wire,WR_wire,RD_wire,ALUSrcA_wire,ALUSrcB_wire;
        wire [2:0]ALUOp_wire;
        wire RegWre_wire;
        wire[31:0] result_wire,IDataOut_wire;
        wire[4:0] WreReg_result;
        wire[31:0] DataRed1_wire,DataRed2_wire;
        wire[31:0] ALUA_result_wire,ALUB_result_wire;
        wire[31:0] Extend_wire;
        wire[31:0] MEMData_wire;
        wire[31:0] DataWre_result_wire;
        wire[15:0] Display_select;
        wire[15:0] Display_sel1,Display_sel2;
        wire[10:0] display_result;
        wire[6:0] test;
        assign Display_sel1=(SW_in[0]==0)?{PC_now_wire[7:0],PC_next_wire[7:0]}:{3'b0,IDataOut_wire[25:21],DataRed1_wire[7:0]};
        assign Display_sel2={SW_in[0]==0}?{3'b0,IDataOut_wire[20:16],DataRed2_wire[7:0]}:{result_wire[7:0],DataWre_result_wire[7:0]};
        assign Display_select=(SW_in[1]==0)?Display_sel1:Display_sel2;
        assign display_output=display_result;//(SW_in==0)?11'b0011_1001111:11'b1100_0000001;
        PC PC_(.CLK(work_CLK),.Reset(RST),.PCWre(PCWre_wire),.PC_next(PC_next_wire),.PC_now(PC_now_wire));
        PC_Control PC_Control_wire(.PC_now(PC_now_wire),.j_addr(IDataOut_wire[25:0]),.extend_addr(Extend_wire),.PCSrc(PCSrc_wire),.PC_next(PC_next_wire));
        Control_unit Control_unit_(.command(IDataOut_wire[31:26]),.zero(zero_wire),.sign(sign_wire),.RegDst(RegDst_wire),.InsMemRW(InsMemRW_wire),.PCWre(PCWre_wire),.ExtSel(ExtSel_wire),.DBDataSrc(DBDataSrc_wire),.WR(WR_wire),.ALUSrcB(ALUSrcB_wire),.ALUSrcA(ALUSrcA_wire),.PCSrc(PCSrc_wire),.ALUOp(ALUOp_wire),.RegWre(RegWre_wire),.RD(RD_wire));
        ALU ALU_(.ALUOp(ALUOp_wire),.A(ALUA_result_wire),.B(ALUB_result_wire),.sign(sign_wire),.zero(zero_wire),.result(result_wire));
        InsMEM InsMEM_(.IAddr(PC_now_wire),.IDataOut(IDataOut_wire),.RW(InsMemRW_wire));
        Select_5 WreReg_Select(.Opt(RegDst_wire),.DataA(IDataOut_wire[20:16]),.DataB(IDataOut_wire[15:11]),.DataC(WreReg_result));
        RegisterFile RegisterFile_(.CLK(work_CLK),.RST(RST),.RegRed1(IDataOut_wire[25:21]),.RegRed2(IDataOut_wire[20:16]),.RegWre(WreReg_result),.DataWre(DataWre_result_wire),.DataRed1(DataRed1_wire),.DataRed2(DataRed2_wire),.WE(RegWre_wire));
        Select_32 ALUA_Select(.Opt(ALUSrcA_wire),.DataA(DataRed1_wire),.DataB({27'b0,IDataOut_wire[10:6]}),.DataC(ALUA_result_wire));
        Extend Extend_(.ExtSel(ExtSel_wire),.Data(IDataOut_wire[15:0]),.result(Extend_wire));
        Select_32 ALUB_Select(.Opt(ALUSrcB_wire),.DataA(DataRed2_wire),.DataB(Extend_wire),.DataC(ALUB_result_wire));
        DataMEM DataMEM_(.CLK(work_CLK),.DAddr(result_wire),.DataIn(DataRed2_wire),.DataOut(MEMData_wire),.RD(RD_wire),.WR(WR_wire));
        Select_32 WreData_Select(.Opt(DBDataSrc_wire),.DataA(result_wire),.DataB(MEMData_wire),.DataC(DataWre_result_wire));
       // SegLED LED1(.display_data(PC_now_wire[3:0]),.dispcode(test));
        LEDdisplay LEDdisplay_(.CLK(CLK),.RST(RST),.data(Display_select),.display(display_output));
        //display_7seg(CLK,'b0,display_output);
endmodule
