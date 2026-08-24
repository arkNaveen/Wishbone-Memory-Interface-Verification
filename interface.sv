//Interface
interface mem_inf (input bit i_clk);
  logic i_reset;
  logic i_wb_cyc, i_wb_stb, i_wb_we;
  logic [2:0]	i_wb_addr;
  logic [31:0]	i_wb_data;
  logic [3:0]	i_wb_sel;
  logic	o_wb_stall;
  logic o_wb_ack;
  logic [2:0] o_wb_data;
  
  //Driver Clocking Block
  clocking driver_cb @ (posedge i_clk);
  default input #1 output #1;
  output i_reset;
  output i_wb_cyc, i_wb_stb, i_wb_we;
  output i_wb_addr;
  output i_wb_data;
  output i_wb_sel;
  endclocking
  // output monitor clocking block
  clocking output_mon_cb @ (posedge i_clk); default input #1 output #1 ;
  input o_wb_stall,o_wb_ack;
  input o_wb_data;
  endclocking
  //input monitor clocking block
  clocking input_mon_cb @ (posedge i_clk);
  default input #1 output #1;
  output i_reset;
  input i_wb_cyc, i_wb_stb, i_wb_we;
  input i_wb_addr;
  input i_wb_data;
  input i_wb_sel;
  endclocking
  //driver modport
  modport DRIVER (clocking driver_cb);
  //input Monitor modport
  modport INPUT_MON (clocking input_mon_cb);
  //Output monitor
  modport OUTPUT_MON (clocking output_mon_cb );

endinterface