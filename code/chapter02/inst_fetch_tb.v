`timescale 1ns / 1ps

module tb_inst_fetch;

    // Clock period definition
    parameter CLK_PERIOD = 10;
    
    // Signal declarations
    reg clk;
    reg rst;
    wire [31:0] inst_o;
    
    // Instantiation of the unit under test
    inst_fetch uut (
        .clk(clk),
        .rst(rst),
        .inst_o(inst_o)
    );
    
    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;
    
    // Test process
    initial begin
        // Dump waveform
        $dumpfile("tb_inst_fetch.vcd");
        $dumpvars(0, tb_inst_fetch);
        
        // Initialize signals
        clk = 0;
        rst = 1;
        
        // Initialize ROM contents
        $readmemh("rom.hex", uut.rom0.rom);
        
        // Display header
        $display("Starting instruction fetch simulation...");
        $display("Time\tClock\tReset\tInstruction");
        $display("=====================================");
        
        // Reset phase
        #(CLK_PERIOD*2);
        $display("%0t\t%b\t%b\t0x%08h", $time, clk, rst, inst_o);
        
        // Release reset
        rst = 0;
        #(CLK_PERIOD);
        $display("%0t\t%b\t%b\t0x%08h", $time, clk, rst, inst_o);
        
        // Run 16 clock cycles to observe PC and instruction changes
        repeat(16) begin
            #(CLK_PERIOD);
            $display("%0t\t%b\t%b\t0x%08h", $time, clk, rst, inst_o);
        end
        
        // Assertion tests
        #(CLK_PERIOD);
        $display("=====================================");
        $display("Simulation finished after 16 instructions.");
        $fclose(0);
        $finish;
    end
    
    // Monitoring process
    initial begin
        $monitor("At time %0t: PC = %0h, Instruction = 0x%08h", $time, uut.pc_reg0.pc, inst_o);
    end
    
endmodule