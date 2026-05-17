class generator;

  mailbox #(transcation) gen2drv;
  transcation trans;
  event drv_done;

  function new(mailbox #(transcation) gen2drv, event drv_done);
    this.gen2drv  = gen2drv;
    this.drv_done = drv_done;
  endfunction

  task main();
    trans = new();
  endtask

  task send(transcation tr);
    tr.display("GENERATOR");
    gen2drv.put(tr);
    @(drv_done);
  endtask

endclass
