class transcation;
  bit wr_enb, rd_enb;

  bit [`DATA_WIDTH-1:0] rd_data;

  randc bit [`ADDR_WIDTH-1:0] wr_addr;
  randc bit [`DATA_WIDTH-1:0] wr_data;
  randc bit [`ADDR_WIDTH-1:0] rd_addr;

  function void display(string name);
    $display("--------------------------- %s -----------------------------",name);
    $display("TIME = %0t\t | Write_En = %0d\t | Write Data = %0d\t | Write Addr = %0d\t |Read_En = %0d\t | Read Addr = %0d\t | Read Data = %0d",$time,wr_enb, wr_data,wr_addr,rd_enb,rd_addr,rd_data);
    $display("");
  endfunction
endclass
