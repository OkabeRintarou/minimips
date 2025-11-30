`include "defines.v"

module id_ex(
    input clk,                           // 时钟信号
    input rst,                           // 复位信号
    
    // ID阶段输入
    input [`AluOpBus] id_aluop,          // 来自ID阶段的ALU操作码
    input [`AluSelBus] id_alusel,        // 来自ID阶段的ALU选择信号
    input [`RegBus] id_reg1,             // 来自ID阶段的源操作数1
    input [`RegBus] id_reg2,             // 来自ID阶段的源操作数2
    input [`RegAddrBus] id_wd,           // 来自ID阶段的目的寄存器地址
    input id_wreg,                       // 来自ID阶段的写寄存器使能信号

    // EX阶段输出
    output reg[`AluOpBus] ex_aluop,      // 输出到EX阶段的ALU操作码
    output reg[`AluSelBus] ex_alusel,    // 输出到EX阶段的ALU选择信号
    output reg[`RegBus] ex_reg1,         // 输出到EX阶段的源操作数1
    output reg[`RegBus] ex_reg2,         // 输出到EX阶段的源操作数2
    output reg[`RegAddrBus] ex_wd,       // 输出到EX阶段的目的寄存器地址
    output reg ex_wreg                   // 输出到EX阶段的写寄存器使能信号
);

    always @ (posedge clk) begin 
        if (rst == `RstEnable) begin 
            ex_aluop <= `EXE_NOP_OP; 
            ex_alusel <= `EXE_RES_NOP; 
            ex_reg1 <= `ZeroWord; 
            ex_reg2 <= `ZeroWord; 
            ex_wd <= `NOPRegAddr; 
            ex_wreg <= `WriteDisable; 
        end else begin 
            ex_aluop <= id_aluop; 
            ex_alusel <= id_alusel; 
            ex_reg1 <= id_reg1; 
            ex_reg2 <= id_reg2; 
            ex_wd <= id_wd; 
            ex_wreg <= id_wreg; 
        end 
    end

endmodule