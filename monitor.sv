
//Samples the interface signals, captures into transaction packet and send the packet to scoreboard.

class monitor;
  
  //creating virtual interface handle
  virtual mem_inf vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual mem_inf vif,mailbox mon2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();
      @(posedge vif.i_clk);
      @(posedge vif.i_clk);
      if (vif.i_reset == 0) begin
      trans.i_wb_cyc <= vif.i_wb_cyc;
      trans.i_wb_stb <= vif.i_wb_stb;
      trans.i_wb_we <= vif.i_wb_we;
      trans.i_wb_addr <= vif.i_wb_addr;
      trans.i_wb_data <= vif.i_wb_data;
      trans.i_wb_sel <= vif.i_wb_sel;
      trans.o_wb_stall   = vif.o_wb_stall;
      trans.o_wb_ack   = vif.o_wb_ack;
      trans.o_wb_data   = vif.o_wb_data;
        
        @(posedge vif.i_clk);
      mon2scb.put(trans);
      trans.display("[ Monitor ]");
      end
    end
  endtask
  
endclass