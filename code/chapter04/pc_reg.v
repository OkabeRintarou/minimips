`include "defines.v"

module pc_reg(
    input clk,                           // 时钟信号
    input rst,                           // 复位信号
    output reg[`InstAddrBus] pc,         // 程序计数器
    output reg ce                        // 片选信号
);

    always @(posedge clk) begin
        if (rst == `RstEnable) 
            ce <= `ChipDisable;
        else 
            ce <= `ChipEnable;
    end

    always @(posedge clk) begin
        if (ce == `ChipDisable) 
            pc <= 32'h00000000;
        else 
            pc <= pc + 4'h4;
    end
endmodule