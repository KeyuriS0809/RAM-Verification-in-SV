class ENV;
  generator gen;
  driver dri;
  monitor mon;
  scoreboard sb;

  event gen_done;
  mailbox #(transcation) gen2dri;
  mailbox #(transcation) mon2soc;

  virtual intf vif;

  function new (virtual intf vif);
    this.vif = vif;
    gen2dri = new();
    mon2soc = new();

    gen = new(gen2dri, gen_done);
    dri = new(gen2dri, vif, gen_done);
    mon = new(mon2soc, vif);
    sb  = new(mon2soc);
  endfunction

  task test_run;
    fork 
      //       gen.main();
      dri.main();
      mon.main();
      sb.main();
    join_none
    //     $finish;
  endtask
endclass
