`include "defines.v"

module mem_wb(
    input clk,                           // 时钟信号
    input rst,                           // 复位信号
    
    // MEM阶段输入
    input [`RegAddrBus] mem_wd,          // 来自MEM阶段的写数据地址
    input mem_wreg,                      // 来自MEM阶段的写寄存器使能信号
    input [`RegBus] mem_wdata,           // 来自MEM阶段的数据
    
    // WB阶段输出
    output reg[`RegAddrBus] wb_wd,       // 输出到WB阶段的写数据地址
    output reg wb_wreg,                  // 输出到WB阶段的写寄存器使能信号
    output reg[`RegBus] wb_wdata         // 输出到WB阶段的数据
);

    // 流水线寄存器，用于将MEM阶段的结果传递给WB阶段
    always @(posedge clk) begin
        if(rst == `RstEnable) begin
            wb_wdata <= `ZeroWord;
            wb_wd <= `NOPRegAddr;
            wb_wreg <= `WriteDisable;
        end else begin
            wb_wdata <= mem_wdata;
            wb_wd <= mem_wd;
            wb_wreg <= mem_wreg;
        end
    end

endmodule