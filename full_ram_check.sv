class full_ram_check extends single_write_read;

  transcation trans;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  //---------------- WRITE FULL FIFO = FULL OR NOT ?  ----------------
  task run();
    env.test_run();

    $display("FULL RAM CHECK STARTS");
    repeat (`DEPTH) begin
      write_ram();
      read_ram();
    end
    $display("FULL RAM CHECK COMPLETED");
  endtask
endclass
