class walk_1 extends single_write_read;

  transcation trans;
  bit [`ADDR_WIDTH-1:0] Pre_ADDR;
  int i;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  //---------------- WRITE FULL FIFO = FULL OR NOT ?  ----------------
  task run();
    trans = new();
    env.test_run();
    $display("STARTS ADDRESS WALKING 0");
    trans.wr_enb = 1;
    trans.rd_enb = 1;
    repeat (5) begin
      files_pkg :: raise();
      Pre_ADDR = trans.wr_addr;
      trans.wr_addr = (1 << i);
      void'(trans.randomize(wr_data));
      trans.rd_addr = Pre_ADDR;
      env.gen.send(trans);
      i++; 
    end
    $display("ADDRESS WALKING 0 IS COMPLETED");
  endtask
endclass
