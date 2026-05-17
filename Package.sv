package files_pkg;
  `define ADDR_WIDTH 4
  `define DEPTH 16
  `define DATA_WIDTH 8 

  int raise_cnt = 0;

  function void raise();
    raise_cnt++;
    $display("RAISE COUNT INC = %0d", raise_cnt);
  endfunction

  function void drop();
    raise_cnt--;
    $display("RAISE COUNT DEC = %0d", raise_cnt);
  endfunction 

  `include "Transaction.sv"
  `include "Generator.sv"
  `include "Driver.sv"
  `include "Monitor.sv"
  `include "ScoreBoard.sv"
  `include "ENV.sv"
  `include "Test.sv"

  // -------- TEST FILES ---------
  `include "single_write_read.sv"
  `include "sanity_test.sv"
  `include "full_ram_check.sv"
  `include "same_addr_wr.sv"
  `include "walk_0.sv"
  `include "walk_1.sv"

endpackage
