class scoreboard;

  transcation trans;
  mailbox #(transcation) mon2score;
  bit [`DATA_WIDTH-1:0] queue [$];
  reg [`DATA_WIDTH-1:0] mem [0:`DEPTH-1];
  bit [`DATA_WIDTH-1:0] DATA;


  function new (mailbox #(transcation) mon2score);
    this.mon2score = mon2score;
  endfunction

  task main;
    trans = new();

    forever begin 
      mon2score.get(trans);
      trans.display("SCORE BOARD");

      reference();
      files_pkg :: drop();
      $display("******************* TRANSACTION COMPLETE **********************\n\n");
    end
  endtask

  extern task reference();
endclass

task scoreboard::reference();
  begin
    $display("--------------------------- REFERENCE -------------------");
    if (trans.wr_enb) begin
      mem[trans.wr_addr] = trans.wr_data;
      $display("TIME = %0t\t | Write_En = %0d\t | Write Data = %0d\t | Write Addr = %0d\t |Read_En = %0d\t | Read Addr = %0d\t | Read Data = %0d",$time,trans.wr_enb, trans.wr_data, trans.wr_addr, trans.rd_enb, trans.rd_addr, DATA);
      $display("-------------------------- WRITE DONE ------------------------");
    end
    else $display("------------ WRITE ENABLE IS LOW ---------------");

    if (trans.rd_enb) begin
      DATA = mem[trans.rd_addr];
      $display("TIME = %0t\t | Write_En = %0d\t | Write Data = %0d\t | Write Addr = %0d\t |Read_En = %0d\t | Read Addr = %0d\t | Read Data = %0d",$time,trans.wr_enb, trans.wr_data, trans.wr_addr, trans.rd_enb, trans.rd_addr, DATA);
    end
    else $display("------------ READ ENABLE IS LOW ----------------");

    if (DATA == trans.rd_data)
      $display("------------------------ READ PASS ------------------------");
    else
      $display("------------------------ READ FAIL -------------------------");

    $display("------------------------------------------------------------");
  end
endtask
