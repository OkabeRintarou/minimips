`include "defines.v"

module regfile (
    input clk,
    input rst,

    // write port
    input we,
    input [`RegAddrBus] waddr,
    input [`RegBus] wdata,

    // read port1
    input re1,
    input [`RegAddrBus] raddr1,
    output reg [`RegBus] rdata1,

    // read port2
    input re2,
    input [`RegAddrBus] raddr2,
    output reg [`RegBus] rdata2
);
    
    reg [`RegBus] regs [0:`RegNum-1];

    always @(posedge clk) begin
        if (rst == `RstDisable) begin
            if ((we == `WriteEnable) && (waddr != `NOPRegAddr)) 
                regs[waddr] <= wdata;
        end
    end

    always @(*) begin
        if (rst == `RstEnable)
            rdata1 = `ZeroWord;
        else if (raddr1 == `NOPRegAddr)
            rdata1 = `ZeroWord;
        else if ((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable))
            rdata1 = wdata;
        else if (re1 == `ReadEnable)
            rdata1 = regs[raddr1];
        else
            rdata1 = `ZeroWord;
    end

    always @(*) begin
        if (rst == `RstEnable)
            rdata2 = `ZeroWord;
        else if (raddr2 == `NOPRegAddr)
            rdata2 = `ZeroWord;
        else if ((raddr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable))
            rdata2 = wdata;
        else if (re2 == `ReadEnable)
            rdata2 = regs[raddr2];
        else
            rdata2 = `ZeroWord;
    end
endmodule