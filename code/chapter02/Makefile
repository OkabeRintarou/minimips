# Makefile for MiniMIPS Chapter 2

# Variables
IVERILOG = iverilog
VVP = vvp
SIMULATOR = tb_inst_fetch
SOURCE_FILES = inst_fetch.v pc_reg.v rom.v
TESTBENCH = inst_fetch_tb.v
VCD_FILE = tb_inst_fetch.vcd
GTKWAVE = gtkwave

# Default target
all: sim

# Compile the simulation
sim: $(SOURCE_FILES) $(TESTBENCH)
	$(IVERILOG) -o $(SIMULATOR) $(SOURCE_FILES) $(TESTBENCH)

# Run the simulation
run: sim
	$(VVP) $(SIMULATOR)

# Generate and view waveform
wave: run
	$(VVP) $(SIMULATOR) -lxt2

# View waveform using GTKWave
gtkwave: wave
	$(GTKWAVE) $(VCD_FILE)

# Clean generated files
clean:
	rm -f $(SIMULATOR) $(VCD_FILE)

# Help information
help:
	@echo "Makefile for MiniMIPS Chapter 2 Simulation"
	@echo ""
	@echo "Available targets:"
	@echo "  all     - Compile and prepare simulation (default)"
	@echo "  sim     - Compile the simulation executable"
	@echo "  run     - Run the simulation"
	@echo "  wave    - Generate waveform file"
	@echo "  gtkwave - View waveform using GTKWave"
	@echo "  clean   - Remove generated files"
	@echo "  help    - Show this help message

.PHONY: all sim run clean help