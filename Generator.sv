class generator;

  mailbox #(transcation) gen2drv;
  transcation trans;

  function new(mailbox #(transcation) gen2drv);
    this.gen2drv  = gen2drv;
  endfunction

  task send(transcation tr);
    tr.display("GENERATOR");
    gen2drv.put(tr);
  endtask

endclass
