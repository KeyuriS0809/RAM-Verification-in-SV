class TEST;

  virtual intf vif;
  ENV env;

  function new(virtual intf vif);
    this.vif = vif;
    env = new(vif);
  endfunction

  task reset();
    vif.rst = 1;
    repeat (2)
      @(posedge vif.clk);
    vif.rst = 0;
    @(posedge vif.clk);
  endtask

  virtual task run();
  endtask

endclass
