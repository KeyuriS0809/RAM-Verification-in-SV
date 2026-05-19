class monitor;

  transcation trans;
  mailbox #(transcation) mon2score;
  virtual intf vif;

  function new (mailbox #(transcation) mon2score, virtual intf vif);
    this.mon2score = mon2score;
    this.vif = vif;
  endfunction

  task main;

    forever begin

      @(posedge vif.clk);
      @(negedge vif.clk);

      if (vif.i_reset)
        $display("----- TIME = %0t Reset Detected in Monitor",$time);
      else begin 
        trans = new();
      trans.wr_enb  = vif.wr_enb;
      trans.rd_enb  = vif.rd_enb;
      trans.wr_addr = vif.wr_addr;
      trans.wr_data = vif.wr_data;
      trans.rd_addr = vif.rd_addr;
      trans.rd_data = vif.rd_data;

      mon2score.put(trans);      
      trans.display("MONITOR");
    end
    end
  endtask
endclass
