class driver;
  transcation trans = new();

  mailbox #(transcation) gen2drv;
  virtual intf vif;
  event drv_done;

  function new(mailbox #(transcation) gen2drv, virtual intf vif, event drv_done);
    this.vif      = vif;
    this.gen2drv  = gen2drv;
    this.drv_done = drv_done;
  endfunction

  task main;
    forever begin
      gen2drv.get(trans);

      @(negedge vif.clk);

      if (vif.rst) begin
        vif.wr_enb  <= 0;
        vif.rd_enb  <= 0;
        vif.wr_addr <= 0;
        vif.wr_data <= 0;
        vif.rd_addr <= 0;
      end
      else  begin
        vif.wr_enb  <= trans.wr_enb;
        vif.rd_enb  <= trans.rd_enb;
        vif.wr_addr <= trans.wr_addr;
        vif.wr_data <= trans.wr_data;
        vif.rd_addr <= trans.rd_addr;
      end

      trans.display("DRIVER");

      @(posedge vif.clk);
      -> drv_done;
    end
  endtask
endclass
