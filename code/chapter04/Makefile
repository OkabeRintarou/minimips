# Makefile for chapter04 simulation

# 顶层模块名
TOP_MODULE = openmips_min_sopc

# 测试平台文件
TB_FILE = $(TOP_MODULE)_tb.v

# 所有源文件
SRC_FILES = defines.v pc_reg.v regfile.v \
            if_id.v id.v id_ex.v ex.v ex_mem.v mem.v mem_wb.v \
            openmips.v openmips_min_sopc.v inst_rom.v

# ASM目录相关文件
ASM_HEX = ASM/inst_rom.data

# 生成目标
.PHONY: all sim wave gtkwave clean help asm

# 默认目标
all: help

# 编译和运行仿真
sim: asm $(TOP_MODULE)
	vvp $(TOP_MODULE)

# 生成波形文件
wave: asm $(TOP_MODULE)_wave
	vvp $(TOP_MODULE)_wave

# 编译ASM目录下的hex文件
asm:
	cd ASM && make

# 编译主目标
$(TOP_MODULE): $(TB_FILE) $(SRC_FILES)
	iverilog -o $@ $^

# 编译带波形的目标
$(TOP_MODULE)_wave: $(TB_FILE) $(SRC_FILES)
	iverilog -D DUMP_VCD -o $@ $^

# 使用 GTKWave 查看波形
gtkwave:
	gtkwave openmips_min_sopc.vcd

# 清理生成的文件
clean:
	cd ASM && make clean
	rm -f $(TOP_MODULE) $(TOP_MODULE)_wave openmips_min_sopc.vcd

# 显示帮助信息
help:
	@echo "Makefile for chapter04 simulation"
	@echo "Usage:"
	@echo "  make sim     - Compile and run simulation"
	@echo "  make wave    - Generate VCD wave file"
	@echo "  make asm     - Generate inst_rom.data file"
	@echo "  make gtkwave - Open wave file with GTKWave"
	@echo "  make clean   - Clean generated files"
	@echo "  make help    - Show this help message"