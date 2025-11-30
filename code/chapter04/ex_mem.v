`include "defines.v"

module ex_mem(
    input clk,                           // 时钟信号
    input rst,                           // 复位信号
    
    // EX阶段输入
    input [`RegAddrBus] ex_wd,           // 来自EX阶段的写数据地址
    input ex_wreg,                       // 来自EX阶段的写寄存器使能信号
    input [`RegBus] ex_wdata,            // 来自EX阶段的ALU运算结果
    
    // MEM阶段输出
    output reg[`RegAddrBus] mem_wd,      // 锁存的写数据地址到MEM阶段
    output reg mem_wreg,                 // 锁存的写寄存器使能信号到MEM阶段
    output reg[`RegBus] mem_wdata        // 锁存的ALU运算结果到MEM阶段
);

    // 流水线寄存器，用于将EX阶段的结果传递给MEM阶段
    always @(posedge clk) begin
        if(rst == `RstEnable) begin
            mem_wdata <= `ZeroWord;
            mem_wd <= `NOPRegAddr;
            mem_wreg <= `WriteDisable;
        end else begin
            mem_wdata <= ex_wdata;
            mem_wd <= ex_wd;
            mem_wreg <= ex_wreg;
        end
    end

endmodule