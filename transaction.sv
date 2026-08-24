
class transaction;
  
  rand logic i_reset;
  rand logic i_wb_cyc, i_wb_stb, i_wb_we;
  randc logic [2:0]	i_wb_addr;
  randc logic [31:0]	i_wb_data;
  randc logic [3:0]	i_wb_sel;
  rand logic	o_wb_stall;
  rand logic o_wb_ack;
  rand logic [3:0] o_wb_data;
static int no_of_xtn ;
  
  constraint VALID_RST {i_reset dist{ 1:=15,0:=15}; }

  constraint VALID_LOAD {i_wb_cyc <-> i_wb_stb; }

  constraint VALID_SEL {i_wb_sel == 4'b1111;}
  
  constraint VALID_READ {i_wb_we == 1;}
  //declaring the transaction items
   function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
     $display("- Read/Write_ = %0d, Address = %0d,  Data - %0d,  Select Pin = %0d ",i_wb_we,i_wb_addr,i_wb_data,i_wb_sel);
     $display("- Output Data = %0d",o_wb_data);
    $display("-------------------------");
  endfunction
endclass