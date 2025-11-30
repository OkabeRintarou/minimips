`include "defines.v"

module id( 
    // MIPS32 ORI指令格式: ori rt, rs, immediate
    // rt: 目标寄存器 (reg2)
    // rs: 源寄存器 (reg1) 
    // immediate: 16位立即数 (零扩展为32位)
    //
    // I型指令格式 (32位):
    // |----------------------------------------------------------|
    // |   opcode   |     rs    |     rt    |     immediate         |
    // |   31-26    |   25-21   |   20-16   |      15-0             |
    // |----------------------------------------------------------|
    // opcode[31:26] - 6位 - 操作码 (ORI = 6'b001101)
    // rs[25:21]     - 5位 - 第一个源寄存器地址 (reg1_addr_o)
    // rt[20:16]     - 5位 - 目标寄存器地址 (reg2_addr_o, wd_o)
    // immediate[15:0]-16位 - 立即数 (ORI指令中零扩展)
    input rst, 
    input[`InstAddrBus] pc_i, 
    input[`InstBus] inst_i, 
    
    input[`RegBus] reg1_data_i, 
    input[`RegBus] reg2_data_i, 

    output reg reg1_read_o, 
    output reg reg2_read_o, 
    output reg[`RegAddrBus] reg1_addr_o, 
    output reg[`RegAddrBus] reg2_addr_o, 
    
    output reg[`AluOpBus] aluop_o, 
    output reg[`AluSelBus] alusel_o, 
    output reg[`RegBus] reg1_o, 
    output reg[`RegBus] reg2_o, 
    output reg[`RegAddrBus] wd_o, 
    output reg wreg_o 
);

    wire[5:0] op = inst_i[31:26];

    reg[`RegBus] imm;
    reg inst_valid;

    // 解码指令
    always @(*) begin
        if (rst == `RstEnable) begin
            aluop_o = `EXE_NOP_OP; 
            alusel_o = `EXE_RES_NOP; 
            wd_o = `NOPRegAddr; 
            wreg_o = `WriteDisable; 
            inst_valid = `InstValid; 
            reg1_read_o = 1'b0; 
            reg2_read_o = 1'b0; 
            reg1_addr_o = `NOPRegAddr; 
            reg2_addr_o = `NOPRegAddr; 
            imm = 32'h0;
        end else begin 
            aluop_o = `EXE_NOP_OP; 
            alusel_o = `EXE_RES_NOP; 
            wd_o = inst_i[15:11]; 
            wreg_o = `WriteDisable; 
            inst_valid = `InstInvalid; 
            reg1_read_o = 1'b0; 
            reg2_read_o = 1'b0; 
            reg1_addr_o = inst_i[25:21];
            reg2_addr_o = inst_i[20:16];
            imm = `ZeroWord;

            case (op) 
                `EXE_ORI: begin
                    wreg_o = `WriteEnable;
                    aluop_o = `EXE_OR_OP; 
                    alusel_o = `EXE_RES_LOGIC; 
                    reg1_read_o = 1'b1; 
                    reg2_read_o = 1'b0; 
                    imm = {16'h0, inst_i[15:0]};
                    wd_o = inst_i[20:16];
                    inst_valid = `InstValid;
                end
                default: begin
                end
            endcase
        end
    end

    always @ (*) begin
        if(rst == `RstEnable)
            reg1_o = `ZeroWord;
        else if(reg1_read_o == 1'b1)
            reg1_o = reg1_data_i;
        else if(reg1_read_o == 1'b0)
            reg1_o = imm;
        else
            reg1_o = `ZeroWord;
    end
    
    always @ (*) begin
        if(rst == `RstEnable)
            reg2_o = `ZeroWord;
        else if(reg2_read_o == 1'b1)
            reg2_o = reg2_data_i;
        else if(reg2_read_o == 1'b0)
            reg2_o = imm;
        else
            reg2_o = `ZeroWord;
    end
endmodule