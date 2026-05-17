class sanity_test extends single_write_read;

  transcation trans;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  //---------------- WRITE FULL FIFO = FULL OR NOT ?  ----------------
  task run();
    env.test_run();
    trans = new();
    $display(" DOING SANITY TEST ");
    files_pkg :: raise();
    trans.wr_enb = 1; 
    trans.wr_addr = 4; 
    trans.wr_data = 30;
    env.gen.send(trans);

    files_pkg :: raise();
    trans.rd_enb  = 1;
    trans.rd_addr = 4;
    env.gen.send(trans);
    $display(" SANITY TEST IS COMPLETED");
  endtask
endclass
