`include "defines.v"
`timescale 1ns/1ps

module openmips_min_sopc_tb();

  reg     CLOCK_50;
  reg     rst;
  
  // 添加波形 dump
`ifdef DUMP_VCD
  initial begin
    $dumpfile("openmips_min_sopc.vcd");
    $dumpvars(0, openmips_min_sopc_tb);
  end
`endif

  // 显示仿真进度
  initial begin
    $display("Simulation started");
    #5000 $display("Simulation time: 5000ns");
    #5000 $display("Simulation time: 10000ns");
    #5000 $display("Simulation finished at time: %0t", $time);
    $finish;
  end
       
  initial begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin
    rst = `RstEnable;
    #195 rst = `RstDisable;
  end
       
  openmips_min_sopc openmips_min_sopc0(
    .clk(CLOCK_50),
    .rst(rst)	
  );

endmodule