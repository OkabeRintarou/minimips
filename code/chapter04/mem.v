`include "defines.v"

module mem(
    input rst,                           // 复位信号
    
    // MEM阶段从EX/MEM流水线寄存器输入
    input [`RegAddrBus] mem_wd,          // 来自EX/MEM流水线的写数据地址
    input mem_wreg,                      // 来自EX/MEM流水线的写寄存器使能信号
    input [`RegBus] mem_wdata,           // 来自EX/MEM流水线的ALU运算结果
    
    // WB阶段输出到下一阶段
    output reg[`RegAddrBus] wb_wd,       // 要写入的寄存器地址
    output reg wb_wreg,                  // 写寄存器使能信号
    output reg[`RegBus] wb_wdata         // 要写入寄存器的数据
);

    always @(*) begin
        if(rst == `RstEnable) begin
            wb_wd = `NOPRegAddr;
            wb_wdata = `ZeroWord;
            wb_wreg = `WriteDisable;
        end else begin
            wb_wd = mem_wd;
            wb_wdata = mem_wdata;
            wb_wreg = mem_wreg;
        end
    end

endmodule