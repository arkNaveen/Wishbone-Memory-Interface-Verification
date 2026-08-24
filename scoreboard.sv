
//gets the packet from monitor, Generated the expected result and compares with the //actual result recived from Monitor

class scoreboard;
   
  //creating mailbox handle
  mailbox mon2scb;
  
  //used to count the number of transactions
  int no_transactions;
  
    bit [7:0] data[256] = '{default:0};
  
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Compares the Actual result with the expected result
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      /*  Write Main scoreboard logic here;*/
      
      if (trans.i_wb_we)
        begin
          data[trans.i_wb_addr]=trans.i_wb_data;

          $display("-------------TEST PASSED --------");
          $display("Data : %0d Addr : %0d", trans.i_wb_data, 		trans.i_wb_addr);
        end
      else
        begin
          if (trans.o_wb_data==32'h11)
            begin
              $display("-------------TEST PASSED --------");
            end
          else if (trans.o_wb_data==data[trans.i_wb_addr])
            begin
              $display("-----------TEST PASSED-------------");
              $display("Data : %0d Address : %0d", trans.i_wb_data, trans.i_wb_addr);
            end
          else if (trans.o_wb_data==1)
            begin
              $display("-------------TEST FAILED-----------");
            end
        end

      if(trans.o_wb_ack) begin
        if(trans.i_wb_sel != 4'b1111)
          $display("Select Lines are'nt full, Data May be Corrupted");
        else 
          $display("Data Received");
      end
      else $display("No Output Data present as no acknowledgement is set");
      no_transactions++;
      trans.display("[ Scoreboard ]");
    end
  endtask
  
endclass