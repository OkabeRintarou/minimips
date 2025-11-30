# Makefile for MIPS assembly compilation and conversion to Verilog hex format

# Tools
AS = mips-linux-gnu-as
LD = mips-linux-gnu-ld
OBJCOPY = mips-linux-gnu-objcopy
CXX = g++

# Files
ASM_SRC = inst_rom.S
ASM_OBJ = inst_rom.o
LINK_SCRIPT = ram.ld
ELF_FILE = inst_rom.elf
BIN_FILE = inst_rom.bin
HEX_FILE = inst_rom.data
BIN_TO_HEX_SRC = bin_to_hex.cpp
BIN_TO_HEX_EXE = bin_to_hex

# Default target
all: $(HEX_FILE)

# Compile bin_to_hex.cpp to executable
$(BIN_TO_HEX_EXE): $(BIN_TO_HEX_SRC)
	$(CXX) -o $(BIN_TO_HEX_EXE) $(BIN_TO_HEX_SRC)

# Compile assembly to object file
$(ASM_OBJ): $(ASM_SRC)
	$(AS) -mips32 $(ASM_SRC) -o $(ASM_OBJ)

# Link object file to ELF
$(ELF_FILE): $(ASM_OBJ)
	$(LD) -T $(LINK_SCRIPT) $(ASM_OBJ) -o $(ELF_FILE)

# Convert ELF to binary
$(BIN_FILE): $(ELF_FILE)
	$(OBJCOPY) -O binary $(ELF_FILE) $(BIN_FILE)

# Convert binary to Verilog hex format
$(HEX_FILE): $(BIN_FILE) $(BIN_TO_HEX_EXE)
	./$(BIN_TO_HEX_EXE) $(BIN_FILE) $(HEX_FILE)

# Clean generated files
clean:
	rm -f $(ASM_OBJ) $(ELF_FILE) $(BIN_FILE) $(HEX_FILE) $(BIN_TO_HEX_EXE)

# Rebuild everything
rebuild: clean all

.PHONY: all clean rebuild
