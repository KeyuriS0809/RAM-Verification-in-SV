class single_write_read extends TEST;

  transcation trans;

  function new (virtual intf vif);
    super.new(vif);
  endfunction

  extern task write_ram;
  extern task read_ram;
endclass

task single_write_read :: write_ram;
  files_pkg :: raise();
  trans = new();
  trans.rd_enb = 1;
  void'(trans.randomize());
  env.gen.send(trans);
  $display("TIME = %0t END WRITTING FIFO",$time);
endtask    


task single_write_read :: read_ram;
  files_pkg :: raise();
  trans = new();
  trans.wr_enb = 1;
  void'(trans.randomize());
  env.gen.send(trans);
  $display("END READING FIFO");
endtask
