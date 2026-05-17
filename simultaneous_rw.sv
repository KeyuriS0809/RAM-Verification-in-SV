class same_addr_wr extends single_write_read;

  transcation trans;
  bit [`ADDR_WIDTH-1:0] Pre_ADDR;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  //---------------- WRITE FULL FIFO = FULL OR NOT ?  ----------------
  task run();
    trans = new();
    env.test_run();
    $display("STARTS SIMULTANEOUS READ AND WRITE");
    trans.wr_enb = 1;
    trans.rd_enb = 1;
    trans.rd_addr.rand_mode(0);
    repeat (`DEPTH) begin
      files_pkg :: raise();
      Pre_ADDR = trans.wr_addr;
      void'(trans.randomize());
      trans.rd_addr = Pre_ADDR;
      env.gen.send(trans);
    end
    $display("END SIMULTANEOUS READ AND WRITE");
  endtask
endclass
