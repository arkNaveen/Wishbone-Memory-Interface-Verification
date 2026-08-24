

//including interfcae and testcase files
`include "interface.sv"
parameter DW = 32;
parameter AW = 3;
//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "random_test.sv"
//`include "directed_test.sv"
//----------------------------------------------------------------

module tbench_top;
  
  //clock and reset signal declaration
  bit i_clk;
  bit i_reset;
  //clock generation
  always #5 i_clk = ~i_clk;
  
  //reset Generation
  initial begin
    i_clk = 0;
    i_intf.i_reset = 1;
    #5 i_intf.i_reset=0;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  mem_inf i_intf(i_clk);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  wb_memory DUT(
    .i_clk(i_intf.i_clk),
    .i_reset(i_intf.i_reset),
    .i_wb_cyc(i_intf.i_wb_cyc),
    .i_wb_stb(i_intf.i_wb_stb),
    .i_wb_we(i_intf.i_wb_we),
    .i_wb_addr(i_intf.i_wb_addr),
    .i_wb_data(i_intf.i_wb_data),
    .i_wb_sel(i_intf.i_wb_sel),
    .o_wb_stall(i_intf.o_wb_stall),
    .o_wb_ack(i_intf.o_wb_ack),
    .o_wb_data(i_intf.o_wb_data)

    );
    
  //enabling the wave dump
  initial begin 
    $dumpfile("wbmem.vcd"); $dumpvars;
  end
endmodule