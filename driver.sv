
//gets the packet from generator and drive the transaction paket items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 

class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual mem_inf vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual mem_inf vif,mailbox gen2driv);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(vif.i_reset);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.i_wb_cyc <= 0;
    vif.i_wb_stb <= 0;
    vif.i_wb_we <= 0;
    vif.i_wb_addr <= 0;
    vif.i_wb_data <= 0;
    vif.i_wb_sel <= 0;
    wait(!vif.i_reset);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
  
  //drivers the transaction items to interface signals
  task main;
    forever begin
      transaction trans;
      gen2driv.get(trans);
//       vif.up_dwn <= 0;
//       trans.up_dwn <= 0;
      @(posedge vif.i_clk);
     
      vif.i_wb_cyc <= trans.i_wb_cyc;
      vif.i_wb_stb <= trans.i_wb_stb;
      vif.i_wb_we <= trans.i_wb_we;
      vif.i_wb_addr <= trans.i_wb_addr;
      vif.i_wb_data <= trans.i_wb_data;
      vif.i_wb_sel <= trans.i_wb_sel;
      
      @(posedge vif.i_clk);
      
      trans.o_wb_stall   = vif.o_wb_stall;
      trans.o_wb_ack   = vif.o_wb_ack;
      trans.o_wb_data   = vif.o_wb_data;
      
      
      @(posedge vif.i_clk);
      trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  
endclass