`include "defines.v"

module inst_rom(
    input ce,
    input[`InstAddrBus] addr,
    output reg[`InstBus] inst
);

    reg[`InstBus] inst_mem[0:`InstMemNum-1];

    initial $readmemh ("ASM/inst_rom.data", inst_mem);

    // 当复位信号无效时，依据输入的地址，给出指令存储器ROM中对应的元素
    always @(*) begin
        if (ce == `ChipDisable)
            inst = `ZeroWord;
        else
            inst = inst_mem[addr[`InstMemNumLog2:2]];
    end

endmodule