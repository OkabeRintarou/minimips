`include "defines.v"

module if_id(
    input clk,                           // 时钟信号
    input rst,                           // 复位信号

    input [`InstAddrBus] if_pc,          // 来自IF阶段的程序计数器
    input [`InstBus] if_inst,            // 来自IF阶段的指令

    output  reg[`InstAddrBus] id_pc,     // 输出到ID阶段的程序计数器
    output reg[`InstBus] id_inst         // 输出到ID阶段的指令
);
    
    always @(posedge clk) begin
        if (rst == `RstEnable) begin
            id_pc <= `ZeroWord;
            id_inst <= `ZeroWord;
        end else begin
            id_pc <= if_pc;
            id_inst <= if_inst;
        end
    end
endmodule