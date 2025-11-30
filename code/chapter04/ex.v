`include "defines.v"

module ex(
    input rst,
    
    // EX阶段从id_ex流水线寄存器输入
    input [`AluOpBus] ex_aluop,
    input [`AluSelBus] ex_alusel,
    input [`RegBus] ex_reg1,
    input [`RegBus] ex_reg2,
    input [`RegAddrBus] ex_wd,
    input ex_wreg,
    
    // EX阶段输出到下一阶段
    output reg ex_wreg_o,
    output reg[`RegAddrBus] ex_wd_o,
    output reg[`RegBus] ex_wdata_o
);

    // ALU结果
    reg [`RegBus] alu_result;
    
    // ALU运算逻辑
    always @(*) begin
        if (rst == `RstEnable)
            alu_result = `ZeroWord;
        else
            case(ex_aluop)
                `EXE_OR_OP:   alu_result = ex_reg1 | ex_reg2;
                default:      alu_result = `ZeroWord;
            endcase
    end
    
    always @(*) begin
        ex_wd_o = ex_wd;
        ex_wreg_o = ex_wreg;
        case(ex_alusel)
            `EXE_RES_LOGIC: ex_wdata_o = alu_result;
            default:        ex_wdata_o = `ZeroWord;
        endcase
    end
    
endmodule